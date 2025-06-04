(*================*)
(*  UnitarityRow  *)
(*================*)

UnitarityRow[InputExpr_]~Y~Module[{Expr},
	If[InputExpr==Null,
		Expr={};
	,
		Expr={{Text@"Resolved unitarity condition(s):",
				SpanFromLeft,
				Text@ShowIfSmall@First@InputExpr,
				SpanFromLeft}};
	,
		Expr={{Text@"Resolved unitarity condition(s):",
				SpanFromLeft,
				Text@ShowIfSmall@First@InputExpr,
				SpanFromLeft}};
	];
Expr];
