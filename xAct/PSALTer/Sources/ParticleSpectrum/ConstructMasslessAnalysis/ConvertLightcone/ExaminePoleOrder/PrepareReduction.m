(*====================*)
(*  PrepareReduction  *)
(*====================*)

PrepareReduction[InputExpr_]~Y~Module[{
		Expr,AllVariables=Variables@InputExpr},

	AllVariables//=(#~DeleteElements~{En,Mo})&;
	Expr={InputExpr,#}&/@AllVariables;	
Expr];
