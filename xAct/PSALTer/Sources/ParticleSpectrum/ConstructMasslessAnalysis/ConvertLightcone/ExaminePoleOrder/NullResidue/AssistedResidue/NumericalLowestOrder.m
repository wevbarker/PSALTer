(*========================*)
(*  NumericalLowestOrder  *)
(*========================*)

IncludeHeader@"LowestOrder";

NumericalLowestOrder[InputExpr_]~Y~Module[{
		AllVariables=InputExpr//Variables,
		NumericalCouplingRules,
		Expr},

	AllVariables//=(#~DeleteElements~{Parameter})&;

	NumericalCouplingRules=Range@$NumericalSampleRange;
	NumericalCouplingRules//=((#~RandomSample~(Length@AllVariables))~Table~3)&;
	(*NumericalCouplingRules//=((#~RandomSample~(Length@AllVariables))~Table~$MinimalExamples)&;*)
	NumericalCouplingRules//=DeleteDuplicates;
	NumericalCouplingRules//=(((#1->#2)&~MapThread~{AllVariables,#})&/@#)&;

	Expr=(FullSimplify@(InputExpr/.#))&/@NumericalCouplingRules;
	Expr//=NumericalLowestOrder/@#&;
	Expr//=Min;
Expr];
