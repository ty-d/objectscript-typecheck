# A Simple Experiment in Typechecking ObjectScript

## References
This uses a basic version of Hindley-Milner type inference (no support for polymorphism):
https://medium.com/@dhruvrajvanshi/type-inference-for-beginners-part-1-3e0a5be98a4b
https://gist.github.com/wongjiahau/5786df6e7dc6a8346bf3ed8439b82470

## Motivation
Type inference could be useful considering how often type annotations are used in ObjectScript method definitions. It could eliminate some common mistakes and remove the problem of the method definition only being for the programmer's reference rather than being enforced like in TypeScript or other statically typed languages. Could also require ByRef and Output parameters to be passed as such. AST's are also useful for formatters and other projects that need to parse code.

## What it can do
Takes the tokens from a method (produced by %SyntaxColorReader) and assembles a (very incomplete) Abstract Syntax Tree for if statements and quit statements only.
It assembles an expression that can be the following:
- a variable
- variable = variable
- a number

Variable names are currently hard-coded as pInt, pBool, and "ret" for the return type.

It is essentially limited to the small "Infer" method in the supplied class.
pBool is inferred to be of "Bool" type and pInt is inferred to be "Int". "ret" (the hard-coded return variable) is inferred as an "Int".
Attempting to return pBool and a number will result in a type error.

## How to use
Either use the included tokens.txt or generate your own (note it can only handle slightly modified versions of Infer) by loading TypeCheck.cls onto an IRIS instance and changing the path at the bottom of Tokenize to the corresponding path to tokens.txt

If you've never used Haskell or Cabal get up and running with gchup, and then run the following commands in this project folder:

```
cabal install
cabal run
```

## Why Haskell?
I had a short time to experiment with this and had a little experience parsing with Haskell for fun. It could probably be translated to ObjectScript without too much issue.

## In case of future exploration
- Currently uses the %SyntaxColorReader as a lexer, and then assembles a very basic AST based on the example. A parser generator would be a better choice: e.g. Happy (https://www.haskell.org/happy/).
- To be practical would likely need some equivalent to TypeScript's any type so that dynamic typing can be opt-in.
- also on github (possibly more up to date): https://github.com/ty-d/objectscript-typecheck