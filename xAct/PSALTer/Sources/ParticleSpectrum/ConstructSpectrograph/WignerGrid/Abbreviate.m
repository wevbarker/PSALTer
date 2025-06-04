(*==============*)
(*  Abbreviate  *)
(*==============*)

IncludeHeader@"ReplaceRadicals";

Abbreviate[InputExpr_,InputRules_]~Y~Module[{Expr=InputExpr,ExprDenominator},
	If[!(Length@InputRules==0),
		Expr//=Together;
		ExprDenominator=Expr//Denominator;
		Expr//=Numerator;
		Expr//=(#~CoefficientList~Def)&;
		Expr//=(FactorTermsList@#&)/@#&;
		Expr//=Map[(#~ReplaceRadicals~InputRules)&,#,{2}]&;
		Expr//=(Times@@#)&/@#&;
		Expr//=SeriesData[Def,0,#,0,Length@#,1]&;
		Expr//=Normal;
		Expr/=ExprDenominator;
	];
Expr];
