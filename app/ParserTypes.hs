module ParserTypes where

-- The types that will be emmitted by the parser
type VarName = String

data Command
    = Set VarName Exp
    | If Exp [Command]
    | ElseIf Exp [Command]
    | Quit Exp
    deriving Show

data Exp
    = Var VarName
    | Num Int
    | String String
    | Equals Exp Exp
    | Concat Exp Exp
    | Func String [FuncArg]
    deriving Show

data FuncArg
    = Exp Exp
    | Two Exp Exp
    | Default Exp
    deriving Show

newtype Postcondition = Postcondition Exp
    deriving Show

-- The token type expected by the parser
data Token
    = TSet
    | TIf
    | TElse
    | TElseIf
    | TNumber Int
    | TString String
    | TVar String
    | TEq
    | TOpBracket
    | TClBracket
    | TQuit
    | TColon
    | TOpenParen
    | TCloseParen
    | TFunc String
    | TComma
    | TConcat
    deriving Show

-- for testing:
stuffToParse :: [Token]
stuffToParse =
    [TIf, TVar "pInt", TEq, TNumber 10, TOpBracket, TQuit, TNumber 5, TClBracket, TElseIf, TVar "pBool", TOpBracket, TQuit, TVar "pInt", TClBracket]

-- required
parseError :: [Token] -> a
parseError _ = error "Parse error"

tokenize :: (String, String) -> Token
tokenize ("Command", "Quit") = TQuit
tokenize ("Delimiter", ":") = TColon
tokenize ("Delimiter", "(") = TOpenParen
tokenize ("Delimiter", ")") = TCloseParen
tokenize ("Delimiter", ")") = TCloseParen
tokenize ("Local variable", a) = TVar a
tokenize ("Operator", "=") = TEq
tokenize ("String", a) = TString a
tokenize ("Command", "Set") = TSet
tokenize ("Function", a) = TFunc a
tokenize ("Delimiter", ",") = TComma
tokenize ("Operator", "_") = TConcat

tokenize _ = undefined
