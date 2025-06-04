(*====================*)
(*  BasicNullResidue  *)
(*====================*)

BasicNullResidue[InputExpr_,LaurentDepth_]~Y~Module[{Expr=InputExpr},
	(*Expr//=Together;*)
	Expr*=(En-Mo)^(LaurentDepth-1);
	Expr//=(#/.{En->Mo+Parameter})&;
	Expr//=Residue[#,{Parameter,0}]&;
	Expr*=((2*Mo)^LaurentDepth);
	(*Expr//=Expand;*)
Expr];
