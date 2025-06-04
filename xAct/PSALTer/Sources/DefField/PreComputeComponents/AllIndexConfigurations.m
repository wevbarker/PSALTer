(*==========================*)
(*  AllIndexConfigurations  *)
(*==========================*)

AllIndexConfigurations[InputExpr_]~Y~Module[{Expr=InputExpr,Indices,Configurations},
	Indices=List@@Expr;
	Configurations=Tuples[{1,-1},Length@Indices];
	Configurations//=((Head@Expr)@@MapThread[Times,{Indices,#}])&/@#&;	
Configurations];
