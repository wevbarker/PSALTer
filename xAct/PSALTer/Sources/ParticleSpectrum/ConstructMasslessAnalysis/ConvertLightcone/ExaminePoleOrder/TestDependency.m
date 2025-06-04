(*==================*)
(*  TestDependency  *)
(*==================*)

TestDependency[InputExpr_,InputCoupling_,LaurentDepth_]~Y~Module[{
		Expr,AllVariables=Variables@InputExpr,NumericalCouplingRules},

	AllVariables//=(#~DeleteElements~{En,Mo,InputCoupling})&;
	NumericalCouplingRules=Range@$NumericalSampleRange;
	NumericalCouplingRules//=((#~RandomSample~(Length@AllVariables))~Table~$NullResidueReductionMinimalExamples)&;
	NumericalCouplingRules//=DeleteDuplicates;
	NumericalCouplingRules//=(((#1->#2)&~MapThread~{AllVariables,#})&/@#)&;
	Expr=(Simplify@(InputExpr/.#))&/@NumericalCouplingRules;
	Expr//=(#~BasicNullResidue~LaurentDepth)&/@#&;
	Expr//=Variables/@#&;
	Expr//=Flatten;
	Expr//=DeleteDuplicates;
	If[Expr~MemberQ~InputCoupling,Expr={},Expr={InputCoupling}];
Expr];
