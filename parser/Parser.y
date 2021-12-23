{
module Parser where

import ParserTypes
}

%name pleaseParsePlease
%tokentype { Token }
%error { parseError }

%token
    set                             { TSet }
    if                              { TIf }
    else                            { TElse }
    elseif                          { TElseIf }
    number                          { TNumber $$ }
    quit                            { TQuit }
    var                             { TVar $$ }
    '='                             { TEq }
    '{'                             { TOpBracket }
    '}'                             { TClBracket }
    string                          { TString $$ }
    '_'                             { TConcat }
    ':'                             { TColon }
    '('                             { TOpenParen }
    ')'                             { TCloseParen }
    func                            { TFunc $$ }
    ','                             { TComma }
%%

Commands
    : Command                       { [$1] }
    | Commands Command              { $1 ++ [$2] }

Command
    : set Postcondition var '=' Exp               { Set $3 $5 }
    | set var '=' Exp                             { Set $2 $4 }
    | if Exp '{' Commands '}'                     { If $2 $4 }
    | elseif Exp '{' Commands '}'                 { ElseIf $2 $4 }
    | quit Exp                                    { Quit $2 }
    | quit Postcondition Exp                      { Quit $3 }

Postcondition
    : ':' var           { Postcondition (Var $2) }
    | ':' '(' Exp ')'   { Postcondition $3 }

Exp
    : Exp '=' Exp                   { Equals $1 $3 }
    | var                           { Var $1 }
    | number                        { Num $1 }
    | string                        { String $1 }
    | Exp '_' Exp                   { Concat $1 $3}
    | func '(' Args ')'             { Func $1 $3 }

Args
    : Arg            { [$1] }
    | Args ',' Arg   { $1 ++ [$3] }

Arg
    : Exp           { Exp $1 }
    | Exp ':' Exp   { Two $1 $3 }
    | ':' Exp       { Default $2 }