(*=========================*)
(*  PSALTerParallelSubmit  *)
(*=========================*)

PSALTerParallelSubmit~SetAttributes~HoldAll;

PSALTerParallelSubmit[Expr_] :=ParallelSubmit@Block[{Print=Null&, PrintTemporary=Null&}, Expr];
