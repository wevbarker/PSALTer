(*================*)
(*  ShortEnoughQ  *)
(*================*)

ShortEnoughQ[InputExpr_]~Y~Module[{Expr},
	If[Head@InputExpr===Plus,
		Expr=Evaluate@((Length@InputExpr)<=$MaxCoefficientLength);
	,
		Expr=True;
	];
Expr];
