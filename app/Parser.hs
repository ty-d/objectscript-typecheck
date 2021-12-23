{-# OPTIONS_GHC -w #-}
module Parser where

import ParserTypes
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.20.0

data HappyAbsSyn t4 t5 t6 t7 t8 t9
	= HappyTerminal (Token)
	| HappyErrorToken Prelude.Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8
	| HappyAbsSyn9 t9

happyExpList :: Happy_Data_Array.Array Prelude.Int Prelude.Int
happyExpList = Happy_Data_Array.listArray (0,101) ([22016,0,688,0,0,0,65,35328,16,33872,32768,1186,2752,0,0,0,2117,16384,4,0,0,0,0,0,512,1,2048,0,19,38912,0,32,0,2,35328,16,128,32768,1058,2752,0,2208,45057,2,10240,74,0,0,4234,32768,8,17408,2,1568,0,640,0,0,16936,44032,8,0,0,555,0,0,5120,33,4352,0,136,0,0,0,0,272,0,0,41600,4,8468,0,0,34816,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_pleaseParsePlease","Commands","Command","Postcondition","Exp","Args","Arg","set","if","else","elseif","number","quit","var","'='","'{'","'}'","string","'_'","':'","'('","')'","func","','","%eof"]
        bit_start = st Prelude.* 27
        bit_end = (st Prelude.+ 1) Prelude.* 27
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..26]
        token_strs_expected = Prelude.concatMap f bits_indexed
        f (Prelude.False, _) = []
        f (Prelude.True, nr) = [token_strs Prelude.!! nr]

action_0 (10) = happyShift action_3
action_0 (11) = happyShift action_4
action_0 (13) = happyShift action_5
action_0 (15) = happyShift action_6
action_0 (4) = happyGoto action_7
action_0 (5) = happyGoto action_2
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (10) = happyShift action_3
action_1 (11) = happyShift action_4
action_1 (13) = happyShift action_5
action_1 (15) = happyShift action_6
action_1 (5) = happyGoto action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyReduce_1

action_3 (16) = happyShift action_19
action_3 (22) = happyShift action_14
action_3 (6) = happyGoto action_18
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (14) = happyShift action_11
action_4 (16) = happyShift action_12
action_4 (20) = happyShift action_13
action_4 (25) = happyShift action_15
action_4 (7) = happyGoto action_17
action_4 _ = happyFail (happyExpListPerState 4)

action_5 (14) = happyShift action_11
action_5 (16) = happyShift action_12
action_5 (20) = happyShift action_13
action_5 (25) = happyShift action_15
action_5 (7) = happyGoto action_16
action_5 _ = happyFail (happyExpListPerState 5)

action_6 (14) = happyShift action_11
action_6 (16) = happyShift action_12
action_6 (20) = happyShift action_13
action_6 (22) = happyShift action_14
action_6 (25) = happyShift action_15
action_6 (6) = happyGoto action_9
action_6 (7) = happyGoto action_10
action_6 _ = happyFail (happyExpListPerState 6)

action_7 (10) = happyShift action_3
action_7 (11) = happyShift action_4
action_7 (13) = happyShift action_5
action_7 (15) = happyShift action_6
action_7 (27) = happyAccept
action_7 (5) = happyGoto action_8
action_7 _ = happyFail (happyExpListPerState 7)

action_8 _ = happyReduce_2

action_9 (14) = happyShift action_11
action_9 (16) = happyShift action_12
action_9 (20) = happyShift action_13
action_9 (25) = happyShift action_15
action_9 (7) = happyGoto action_29
action_9 _ = happyFail (happyExpListPerState 9)

action_10 (17) = happyShift action_22
action_10 (21) = happyShift action_24
action_10 _ = happyReduce_7

action_11 _ = happyReduce_13

action_12 _ = happyReduce_12

action_13 _ = happyReduce_14

action_14 (16) = happyShift action_27
action_14 (23) = happyShift action_28
action_14 _ = happyFail (happyExpListPerState 14)

action_15 (23) = happyShift action_26
action_15 _ = happyFail (happyExpListPerState 15)

action_16 (17) = happyShift action_22
action_16 (18) = happyShift action_25
action_16 (21) = happyShift action_24
action_16 _ = happyFail (happyExpListPerState 16)

action_17 (17) = happyShift action_22
action_17 (18) = happyShift action_23
action_17 (21) = happyShift action_24
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (16) = happyShift action_21
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (17) = happyShift action_20
action_19 _ = happyFail (happyExpListPerState 19)

action_20 (14) = happyShift action_11
action_20 (16) = happyShift action_12
action_20 (20) = happyShift action_13
action_20 (25) = happyShift action_15
action_20 (7) = happyGoto action_40
action_20 _ = happyFail (happyExpListPerState 20)

action_21 (17) = happyShift action_39
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (14) = happyShift action_11
action_22 (16) = happyShift action_12
action_22 (20) = happyShift action_13
action_22 (25) = happyShift action_15
action_22 (7) = happyGoto action_38
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (10) = happyShift action_3
action_23 (11) = happyShift action_4
action_23 (13) = happyShift action_5
action_23 (15) = happyShift action_6
action_23 (4) = happyGoto action_37
action_23 (5) = happyGoto action_2
action_23 _ = happyFail (happyExpListPerState 23)

action_24 (14) = happyShift action_11
action_24 (16) = happyShift action_12
action_24 (20) = happyShift action_13
action_24 (25) = happyShift action_15
action_24 (7) = happyGoto action_36
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (10) = happyShift action_3
action_25 (11) = happyShift action_4
action_25 (13) = happyShift action_5
action_25 (15) = happyShift action_6
action_25 (4) = happyGoto action_35
action_25 (5) = happyGoto action_2
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (14) = happyShift action_11
action_26 (16) = happyShift action_12
action_26 (20) = happyShift action_13
action_26 (22) = happyShift action_34
action_26 (25) = happyShift action_15
action_26 (7) = happyGoto action_31
action_26 (8) = happyGoto action_32
action_26 (9) = happyGoto action_33
action_26 _ = happyFail (happyExpListPerState 26)

action_27 _ = happyReduce_9

action_28 (14) = happyShift action_11
action_28 (16) = happyShift action_12
action_28 (20) = happyShift action_13
action_28 (25) = happyShift action_15
action_28 (7) = happyGoto action_30
action_28 _ = happyFail (happyExpListPerState 28)

action_29 (17) = happyShift action_22
action_29 (21) = happyShift action_24
action_29 _ = happyReduce_8

action_30 (17) = happyShift action_22
action_30 (21) = happyShift action_24
action_30 (24) = happyShift action_48
action_30 _ = happyFail (happyExpListPerState 30)

action_31 (17) = happyShift action_22
action_31 (21) = happyShift action_24
action_31 (22) = happyShift action_47
action_31 _ = happyReduce_19

action_32 (24) = happyShift action_45
action_32 (26) = happyShift action_46
action_32 _ = happyFail (happyExpListPerState 32)

action_33 _ = happyReduce_17

action_34 (14) = happyShift action_11
action_34 (16) = happyShift action_12
action_34 (20) = happyShift action_13
action_34 (25) = happyShift action_15
action_34 (7) = happyGoto action_44
action_34 _ = happyFail (happyExpListPerState 34)

action_35 (10) = happyShift action_3
action_35 (11) = happyShift action_4
action_35 (13) = happyShift action_5
action_35 (15) = happyShift action_6
action_35 (19) = happyShift action_43
action_35 (5) = happyGoto action_8
action_35 _ = happyFail (happyExpListPerState 35)

action_36 (17) = happyShift action_22
action_36 (21) = happyShift action_24
action_36 _ = happyReduce_15

action_37 (10) = happyShift action_3
action_37 (11) = happyShift action_4
action_37 (13) = happyShift action_5
action_37 (15) = happyShift action_6
action_37 (19) = happyShift action_42
action_37 (5) = happyGoto action_8
action_37 _ = happyFail (happyExpListPerState 37)

action_38 (17) = happyShift action_22
action_38 (21) = happyShift action_24
action_38 _ = happyReduce_11

action_39 (14) = happyShift action_11
action_39 (16) = happyShift action_12
action_39 (20) = happyShift action_13
action_39 (25) = happyShift action_15
action_39 (7) = happyGoto action_41
action_39 _ = happyFail (happyExpListPerState 39)

action_40 (17) = happyShift action_22
action_40 (21) = happyShift action_24
action_40 _ = happyReduce_4

action_41 (17) = happyShift action_22
action_41 (21) = happyShift action_24
action_41 _ = happyReduce_3

action_42 _ = happyReduce_5

action_43 _ = happyReduce_6

action_44 (17) = happyShift action_22
action_44 (21) = happyShift action_24
action_44 _ = happyReduce_21

action_45 _ = happyReduce_16

action_46 (14) = happyShift action_11
action_46 (16) = happyShift action_12
action_46 (20) = happyShift action_13
action_46 (22) = happyShift action_34
action_46 (25) = happyShift action_15
action_46 (7) = happyGoto action_31
action_46 (9) = happyGoto action_50
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (14) = happyShift action_11
action_47 (16) = happyShift action_12
action_47 (20) = happyShift action_13
action_47 (25) = happyShift action_15
action_47 (7) = happyGoto action_49
action_47 _ = happyFail (happyExpListPerState 47)

action_48 _ = happyReduce_10

action_49 (17) = happyShift action_22
action_49 (21) = happyShift action_24
action_49 _ = happyReduce_20

action_50 _ = happyReduce_18

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 ([happy_var_1]
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_2  4 happyReduction_2
happyReduction_2 (HappyAbsSyn5  happy_var_2)
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1 ++ [happy_var_2]
	)
happyReduction_2 _ _  = notHappyAtAll 

happyReduce_3 = happyReduce 5 5 happyReduction_3
happyReduction_3 ((HappyAbsSyn7  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TVar happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (Set happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_4 = happyReduce 4 5 happyReduction_4
happyReduction_4 ((HappyAbsSyn7  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TVar happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (Set happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_5 = happyReduce 5 5 happyReduction_5
happyReduction_5 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (If happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_6 = happyReduce 5 5 happyReduction_6
happyReduction_6 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (ElseIf happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_7 = happySpecReduce_2  5 happyReduction_7
happyReduction_7 (HappyAbsSyn7  happy_var_2)
	_
	 =  HappyAbsSyn5
		 (Quit happy_var_2
	)
happyReduction_7 _ _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_3  5 happyReduction_8
happyReduction_8 (HappyAbsSyn7  happy_var_3)
	_
	_
	 =  HappyAbsSyn5
		 (Quit happy_var_3
	)
happyReduction_8 _ _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_2  6 happyReduction_9
happyReduction_9 (HappyTerminal (TVar happy_var_2))
	_
	 =  HappyAbsSyn6
		 (Postcondition (Var happy_var_2)
	)
happyReduction_9 _ _  = notHappyAtAll 

happyReduce_10 = happyReduce 4 6 happyReduction_10
happyReduction_10 (_ `HappyStk`
	(HappyAbsSyn7  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (Postcondition happy_var_3
	) `HappyStk` happyRest

happyReduce_11 = happySpecReduce_3  7 happyReduction_11
happyReduction_11 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (Equals happy_var_1 happy_var_3
	)
happyReduction_11 _ _ _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_1  7 happyReduction_12
happyReduction_12 (HappyTerminal (TVar happy_var_1))
	 =  HappyAbsSyn7
		 (Var happy_var_1
	)
happyReduction_12 _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_1  7 happyReduction_13
happyReduction_13 (HappyTerminal (TNumber happy_var_1))
	 =  HappyAbsSyn7
		 (Num happy_var_1
	)
happyReduction_13 _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_1  7 happyReduction_14
happyReduction_14 (HappyTerminal (TString happy_var_1))
	 =  HappyAbsSyn7
		 (String happy_var_1
	)
happyReduction_14 _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_3  7 happyReduction_15
happyReduction_15 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (Concat happy_var_1 happy_var_3
	)
happyReduction_15 _ _ _  = notHappyAtAll 

happyReduce_16 = happyReduce 4 7 happyReduction_16
happyReduction_16 (_ `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TFunc happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (Func happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_17 = happySpecReduce_1  8 happyReduction_17
happyReduction_17 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn8
		 ([happy_var_1]
	)
happyReduction_17 _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_3  8 happyReduction_18
happyReduction_18 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn8
		 (happy_var_1 ++ [happy_var_3]
	)
happyReduction_18 _ _ _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_1  9 happyReduction_19
happyReduction_19 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn9
		 (Exp happy_var_1
	)
happyReduction_19 _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_3  9 happyReduction_20
happyReduction_20 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn9
		 (Two happy_var_1 happy_var_3
	)
happyReduction_20 _ _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_2  9 happyReduction_21
happyReduction_21 (HappyAbsSyn7  happy_var_2)
	_
	 =  HappyAbsSyn9
		 (Default happy_var_2
	)
happyReduction_21 _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 27 27 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TSet -> cont 10;
	TIf -> cont 11;
	TElse -> cont 12;
	TElseIf -> cont 13;
	TNumber happy_dollar_dollar -> cont 14;
	TQuit -> cont 15;
	TVar happy_dollar_dollar -> cont 16;
	TEq -> cont 17;
	TOpBracket -> cont 18;
	TClBracket -> cont 19;
	TString happy_dollar_dollar -> cont 20;
	TConcat -> cont 21;
	TColon -> cont 22;
	TOpenParen -> cont 23;
	TCloseParen -> cont 24;
	TFunc happy_dollar_dollar -> cont 25;
	TComma -> cont 26;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 27 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Prelude.Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure  = HappyIdentity
    (<*>) = ap
instance Prelude.Monad HappyIdentity where
    return = pure
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (Prelude.>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (Prelude.return)
happyThen1 m k tks = (Prelude.>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (Prelude.return) a
happyError' :: () => ([(Token)], [Prelude.String]) -> HappyIdentity a
happyError' = HappyIdentity Prelude.. (\(tokens, _) -> parseError tokens)
pleaseParsePlease tks = happyRunIdentity happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq



{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- $Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp $










































data Happy_IntList = HappyCons Prelude.Int Happy_IntList








































infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is ERROR_TOK, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action









































indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x Prelude.< y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `Prelude.div` 16)) (bit `Prelude.mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Prelude.Int ->                    -- token number
         Prelude.Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k Prelude.- ((1) :: Prelude.Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Prelude.Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n Prelude.- ((1) :: Prelude.Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n Prelude.- ((1)::Prelude.Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery (ERROR_TOK is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  ERROR_TOK tk old_st CONS(HAPPYSTATE(action),sts) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        DO_ACTION(action,ERROR_TOK,tk,sts,(saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ((HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = Prelude.error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `Prelude.seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
