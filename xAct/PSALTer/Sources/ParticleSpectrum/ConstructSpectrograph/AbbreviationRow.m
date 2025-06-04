(*===================*)
(*  AbbreviationRow  *)
(*===================*)

AbbreviationRow[InputExpr_]~Y~Module[{Expr},
	If[Length@InputExpr==0,
		Expr={};
	,
		Expr={{Text@"Abbreviations used in matrices",SpanFromLeft,SpanFromLeft,SpanFromLeft},
		{Text@(And@@InputExpr),SpanFromLeft,SpanFromLeft,SpanFromLeft}};
	];	
Expr];
