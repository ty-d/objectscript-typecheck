module Main where

import Control.Monad.Identity (Identity)
import qualified Data.Map as Map
import Data.Maybe
import Debug.Trace
import Text.Parsec
import Text.Printf (printf)

main :: IO ()
main = do
  let source = "tokens.txt"
  fileContents <- readFile source
  let result = parse line source fileContents
  case result of
    Right v -> do
      let parsed = parseCommands $ transform v
      putStrLn $ "success" ++ show parsed
      let ast = map parseTokens parsed
      print ast
      putStrLn ""
      let run = inferAll ast
      print run
      putStrLn ""
      case run of
        Left err -> print ""
        Right (ty, sub, ctx) -> printInferredFromContext ctx
    Left err -> putStrLn $ "error" ++ show err

printInferredFromContext :: Context -> IO ()
printInferredFromContext (Context _ env) =
  mapM_ printPair (Map.assocs env)
  where
    printPair (name, TypeNamed ty) = putStrLn $ "Var: " ++ name ++ " has type: " ++ show ty
    printPair _ = putStr ""

parseTokens :: (CommandToken, [Token]) -> Command
parseTokens (comTok, toks) = Command (parseCommandToken comTok) (parseExpr toks)

parseExpr :: [Token] -> Expr
parseExpr [tok] = case tok of
  TVar name -> EVar name
  TLit lt -> case lt of
    TString -> error "strings not implemented"
    TNumber -> EInt 0 -- this value actually needs to be propogated
  _ -> error "token error, should be either a var or a lit right now"
parseExpr [a, TOp TEq, c] =
  EFuncCall (EFuncCall (EVar "=") (parseExpr [a])) (parseExpr [c])
parseExpr anything = traceShow anything (error "lots hasn't been implemented")

type Ast = [Command]

type Env = Map.Map String Type

type Substitution = Map.Map String Type

data Context = Context Int Env
  deriving (Show)

data Type = TypeNamed String | TypeVar String | TypeFunc Type Type
  deriving (Show)

data Expr
  = EInt Int
  | EVar String
  | EFunc String Expr
  | EFuncCall Expr Expr
  deriving (Show)

data CommandType = Quit | If | ElseIf | Else
  deriving (Show)

data Command = Command CommandType Expr
  deriving (Show)

data Err = ErrUnboundVar String | ErrTypeMismatch Type Type | ErrVarSElfRef String Type | LogicalErr
  deriving (Show)

data Op = Eq | LessThan
  deriving (Show)

applySubstToCtx :: Substitution -> Context -> Context
applySubstToCtx subst (Context currNum env) =
  let newEnv = Map.map (applySubstToType subst) env
   in Context currNum newEnv

addUntypedVar :: Context -> String -> Context
addUntypedVar ctx name =
  let (newctx, newType) = createNewTVar ctx
   in addNewBindingToContext newctx name newType

inferAll :: [Command] -> Either Err (Type, Substitution, Context)
inferAll es = do
  let initialEnv = Map.insert "=" (TypeFunc (TypeNamed "Int") (TypeFunc (TypeNamed "Int") (TypeNamed "Bool"))) (Map.empty :: Env)
  let ctx = Context 0 initialEnv
  let newctx = addUntypedVar ctx "pInt"
  let a = addUntypedVar newctx "ret"
  let newctx2 = addUntypedVar a "pBool"

  inferAll' newctx2 es
  where
    inferAll' ctx ((Command ct e) : es) = do
      case ct of
        If -> do
          --(sometype, subst, ctx2) <- infer (trace ("calling infer: " ++ show ctx) ctx) e
          (sometype, subst, ctx2) <- infer ctx e
          subst2 <- unify sometype (TypeNamed "Bool")
          let ctx3 = applySubstToCtx (composeSubst subst subst2) ctx2
          if null es
            then Right (sometype, subst2, ctx3)
            else inferAll' ctx3 es
        ElseIf -> do
          --(sometype, subst, ctx2) <- infer (trace ("calling infer: " ++ show ctx) ctx) e
          (sometype, subst, ctx2) <- infer ctx e
          subst2 <- unify sometype (TypeNamed "Bool")
          let ctx3 = applySubstToCtx (composeSubst subst subst2) ctx2
          if null es
            then Right (sometype, subst2, ctx3)
            else inferAll' ctx3 es
        Else -> Right (TypeNamed "", Map.empty, ctx)
        Quit -> do
          (sometype, subst, ctx2@(Context num env)) <- infer ctx e
          case Map.lookup "ret" env of
            Nothing -> error "return type not set"
            Just ty -> do
              subst2 <- unify sometype ty
              let ctx3 = applySubstToCtx (composeSubst subst subst2) ctx2
              if null es
                then Right (sometype, subst2, ctx3)
                else inferAll' ctx3 es
    inferAll' ctx [] = Left LogicalErr

infer :: Context -> Expr -> Either Err (Type, Substitution, Context)
infer ctx@(Context _ env) expr =
  case expr of
    EInt {} -> Right (TypeNamed "Int", Map.empty, ctx)
    EVar name -> case Map.lookup name env of
      Just t -> Right (t, Map.empty, ctx)
      Nothing -> Left (ErrUnboundVar name)
    EFunc paramName body -> do
      let (ctx1, newTVar) = createNewTVar ctx
      let funcParamType = newTVar
      let ctx2 = addNewBindingToContext ctx1 paramName newTVar
      (inferredBodyType, subst, ctx3) <- infer ctx2 body
      let inferredFuncParamType = applySubstToType subst funcParamType
      Right (TypeFunc inferredFuncParamType inferredBodyType, subst, ctx3)
    EFuncCall func arg -> do
      (funcType, s1, ctx2) <- infer ctx func
      (argType, s2, ctx3) <- infer ctx2 arg
      let s3 = composeSubst s1 s2
      case funcType of
        TypeFunc inputType outputType -> do
          s4 <- unify inputType argType
          let s5 = composeSubst s3 s4
          Right (applySubstToType s5 outputType, s5, ctx3)
        _ -> Left (ErrTypeMismatch (TypeFunc argType (snd $ createNewTVar ctx)) funcType)

applySubstToType :: Substitution -> Type -> Type
applySubstToType subst type' = case type' of
  TypeNamed _ -> type'
  TypeVar name ->
    Data.Maybe.fromMaybe type' (Map.lookup name subst)
  TypeFunc from to ->
    TypeFunc (applySubstToType subst from) (applySubstToType subst to)

addNewBindingToContext :: Context -> String -> Type -> Context
addNewBindingToContext (Context nextInt env) varname type' =
  Context nextInt (Map.insert varname type' env)

createNewTVar :: Context -> (Context, Type)
createNewTVar (Context nextInt env) =
  (Context (nextInt + 1) env, TypeVar ("T$" ++ show nextInt))

unify :: Type -> Type -> Either Err Substitution
unify t1 t2 =
  --case trace ("unify with types:" ++ show t1 ++ show t2) t1 of
  case t1 of
    TypeNamed l -> unifyLit l t2
    TypeVar name -> unifyVar name t2
    TypeFunc arg body -> unifyFunc arg body t2

unifyFunc :: Type -> Type -> Type -> Either Err Substitution
unifyFunc arg body t2 =
  case t2 of
    TypeFunc arg' body' -> do
      subst1 <- unify arg arg'
      subst2 <- unify (applySubstToType subst1 body) (applySubstToType subst1 body')
      Right (composeSubst subst1 subst2)
    TypeVar name -> unifyVar name (TypeFunc arg body)
    TypeNamed _ -> Left (ErrTypeMismatch (TypeFunc arg body) t2)

composeSubst :: Substitution -> Substitution -> Substitution
composeSubst s1 s2 =
  let result = foldl (\subst (key, type') -> Map.insert key (applySubstToType s1 type') subst) Map.empty (Map.assocs s2 :: [(String, Type)])
   in Map.union s1 result

unifyVar :: String -> Type -> Either Err Substitution
unifyVar name1 t2 =
  case t2 of
    TypeVar name2 ->
      if name1 == name2
        then Right Map.empty
        else Right (Map.insert name1 t2 Map.empty)
    _ ->
      if t2 `contains` name1
        then Left (ErrVarSElfRef name1 t2)
        else Right (Map.insert name1 t2 Map.empty)

contains :: Type -> String -> Bool
t `contains` tvarname =
  case t of
    TypeVar name -> name == tvarname
    TypeFunc inT outT -> inT `contains` tvarname || outT `contains` tvarname
    _ -> False

unifyLit :: String -> Type -> Either Err Substitution
unifyLit name1 t2 =
  let err = ErrTypeMismatch (TypeNamed name1) t2
   in case t2 of
        TypeNamed name2 ->
          if name1 == name2
            then Right Map.empty
            else Left err
        TypeVar name -> unifyVar name (TypeNamed name1)
        _ -> Left err

------------------------------------------------------------------------------
-- stuff responsible for going from the text file of tokens to the expressions
------------------------------------------------------------------------------
parseCommands :: [Token] -> [(CommandToken, [Token])]
parseCommands ts =
  parseCommands' ts []
  where
    parseCommands' (t : ts) acc =
      case t of
        TCommand cTok ->
          let indx = nextCommandIdx ts
              (before, after) = splitAt indx ts
           in parseCommands' after (acc ++ [(cTok, before)])
        TNone -> acc
        _ -> error "didn't start with command?"
    parseCommands' [] acc = acc

nextCommandIdx ts =
  next' ts 0
  where
    next' (t : ts) acc =
      case t of
        TCommand _ -> acc
        TNone -> acc
        _ -> next' ts (acc + 1)
    next' [] acc = 0

line = sepBy cell $ char ','

cell = many $ noneOf ",\n"

transform :: [String] -> [Token]
transform (x : y : xs) =
  tokenize x y : transform xs
transform [x] = [TNone]
transform [] = []

tokenize :: String -> String -> Token
tokenize commandType val
  | commandType == "Command" && val == "if" = TCommand TIf
  | commandType == "Command" && val == "quit" = TCommand TQuit
  | commandType == "Local variable" = TVar val
  | commandType == "Operator" && val == "=" = TOp TEq
  | commandType == "Number" = TLit TNumber
  | commandType == "Brace" = TBrace $ if val == "{" then Open else Close
  | commandType == "Command" && val == "else" = TCommand TElse
  | commandType == "Command" && val == "elseif" = TCommand TElseIf
  | commandType == "String" = TLit TString
  | otherwise = TNone

data OpenClose = Open | Close
  deriving (Show)

data CommandToken
  = TIf
  | TElse
  | TElseIf
  | TQuit
  deriving (Show)

data LitToken
  = TString
  | TNumber
  deriving (Show)

data OpToken
  = TEq
  deriving (Show)

data Token
  = TCommand CommandToken
  | TVar String
  | TBrace OpenClose
  | TLit LitToken
  | TOp OpToken
  | TNone
  deriving (Show)

-- This is really dumb but a quick fix, should eliminate token step?
parseCommandToken :: CommandToken -> CommandType
parseCommandToken tok =
  case tok of
    TIf -> If
    TElse -> Else
    TElseIf -> ElseIf
    TQuit -> Quit
