(*====================*)
(*  PerformReduction  *)
(*====================*)

PerformReduction[InputExpr_,InputCouplings_,LaurentDepth_]~Y~Module[{
	Expr,NumericalCouplingRules,$Break},

	If[Length@InputCouplings==0,
		Expr=InputExpr~NullResidue~LaurentDepth;
	,
		NumericalCouplingRules=Range@$NumericalSampleRange;
		NumericalCouplingRules//=((#~RandomSample~(Length@InputCouplings))~Table~$MinimalExamples)&;
		NumericalCouplingRules//=DeleteDuplicates;
		NumericalCouplingRules//=(((#1->#2)&~MapThread~{InputCouplings,#})&/@#)&;
		Do[
			$Break=True;
			Catch@Check[
				Expr=InputExpr/.(NumericalCouplingRules[[RuleNumber]]);
				Expr//=Simplify;
				Expr//=(#~NullResidue~LaurentDepth)&;
			,
				$Break=False;
			];
			If[$Break,
				Break[];
			];
		,
			{RuleNumber,1,$MinimalExamples}
		];
	];
Expr];
