(*========================*)
(*  GetAbbreviationRules  *)
(*========================*)

IncludeHeader@"ShortEnoughQ";
IncludeHeader@"StripRadicals";

GetAbbreviationRules[InputExpr_]~Y~Module[{Expr=InputExpr},
	Expr=Map[CoefficientList[#,Def]&,Expr,{2}];
	Expr//=Flatten;
	Expr//=DeleteCases[#,0]&;
	Expr//=DeleteDuplicates;
	Expr//=(StripRadicals@Last@FactorTermsList@#&)/@#&;
	Expr//=DeleteDuplicates;
	Expr//=DeleteCases[#,_?ShortEnoughQ]&;
	ReplacementRules=Thread[Flatten@Expr->Flatten@Array[Symbol@StringJoin["xAct`PSALTer`Private`Abbreviation",ToString@#]&,Length@Expr]];
ReplacementRules];
