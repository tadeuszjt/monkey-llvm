{-# OPTIONS_GHC -w #-}
module Parser where
import qualified Lexer as L
import qualified AST as S
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.9

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10 t11 t12 t13
	= HappyTerminal (L.Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8
	| HappyAbsSyn9 t9
	| HappyAbsSyn10 t10
	| HappyAbsSyn11 t11
	| HappyAbsSyn12 t12
	| HappyAbsSyn13 t13

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,228) ([0,47104,95,0,64960,2,0,0,0,0,1024,0,0,0,0,0,32768,3583,64,0,0,1,0,4096,0,32768,224,0,1024,7,0,14368,0,0,256,0,0,0,0,16,0,0,898,0,47104,95,0,0,0,0,6126,0,0,0,0,64384,5,0,16384,32768,3583,192,0,0,0,0,7184,0,32768,224,63488,223,4,65472,40966,0,14334,1280,0,0,4,0,16,0,0,898,0,4096,28,0,57472,0,0,1796,0,8192,56,0,49408,1,0,3592,0,16384,112,0,33280,3,0,7184,0,32768,224,0,1024,7,0,14368,0,0,0,61440,447,136,0,32768,0,12284,512,57344,127,16,65280,32769,0,0,1024,0,0,32,0,3,1,6144,2048,0,240,64,32768,7,2,15360,4096,0,508,128,57344,15,4,0,14368,0,0,512,0,0,128,0,256,0,0,0,0,0,32,65280,32795,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1024,8,0,2048,0,0,512,63488,223,4,0,0,0,0,449,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parseTokens","Prog","Stmt","Stmt1","If","Else","Block","Block1","Expr","Args","Params","'+'","'-'","'*'","'/'","'%'","'<'","'>'","'<='","'>='","'=='","'!='","'&&'","'||'","'='","let","fn","if","else","while","return","print","int","ident","'('","')'","'{'","'}'","','","';'","%eof"]
        bit_start = st * 43
        bit_end = (st + 1) * 43
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..42]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (28) = happyShift action_7
action_0 (29) = happyShift action_8
action_0 (30) = happyShift action_9
action_0 (32) = happyShift action_10
action_0 (33) = happyShift action_11
action_0 (34) = happyShift action_12
action_0 (35) = happyShift action_13
action_0 (36) = happyShift action_14
action_0 (37) = happyShift action_15
action_0 (39) = happyShift action_16
action_0 (4) = happyGoto action_17
action_0 (5) = happyGoto action_18
action_0 (6) = happyGoto action_3
action_0 (7) = happyGoto action_4
action_0 (9) = happyGoto action_5
action_0 (11) = happyGoto action_6
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (28) = happyShift action_7
action_1 (29) = happyShift action_8
action_1 (30) = happyShift action_9
action_1 (32) = happyShift action_10
action_1 (33) = happyShift action_11
action_1 (34) = happyShift action_12
action_1 (35) = happyShift action_13
action_1 (36) = happyShift action_14
action_1 (37) = happyShift action_15
action_1 (39) = happyShift action_16
action_1 (5) = happyGoto action_2
action_1 (6) = happyGoto action_3
action_1 (7) = happyGoto action_4
action_1 (9) = happyGoto action_5
action_1 (11) = happyGoto action_6
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyFail (happyExpListPerState 2)

action_3 (42) = happyShift action_44
action_3 _ = happyFail (happyExpListPerState 3)

action_4 _ = happyReduce_5

action_5 _ = happyReduce_6

action_6 (14) = happyShift action_31
action_6 (15) = happyShift action_32
action_6 (16) = happyShift action_33
action_6 (17) = happyShift action_34
action_6 (18) = happyShift action_35
action_6 (19) = happyShift action_36
action_6 (20) = happyShift action_37
action_6 (21) = happyShift action_38
action_6 (22) = happyShift action_39
action_6 (23) = happyShift action_40
action_6 (25) = happyShift action_41
action_6 (26) = happyShift action_42
action_6 (37) = happyShift action_43
action_6 _ = happyReduce_10

action_7 (36) = happyShift action_30
action_7 _ = happyFail (happyExpListPerState 7)

action_8 (37) = happyShift action_29
action_8 _ = happyFail (happyExpListPerState 8)

action_9 (29) = happyShift action_8
action_9 (35) = happyShift action_13
action_9 (36) = happyShift action_23
action_9 (37) = happyShift action_15
action_9 (11) = happyGoto action_28
action_9 _ = happyFail (happyExpListPerState 9)

action_10 (29) = happyShift action_8
action_10 (35) = happyShift action_13
action_10 (36) = happyShift action_23
action_10 (37) = happyShift action_15
action_10 (11) = happyGoto action_27
action_10 _ = happyFail (happyExpListPerState 10)

action_11 (29) = happyShift action_8
action_11 (35) = happyShift action_13
action_11 (36) = happyShift action_23
action_11 (37) = happyShift action_15
action_11 (11) = happyGoto action_26
action_11 _ = happyFail (happyExpListPerState 11)

action_12 (37) = happyShift action_25
action_12 _ = happyFail (happyExpListPerState 12)

action_13 _ = happyReduce_19

action_14 (27) = happyShift action_24
action_14 _ = happyReduce_21

action_15 (29) = happyShift action_8
action_15 (35) = happyShift action_13
action_15 (36) = happyShift action_23
action_15 (37) = happyShift action_15
action_15 (11) = happyGoto action_22
action_15 _ = happyFail (happyExpListPerState 15)

action_16 (28) = happyShift action_7
action_16 (29) = happyShift action_8
action_16 (30) = happyShift action_9
action_16 (32) = happyShift action_10
action_16 (33) = happyShift action_11
action_16 (34) = happyShift action_12
action_16 (35) = happyShift action_13
action_16 (36) = happyShift action_14
action_16 (37) = happyShift action_15
action_16 (39) = happyShift action_16
action_16 (5) = happyGoto action_20
action_16 (6) = happyGoto action_3
action_16 (7) = happyGoto action_4
action_16 (9) = happyGoto action_5
action_16 (10) = happyGoto action_21
action_16 (11) = happyGoto action_6
action_16 _ = happyReduce_17

action_17 (43) = happyAccept
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (28) = happyShift action_7
action_18 (29) = happyShift action_8
action_18 (30) = happyShift action_9
action_18 (32) = happyShift action_10
action_18 (33) = happyShift action_11
action_18 (34) = happyShift action_12
action_18 (35) = happyShift action_13
action_18 (36) = happyShift action_14
action_18 (37) = happyShift action_15
action_18 (39) = happyShift action_16
action_18 (4) = happyGoto action_19
action_18 (5) = happyGoto action_18
action_18 (6) = happyGoto action_3
action_18 (7) = happyGoto action_4
action_18 (9) = happyGoto action_5
action_18 (11) = happyGoto action_6
action_18 _ = happyReduce_1

action_19 _ = happyReduce_2

action_20 (28) = happyShift action_7
action_20 (29) = happyShift action_8
action_20 (30) = happyShift action_9
action_20 (32) = happyShift action_10
action_20 (33) = happyShift action_11
action_20 (34) = happyShift action_12
action_20 (35) = happyShift action_13
action_20 (36) = happyShift action_14
action_20 (37) = happyShift action_15
action_20 (39) = happyShift action_16
action_20 (5) = happyGoto action_20
action_20 (6) = happyGoto action_3
action_20 (7) = happyGoto action_4
action_20 (9) = happyGoto action_5
action_20 (10) = happyGoto action_68
action_20 (11) = happyGoto action_6
action_20 _ = happyReduce_17

action_21 (40) = happyShift action_67
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (14) = happyShift action_31
action_22 (15) = happyShift action_32
action_22 (16) = happyShift action_33
action_22 (17) = happyShift action_34
action_22 (18) = happyShift action_35
action_22 (19) = happyShift action_36
action_22 (20) = happyShift action_37
action_22 (21) = happyShift action_38
action_22 (22) = happyShift action_39
action_22 (23) = happyShift action_40
action_22 (25) = happyShift action_41
action_22 (26) = happyShift action_42
action_22 (37) = happyShift action_43
action_22 (38) = happyShift action_66
action_22 _ = happyFail (happyExpListPerState 22)

action_23 _ = happyReduce_21

action_24 (29) = happyShift action_8
action_24 (35) = happyShift action_13
action_24 (36) = happyShift action_23
action_24 (37) = happyShift action_15
action_24 (11) = happyGoto action_65
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (29) = happyShift action_8
action_25 (35) = happyShift action_13
action_25 (36) = happyShift action_23
action_25 (37) = happyShift action_15
action_25 (11) = happyGoto action_45
action_25 (12) = happyGoto action_64
action_25 _ = happyReduce_36

action_26 (14) = happyShift action_31
action_26 (15) = happyShift action_32
action_26 (16) = happyShift action_33
action_26 (17) = happyShift action_34
action_26 (18) = happyShift action_35
action_26 (19) = happyShift action_36
action_26 (20) = happyShift action_37
action_26 (21) = happyShift action_38
action_26 (22) = happyShift action_39
action_26 (23) = happyShift action_40
action_26 (25) = happyShift action_41
action_26 (26) = happyShift action_42
action_26 (37) = happyShift action_43
action_26 _ = happyReduce_9

action_27 (14) = happyShift action_31
action_27 (15) = happyShift action_32
action_27 (16) = happyShift action_33
action_27 (17) = happyShift action_34
action_27 (18) = happyShift action_35
action_27 (19) = happyShift action_36
action_27 (20) = happyShift action_37
action_27 (21) = happyShift action_38
action_27 (22) = happyShift action_39
action_27 (23) = happyShift action_40
action_27 (25) = happyShift action_41
action_27 (26) = happyShift action_42
action_27 (37) = happyShift action_43
action_27 (39) = happyShift action_16
action_27 (9) = happyGoto action_63
action_27 _ = happyFail (happyExpListPerState 27)

action_28 (14) = happyShift action_31
action_28 (15) = happyShift action_32
action_28 (16) = happyShift action_33
action_28 (17) = happyShift action_34
action_28 (18) = happyShift action_35
action_28 (19) = happyShift action_36
action_28 (20) = happyShift action_37
action_28 (21) = happyShift action_38
action_28 (22) = happyShift action_39
action_28 (23) = happyShift action_40
action_28 (25) = happyShift action_41
action_28 (26) = happyShift action_42
action_28 (37) = happyShift action_43
action_28 (39) = happyShift action_16
action_28 (9) = happyGoto action_62
action_28 _ = happyFail (happyExpListPerState 28)

action_29 (36) = happyShift action_61
action_29 (13) = happyGoto action_60
action_29 _ = happyReduce_39

action_30 (27) = happyShift action_59
action_30 _ = happyFail (happyExpListPerState 30)

action_31 (29) = happyShift action_8
action_31 (35) = happyShift action_13
action_31 (36) = happyShift action_23
action_31 (37) = happyShift action_15
action_31 (11) = happyGoto action_58
action_31 _ = happyFail (happyExpListPerState 31)

action_32 (29) = happyShift action_8
action_32 (35) = happyShift action_13
action_32 (36) = happyShift action_23
action_32 (37) = happyShift action_15
action_32 (11) = happyGoto action_57
action_32 _ = happyFail (happyExpListPerState 32)

action_33 (29) = happyShift action_8
action_33 (35) = happyShift action_13
action_33 (36) = happyShift action_23
action_33 (37) = happyShift action_15
action_33 (11) = happyGoto action_56
action_33 _ = happyFail (happyExpListPerState 33)

action_34 (29) = happyShift action_8
action_34 (35) = happyShift action_13
action_34 (36) = happyShift action_23
action_34 (37) = happyShift action_15
action_34 (11) = happyGoto action_55
action_34 _ = happyFail (happyExpListPerState 34)

action_35 (29) = happyShift action_8
action_35 (35) = happyShift action_13
action_35 (36) = happyShift action_23
action_35 (37) = happyShift action_15
action_35 (11) = happyGoto action_54
action_35 _ = happyFail (happyExpListPerState 35)

action_36 (29) = happyShift action_8
action_36 (35) = happyShift action_13
action_36 (36) = happyShift action_23
action_36 (37) = happyShift action_15
action_36 (11) = happyGoto action_53
action_36 _ = happyFail (happyExpListPerState 36)

action_37 (29) = happyShift action_8
action_37 (35) = happyShift action_13
action_37 (36) = happyShift action_23
action_37 (37) = happyShift action_15
action_37 (11) = happyGoto action_52
action_37 _ = happyFail (happyExpListPerState 37)

action_38 (29) = happyShift action_8
action_38 (35) = happyShift action_13
action_38 (36) = happyShift action_23
action_38 (37) = happyShift action_15
action_38 (11) = happyGoto action_51
action_38 _ = happyFail (happyExpListPerState 38)

action_39 (29) = happyShift action_8
action_39 (35) = happyShift action_13
action_39 (36) = happyShift action_23
action_39 (37) = happyShift action_15
action_39 (11) = happyGoto action_50
action_39 _ = happyFail (happyExpListPerState 39)

action_40 (29) = happyShift action_8
action_40 (35) = happyShift action_13
action_40 (36) = happyShift action_23
action_40 (37) = happyShift action_15
action_40 (11) = happyGoto action_49
action_40 _ = happyFail (happyExpListPerState 40)

action_41 (29) = happyShift action_8
action_41 (35) = happyShift action_13
action_41 (36) = happyShift action_23
action_41 (37) = happyShift action_15
action_41 (11) = happyGoto action_48
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (29) = happyShift action_8
action_42 (35) = happyShift action_13
action_42 (36) = happyShift action_23
action_42 (37) = happyShift action_15
action_42 (11) = happyGoto action_47
action_42 _ = happyFail (happyExpListPerState 42)

action_43 (29) = happyShift action_8
action_43 (35) = happyShift action_13
action_43 (36) = happyShift action_23
action_43 (37) = happyShift action_15
action_43 (11) = happyGoto action_45
action_43 (12) = happyGoto action_46
action_43 _ = happyReduce_36

action_44 _ = happyReduce_3

action_45 (14) = happyShift action_31
action_45 (15) = happyShift action_32
action_45 (16) = happyShift action_33
action_45 (17) = happyShift action_34
action_45 (18) = happyShift action_35
action_45 (19) = happyShift action_36
action_45 (20) = happyShift action_37
action_45 (21) = happyShift action_38
action_45 (22) = happyShift action_39
action_45 (23) = happyShift action_40
action_45 (25) = happyShift action_41
action_45 (26) = happyShift action_42
action_45 (37) = happyShift action_43
action_45 (41) = happyShift action_76
action_45 _ = happyReduce_37

action_46 (38) = happyShift action_75
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (14) = happyShift action_31
action_47 (15) = happyShift action_32
action_47 (16) = happyShift action_33
action_47 (17) = happyShift action_34
action_47 (18) = happyShift action_35
action_47 (19) = happyShift action_36
action_47 (20) = happyShift action_37
action_47 (21) = happyShift action_38
action_47 (22) = happyShift action_39
action_47 (23) = happyShift action_40
action_47 (25) = happyShift action_41
action_47 (37) = happyShift action_43
action_47 _ = happyReduce_34

action_48 (14) = happyShift action_31
action_48 (15) = happyShift action_32
action_48 (16) = happyShift action_33
action_48 (17) = happyShift action_34
action_48 (18) = happyShift action_35
action_48 (19) = happyShift action_36
action_48 (20) = happyShift action_37
action_48 (21) = happyShift action_38
action_48 (22) = happyShift action_39
action_48 (23) = happyShift action_40
action_48 (37) = happyShift action_43
action_48 _ = happyReduce_35

action_49 (14) = happyShift action_31
action_49 (15) = happyShift action_32
action_49 (16) = happyShift action_33
action_49 (17) = happyShift action_34
action_49 (18) = happyShift action_35
action_49 (19) = happyShift action_36
action_49 (20) = happyShift action_37
action_49 (21) = happyShift action_38
action_49 (22) = happyShift action_39
action_49 (37) = happyShift action_43
action_49 _ = happyReduce_33

action_50 (21) = happyFail []
action_50 (22) = happyFail []
action_50 (37) = happyShift action_43
action_50 _ = happyReduce_32

action_51 (21) = happyFail []
action_51 (22) = happyFail []
action_51 (37) = happyShift action_43
action_51 _ = happyReduce_31

action_52 (19) = happyFail []
action_52 (20) = happyFail []
action_52 (21) = happyShift action_38
action_52 (22) = happyShift action_39
action_52 (37) = happyShift action_43
action_52 _ = happyReduce_30

action_53 (19) = happyFail []
action_53 (20) = happyFail []
action_53 (21) = happyShift action_38
action_53 (22) = happyShift action_39
action_53 (37) = happyShift action_43
action_53 _ = happyReduce_29

action_54 (19) = happyShift action_36
action_54 (20) = happyShift action_37
action_54 (21) = happyShift action_38
action_54 (22) = happyShift action_39
action_54 (37) = happyShift action_43
action_54 _ = happyReduce_27

action_55 (19) = happyShift action_36
action_55 (20) = happyShift action_37
action_55 (21) = happyShift action_38
action_55 (22) = happyShift action_39
action_55 (37) = happyShift action_43
action_55 _ = happyReduce_28

action_56 (19) = happyShift action_36
action_56 (20) = happyShift action_37
action_56 (21) = happyShift action_38
action_56 (22) = happyShift action_39
action_56 (37) = happyShift action_43
action_56 _ = happyReduce_26

action_57 (16) = happyShift action_33
action_57 (17) = happyShift action_34
action_57 (18) = happyShift action_35
action_57 (19) = happyShift action_36
action_57 (20) = happyShift action_37
action_57 (21) = happyShift action_38
action_57 (22) = happyShift action_39
action_57 (37) = happyShift action_43
action_57 _ = happyReduce_25

action_58 (16) = happyShift action_33
action_58 (17) = happyShift action_34
action_58 (18) = happyShift action_35
action_58 (19) = happyShift action_36
action_58 (20) = happyShift action_37
action_58 (21) = happyShift action_38
action_58 (22) = happyShift action_39
action_58 (37) = happyShift action_43
action_58 _ = happyReduce_24

action_59 (29) = happyShift action_8
action_59 (35) = happyShift action_13
action_59 (36) = happyShift action_23
action_59 (37) = happyShift action_15
action_59 (11) = happyGoto action_74
action_59 _ = happyFail (happyExpListPerState 59)

action_60 (38) = happyShift action_73
action_60 _ = happyFail (happyExpListPerState 60)

action_61 (41) = happyShift action_72
action_61 _ = happyReduce_40

action_62 (31) = happyShift action_71
action_62 (8) = happyGoto action_70
action_62 _ = happyReduce_13

action_63 _ = happyReduce_4

action_64 (38) = happyShift action_69
action_64 _ = happyFail (happyExpListPerState 64)

action_65 (14) = happyShift action_31
action_65 (15) = happyShift action_32
action_65 (16) = happyShift action_33
action_65 (17) = happyShift action_34
action_65 (18) = happyShift action_35
action_65 (19) = happyShift action_36
action_65 (20) = happyShift action_37
action_65 (21) = happyShift action_38
action_65 (22) = happyShift action_39
action_65 (23) = happyShift action_40
action_65 (25) = happyShift action_41
action_65 (26) = happyShift action_42
action_65 (37) = happyShift action_43
action_65 _ = happyReduce_8

action_66 _ = happyReduce_22

action_67 _ = happyReduce_16

action_68 _ = happyReduce_18

action_69 _ = happyReduce_11

action_70 _ = happyReduce_12

action_71 (30) = happyShift action_9
action_71 (39) = happyShift action_16
action_71 (7) = happyGoto action_80
action_71 (9) = happyGoto action_81
action_71 _ = happyFail (happyExpListPerState 71)

action_72 (36) = happyShift action_61
action_72 (13) = happyGoto action_79
action_72 _ = happyReduce_39

action_73 (39) = happyShift action_16
action_73 (9) = happyGoto action_78
action_73 _ = happyFail (happyExpListPerState 73)

action_74 (14) = happyShift action_31
action_74 (15) = happyShift action_32
action_74 (16) = happyShift action_33
action_74 (17) = happyShift action_34
action_74 (18) = happyShift action_35
action_74 (19) = happyShift action_36
action_74 (20) = happyShift action_37
action_74 (21) = happyShift action_38
action_74 (22) = happyShift action_39
action_74 (23) = happyShift action_40
action_74 (25) = happyShift action_41
action_74 (26) = happyShift action_42
action_74 (37) = happyShift action_43
action_74 _ = happyReduce_7

action_75 _ = happyReduce_23

action_76 (29) = happyShift action_8
action_76 (35) = happyShift action_13
action_76 (36) = happyShift action_23
action_76 (37) = happyShift action_15
action_76 (11) = happyGoto action_45
action_76 (12) = happyGoto action_77
action_76 _ = happyReduce_36

action_77 _ = happyReduce_38

action_78 _ = happyReduce_20

action_79 _ = happyReduce_41

action_80 _ = happyReduce_15

action_81 _ = happyReduce_14

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 ([happy_var_1]
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_2  4 happyReduction_2
happyReduction_2 (HappyAbsSyn4  happy_var_2)
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1 : happy_var_2
	)
happyReduction_2 _ _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_2  5 happyReduction_3
happyReduction_3 _
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_3 _ _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_3  5 happyReduction_4
happyReduction_4 (HappyAbsSyn9  happy_var_3)
	(HappyAbsSyn11  happy_var_2)
	(HappyTerminal happy_var_1)
	 =  HappyAbsSyn5
		 (S.While (L.tokPosn happy_var_1) happy_var_2 happy_var_3
	)
happyReduction_4 _ _ _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_1  5 happyReduction_5
happyReduction_5 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_5 _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_1  5 happyReduction_6
happyReduction_6 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_6 _  = notHappyAtAll 

happyReduce_7 = happyReduce 4 6 happyReduction_7
happyReduction_7 ((HappyAbsSyn11  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_2) `HappyStk`
	(HappyTerminal happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (let (L.Ident _ s) = happy_var_2 in S.Assign (L.tokPosn happy_var_1) s happy_var_4
	) `HappyStk` happyRest

happyReduce_8 = happySpecReduce_3  6 happyReduction_8
happyReduction_8 (HappyAbsSyn11  happy_var_3)
	(HappyTerminal happy_var_2)
	(HappyTerminal happy_var_1)
	 =  HappyAbsSyn6
		 (let (L.Ident _ s) = happy_var_1 in S.Set (L.tokPosn happy_var_2) s happy_var_3
	)
happyReduction_8 _ _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_2  6 happyReduction_9
happyReduction_9 (HappyAbsSyn11  happy_var_2)
	(HappyTerminal happy_var_1)
	 =  HappyAbsSyn6
		 (S.Return (L.tokPosn happy_var_1) happy_var_2
	)
happyReduction_9 _ _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_1  6 happyReduction_10
happyReduction_10 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn6
		 (S.ExprStmt happy_var_1
	)
happyReduction_10 _  = notHappyAtAll 

happyReduce_11 = happyReduce 4 6 happyReduction_11
happyReduction_11 (_ `HappyStk`
	(HappyAbsSyn12  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (S.Print (L.tokPosn happy_var_1) happy_var_3
	) `HappyStk` happyRest

happyReduce_12 = happyReduce 4 7 happyReduction_12
happyReduction_12 ((HappyAbsSyn8  happy_var_4) `HappyStk`
	(HappyAbsSyn9  happy_var_3) `HappyStk`
	(HappyAbsSyn11  happy_var_2) `HappyStk`
	(HappyTerminal happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (S.If (L.tokPosn happy_var_1) happy_var_2 happy_var_3 happy_var_4
	) `HappyStk` happyRest

happyReduce_13 = happySpecReduce_0  8 happyReduction_13
happyReduction_13  =  HappyAbsSyn8
		 (Nothing
	)

happyReduce_14 = happySpecReduce_2  8 happyReduction_14
happyReduction_14 (HappyAbsSyn9  happy_var_2)
	_
	 =  HappyAbsSyn8
		 (Just happy_var_2
	)
happyReduction_14 _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_2  8 happyReduction_15
happyReduction_15 (HappyAbsSyn7  happy_var_2)
	_
	 =  HappyAbsSyn8
		 (Just happy_var_2
	)
happyReduction_15 _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_3  9 happyReduction_16
happyReduction_16 _
	(HappyAbsSyn10  happy_var_2)
	_
	 =  HappyAbsSyn9
		 (S.Block happy_var_2
	)
happyReduction_16 _ _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_0  10 happyReduction_17
happyReduction_17  =  HappyAbsSyn10
		 ([]
	)

happyReduce_18 = happySpecReduce_2  10 happyReduction_18
happyReduction_18 (HappyAbsSyn10  happy_var_2)
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn10
		 (happy_var_1 : happy_var_2
	)
happyReduction_18 _ _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_1  11 happyReduction_19
happyReduction_19 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn11
		 (let (L.Int p i) = happy_var_1 in S.Int p i
	)
happyReduction_19 _  = notHappyAtAll 

happyReduce_20 = happyReduce 5 11 happyReduction_20
happyReduction_20 ((HappyAbsSyn9  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn13  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn11
		 (S.Func (L.tokPosn happy_var_1) happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_21 = happySpecReduce_1  11 happyReduction_21
happyReduction_21 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn11
		 ((\(L.Ident p s) -> S.Ident p s) happy_var_1
	)
happyReduction_21 _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_3  11 happyReduction_22
happyReduction_22 _
	(HappyAbsSyn11  happy_var_2)
	_
	 =  HappyAbsSyn11
		 (happy_var_2
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happyReduce 4 11 happyReduction_23
happyReduction_23 (_ `HappyStk`
	(HappyAbsSyn12  happy_var_3) `HappyStk`
	(HappyTerminal happy_var_2) `HappyStk`
	(HappyAbsSyn11  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn11
		 (S.Call  (L.tokPosn happy_var_2) happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_24 = happySpecReduce_3  11 happyReduction_24
happyReduction_24 (HappyAbsSyn11  happy_var_3)
	(HappyTerminal happy_var_2)
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (S.Infix (L.tokPosn happy_var_2) S.Plus happy_var_1 happy_var_3
	)
happyReduction_24 _ _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_3  11 happyReduction_25
happyReduction_25 (HappyAbsSyn11  happy_var_3)
	(HappyTerminal happy_var_2)
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (S.Infix (L.tokPosn happy_var_2) S.Minus happy_var_1 happy_var_3
	)
happyReduction_25 _ _ _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_3  11 happyReduction_26
happyReduction_26 (HappyAbsSyn11  happy_var_3)
	(HappyTerminal happy_var_2)
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (S.Infix (L.tokPosn happy_var_2) S.Times happy_var_1 happy_var_3
	)
happyReduction_26 _ _ _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_3  11 happyReduction_27
happyReduction_27 (HappyAbsSyn11  happy_var_3)
	(HappyTerminal happy_var_2)
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (S.Infix (L.tokPosn happy_var_2) S.Mod happy_var_1 happy_var_3
	)
happyReduction_27 _ _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_3  11 happyReduction_28
happyReduction_28 (HappyAbsSyn11  happy_var_3)
	(HappyTerminal happy_var_2)
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (S.Infix (L.tokPosn happy_var_2) S.Divide happy_var_1 happy_var_3
	)
happyReduction_28 _ _ _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_3  11 happyReduction_29
happyReduction_29 (HappyAbsSyn11  happy_var_3)
	(HappyTerminal happy_var_2)
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (S.Infix (L.tokPosn happy_var_2) S.LT happy_var_1 happy_var_3
	)
happyReduction_29 _ _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_3  11 happyReduction_30
happyReduction_30 (HappyAbsSyn11  happy_var_3)
	(HappyTerminal happy_var_2)
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (S.Infix (L.tokPosn happy_var_2) S.GT happy_var_1 happy_var_3
	)
happyReduction_30 _ _ _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_3  11 happyReduction_31
happyReduction_31 (HappyAbsSyn11  happy_var_3)
	(HappyTerminal happy_var_2)
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (S.Infix (L.tokPosn happy_var_2) S.LTEq happy_var_1 happy_var_3
	)
happyReduction_31 _ _ _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_3  11 happyReduction_32
happyReduction_32 (HappyAbsSyn11  happy_var_3)
	(HappyTerminal happy_var_2)
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (S.Infix (L.tokPosn happy_var_2) S.GTEq happy_var_1 happy_var_3
	)
happyReduction_32 _ _ _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_3  11 happyReduction_33
happyReduction_33 (HappyAbsSyn11  happy_var_3)
	(HappyTerminal happy_var_2)
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (S.Infix (L.tokPosn happy_var_2) S.EqEq happy_var_1 happy_var_3
	)
happyReduction_33 _ _ _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_3  11 happyReduction_34
happyReduction_34 (HappyAbsSyn11  happy_var_3)
	(HappyTerminal happy_var_2)
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (S.Infix (L.tokPosn happy_var_2) S.OrOr happy_var_1 happy_var_3
	)
happyReduction_34 _ _ _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_3  11 happyReduction_35
happyReduction_35 (HappyAbsSyn11  happy_var_3)
	(HappyTerminal happy_var_2)
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (S.Infix (L.tokPosn happy_var_2) S.AndAnd happy_var_1 happy_var_3
	)
happyReduction_35 _ _ _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_0  12 happyReduction_36
happyReduction_36  =  HappyAbsSyn12
		 ([]
	)

happyReduce_37 = happySpecReduce_1  12 happyReduction_37
happyReduction_37 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn12
		 ([happy_var_1]
	)
happyReduction_37 _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_3  12 happyReduction_38
happyReduction_38 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn12
		 (happy_var_1 : happy_var_3
	)
happyReduction_38 _ _ _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_0  13 happyReduction_39
happyReduction_39  =  HappyAbsSyn13
		 ([]
	)

happyReduce_40 = happySpecReduce_1  13 happyReduction_40
happyReduction_40 (HappyTerminal happy_var_1)
	 =  HappyAbsSyn13
		 (let (L.Ident p s) = happy_var_1 in [s]
	)
happyReduction_40 _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_3  13 happyReduction_41
happyReduction_41 (HappyAbsSyn13  happy_var_3)
	_
	(HappyTerminal happy_var_1)
	 =  HappyAbsSyn13
		 (let (L.Ident p s) = happy_var_1 in s : happy_var_3
	)
happyReduction_41 _ _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 43 43 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	L.ReservedOp _ "+" -> cont 14;
	L.ReservedOp _ "-" -> cont 15;
	L.ReservedOp _ "*" -> cont 16;
	L.ReservedOp _ "/" -> cont 17;
	L.ReservedOp _ "%" -> cont 18;
	L.ReservedOp _ "<" -> cont 19;
	L.ReservedOp _ ">" -> cont 20;
	L.ReservedOp _ "<=" -> cont 21;
	L.ReservedOp _ ">=" -> cont 22;
	L.ReservedOp _ "==" -> cont 23;
	L.ReservedOp _ "!=" -> cont 24;
	L.ReservedOp _ "&&" -> cont 25;
	L.ReservedOp _ "||" -> cont 26;
	L.ReservedOp _ "=" -> cont 27;
	L.Reserved _ "let" -> cont 28;
	L.Reserved _ "fn" -> cont 29;
	L.Reserved _ "if" -> cont 30;
	L.Reserved _ "else" -> cont 31;
	L.Reserved _ "while" -> cont 32;
	L.Reserved _ "return" -> cont 33;
	L.Reserved _ "print" -> cont 34;
	L.Int _ _ -> cont 35;
	L.Ident _ _ -> cont 36;
	L.Sym _ '(' -> cont 37;
	L.Sym _ ')' -> cont 38;
	L.Sym _ '{' -> cont 39;
	L.Sym _ '}' -> cont 40;
	L.Sym _ ',' -> cont 41;
	L.Sym _ ';' -> cont 42;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 43 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure  = HappyIdentity
    (<*>) = ap
instance Monad HappyIdentity where
    return = pure
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (return)
happyThen1 m k tks = (>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (return) a
happyError' :: () => ([(L.Token)], [String]) -> HappyIdentity a
happyError' = HappyIdentity . (\(tokens, _) -> parseError tokens)
parseTokens tks = happyRunIdentity happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseError :: [L.Token] -> a
parseError (x:_) =
    error $ "parser error: " ++ show x
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "<command-line>" #-}







# 1 "/usr/include/stdc-predef.h" 1 3 4

# 17 "/usr/include/stdc-predef.h" 3 4














































{-# LINE 7 "<command-line>" #-}
{-# LINE 1 "/usr/lib/ghc/include/ghcversion.h" #-}















{-# LINE 7 "<command-line>" #-}
{-# LINE 1 "/tmp/ghc6056_0/ghc_2.h" #-}




















































































































































































{-# LINE 7 "<command-line>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 









{-# LINE 43 "templates/GenericTemplate.hs" #-}

data Happy_IntList = HappyCons Int Happy_IntList







{-# LINE 65 "templates/GenericTemplate.hs" #-}

{-# LINE 75 "templates/GenericTemplate.hs" #-}

{-# LINE 84 "templates/GenericTemplate.hs" #-}

infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

{-# LINE 137 "templates/GenericTemplate.hs" #-}

{-# LINE 147 "templates/GenericTemplate.hs" #-}
indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x < y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `div` 16)) (bit `mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
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
     = case happyDrop (k - ((1) :: Int)) sts of
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





             _ = nt :: Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction

{-# LINE 267 "templates/GenericTemplate.hs" #-}
happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.

{-# LINE 333 "templates/GenericTemplate.hs" #-}
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
