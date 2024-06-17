(*=========================*)
(*  NewParallelSubmit  *)
(*=========================*)

NewParallelSubmit~SetAttributes~HoldAll;

NewParallelSubmit[Expr_]:=NewParallelSubmit[{},Expr];
NewParallelSubmit[{Vars___},Expr_]:={Vars}~ParallelSubmit~Block[{Print=Null&,PrintTemporary=Null&},Expr];
