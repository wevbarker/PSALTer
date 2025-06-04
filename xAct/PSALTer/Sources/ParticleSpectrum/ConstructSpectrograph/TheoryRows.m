(*==============*)
(*  TheoryRows  *)
(*==============*)

TheoryRows[InputExpr_]~Y~Module[{Expr=InputExpr},
	Expr//=(Evaluate/@#)&;
	Expr//=(ExpandAll/@#)&;
	If[Length@First@Expr<=20,
		Expr={{Text@"Lagrangian",SpanFromLeft,SpanFromLeft,SpanFromLeft},
		{Text@First@Expr,SpanFromLeft,SpanFromLeft,SpanFromLeft},
		{Text@"Added source term(s):",Text@Last@Expr,SpanFromLeft,SpanFromLeft}};
	,
		Expr={{Text@"Added source term(s):",Text@Last@Expr,SpanFromLeft,SpanFromLeft}};
	];
Expr];
