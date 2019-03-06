module Lisp.Eval where

import Lisp.Ast



-- TODO: context type
data Context

eval :: Context -> SExpr -> SExpr
eval _ = id

-- TODO: runtime error
todo_runtime_error :: a
todo_runtime_error = error "TODO"



-- _lisp_*

_lisp_bool :: Bool -> SExpr
_lisp_bool True = _lisp_true
_lisp_bool False = _lisp_false

_lisp_false :: SExpr
_lisp_false = EmptyList

_lisp_true :: SExpr
_lisp_true = lisp_T



-- lisp_*

lisp_T :: SExpr
lisp_T = Atom "T"

lisp_atomp :: SExpr -> SExpr
lisp_atomp (DottedPair _ _) = _lisp_false
lisp_atomp _ = _lisp_true

lisp_numberp :: SExpr -> SExpr
lisp_numberp (IntegerLiteral _) = _lisp_true
lisp_numberp (FloatLiteral _) = _lisp_true
lisp_numberp _ = _lisp_false

lisp_listp :: SExpr -> SExpr
lisp_listp EmptyList = _lisp_true
lisp_listp (DottedPair _ _) = _lisp_true
lisp_listp _ = _lisp_false

lisp__eq :: SExpr -> SExpr -> SExpr
lisp__eq (IntegerLiteral x) (IntegerLiteral y) = _lisp_bool (x == y)
lisp__eq (FloatLiteral x) (FloatLiteral y) = _lisp_bool (x == y)
lisp__eq (IntegerLiteral x) (FloatLiteral y) = _lisp_bool (fromIntegral x == y)
lisp__eq (FloatLiteral x) (IntegerLiteral y) = _lisp_bool (x == fromIntegral y)
lisp__eq _ _ = todo_runtime_error

lisp_cons :: SExpr -> SExpr -> SExpr
lisp_cons car cdr = DottedPair car cdr

lisp_car :: SExpr -> SExpr
lisp_car (DottedPair car _) = car
lisp_car _ = todo_runtime_error

lisp_cdr :: SExpr -> SExpr
lisp_cdr (DottedPair _ cdr) = cdr
lisp_cdr _ = todo_runtime_error