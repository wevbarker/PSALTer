(*==================*)
(*  CarefulReplace  *)
(*==================*)

CarefulReplace[InputExpr_,InputRules_]~Y~Module[{Expr=InputRules},
	If[Head[InputExpr]===Plus,
		Expr//=(InputExpr/.#)&/@#&;
		Expr//=SortBy[#,Length]&;
		Expr//=First;
	,
		Expr=InputExpr;
	];
Expr];


