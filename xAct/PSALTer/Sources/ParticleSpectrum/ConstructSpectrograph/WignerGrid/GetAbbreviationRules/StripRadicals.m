(*=================*)
(*  StripRadicals  *)
(*=================*)

StripRadicals[InputExpr_]~Y~Module[{Expr=InputExpr},
	Expr//=FullSimplify;
	If[Head[Expr]===Times,
		Expr//=List@@#&;
		Expr//=(DeleteCases[#,_?NumericQ])&;
		Expr//=First;
	];
Expr];
