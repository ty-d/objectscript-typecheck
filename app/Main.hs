module Main where

import Parser
import ParserTypes
import Inferer
import qualified Data.Map as Map
import Data.List
import qualified Data.Bifunctor (second)
import Debug.Trace

main :: IO ()
main = do
    --let commands = reverse $ pleaseParsePlease stuffToParse
    --print commands
    --putStrLn ""

    --let args = [("pBool", typeBool), ("pInt", typeInt)]
    --print args
    --putStrLn ""

    --print $ inferTypesForFunction args typeInt commands

    -- stuff for tokens v2
    content <- readFile "tokens.txt"

    let splitAtComma s = case elemIndex ',' s of
            Just x ->
                let splitVer = splitAt x s
                in Data.Bifunctor.second tail splitVer
            Nothing -> ([], [])

    let processed = map splitAtComma (lines content)

    let processed2 = groupBy (\a b -> fst a /= "method" && fst b /= "method") processed
    let methods = parseMethods processed2
    mapM_ printForMethod methods

printForMethod :: (String, [Command]) -> IO ()
printForMethod meth =
    print typechecked where
        (name, commands) = meth
        args = [("pDateTime", typeString)]
        typechecked = inferTypesForFunction args typeString commands

parseMethods :: [[(String, String)]] -> [(String, [Command])]
parseMethods (a:b:xs) =
    (snd $ head a, commands) : parseMethods xs
        where
            --tokenizePrinter a = trace (show a) (tokenize a)
            mapped = map tokenize b
            commands = pleaseParsePlease mapped
parseMethods _ = []