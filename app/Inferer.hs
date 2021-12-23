module Inferer where

import qualified Data.Map as Map
import ParserTypes
import Data.Maybe
import Control.Monad.State
import Control.Monad.Except
import Debug.Trace

newtype KnownType = KnownType String
    deriving (Show, Eq)

-- The type of stuff
data Type
    = Known KnownType
    | Unknown Int
    deriving (Show, Eq)

typeInt, typeBool, typeNull, typeString :: Type
typeInt = Known $ KnownType "Int"
typeBool = Known $ KnownType "Bool"
typeNull = Known $ KnownType "Null"
typeString = Known $ KnownType "String"

-- Type errors
data TypeError
    = ErrUnboundVar VarName
    | ErrTypeMismatch Type Type
    | ErrVarSelfRef VarName Type
    | LogicalErr
    deriving Show

type Bindings = Map.Map VarName Type

data InferState = InferState {
    typeVarCounter :: Int,
    bindings :: Bindings,
    returnType :: Type
}

-- Possibly refactor to use MaybeT instead, might fit this inferer better?
type Infer a = ExceptT TypeError (State InferState) a

-- High Level Functions
inferTypesForFunction :: [(VarName, Type)] -> Type -> [Command] -> (Maybe TypeError, Bindings)
inferTypesForFunction args retType cmds =
    let
        startingState = InferState {
            typeVarCounter = 0,
            bindings = Map.fromList args,
            returnType = retType
        }
        (error, state) = runInfer (processCommands cmds) startingState
    in
        (error, bindings state)

runInfer :: Infer () -> InferState -> (Maybe TypeError, InferState)
runInfer m startingState =
    let
        monadResult = runState (runExceptT m) startingState
        state = snd monadResult
    in
        case fst monadResult of
            Left err -> (Just err, state)
            Right _ -> (Nothing, state)

processCommands :: [Command] -> Infer ()
processCommands (c:cmds) = case c of
    Set s exp -> do
        expType <- inferExp exp
        addBinding s expType

    If exp coms -> do
        expType <- inferExp exp
        unify expType typeBool
        processCommands coms
        processCommands cmds

    ElseIf exp coms -> do
        expType <- inferExp exp
        unify expType typeBool
        processCommands coms
        processCommands cmds

    Quit exp -> do
        expType <- inferExp exp
        currState <- get
        unify expType (returnType currState)

processCommands [] = return ()

-- Inference Functions
inferExp :: Exp -> Infer Type
inferExp exp = do
    currState <- get
    let nothing = trace ("curr bindings:" ++ show (bindings currState)) (bindings currState)
    case trace ("curr exp:" ++ show exp) exp of
        Var name ->
            --case Map.lookup name (bindings currState) of
            case Map.lookup name nothing of
                Just typ -> return typ
                Nothing -> throwError $ ErrUnboundVar name
        
        Num n -> return typeInt

        Equals exp1 exp2 -> do
            leftType <- inferExp exp1
            rightType <- inferExp exp2
            let l = trace (show leftType) leftType
            let r = trace (show rightType) rightType
            --unify leftType rightType
            unify l r
            return typeBool
        
        String s ->
            if s == "\"\""
                then return typeNull
                else return typeString
        
        Concat exp1 exp2 -> return typeString -- will need to make sure not obj in future

        Func "$CASE" args ->
            case head args of
                Exp exp -> do
                    expType <- inferExp exp
                    -- TODO: some verificatoin that its not an obj
                    --let somefunc a = case a of
                            --Exp exp -> throwError $ ErrUnboundVar "uh oh again"
                            --Two exp1 exp2 -> return (inferExp exp1, inferExp exp2)
                            --Default exp1 -> return (return typeNull, inferExp exp1)
                    return expType -- temporary
                _ -> throwError $ ErrUnboundVar "hey, you messed up case syntax"
        Func _ _ -> return typeString
        


unify :: Type -> Type -> Infer ()
unify typ1 typ2 =
    case typ1 of
        Known t1 ->
            case typ2 of
                Known t2 ->
                    if t1 == t2
                        then return ()
                        else throwError $ ErrTypeMismatch typ1 typ2
                Unknown t2 -> substitute typ2 typ1
        
        Unknown typVar ->
            case typ2 of
                Known t2 -> substitute typ1 typ2
                Unknown t2 -> substitute typ1 typ2

-- Helpers
addBinding :: VarName -> Type -> Infer ()
addBinding name typ = do
    currState <- get
    put currState { bindings = Map.insert name typ (bindings currState) }

newTypeVariable :: Infer Type
newTypeVariable = do
    currState <- get
    let num = typeVarCounter currState + 1
    put currState { typeVarCounter = num }
    return $ Unknown num

substitute :: Type -> Type -> Infer ()
substitute typ1 typ2 = do
    currState <- get
    let currBindings = bindings currState
    let func k = if k == typ1
            then typ2
            else k
    let newBindings = Map.map func currBindings
    put currState { bindings = newBindings }
