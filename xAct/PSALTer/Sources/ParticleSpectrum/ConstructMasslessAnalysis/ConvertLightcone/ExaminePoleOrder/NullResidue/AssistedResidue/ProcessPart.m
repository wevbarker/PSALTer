(*===============*)
(*  ProcessPart  *)
(*===============*)

ProcessPart[InputExpr_,TermReplacements_]~Y~Module[{Expr=InputExpr},
	Expr//=(#/.TermReplacements)&;
	(*Expr//=Expand;*)
Expr];
