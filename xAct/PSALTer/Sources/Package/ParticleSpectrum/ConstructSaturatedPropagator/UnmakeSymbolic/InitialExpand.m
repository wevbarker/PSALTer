(*=================*)
(*  InitialExpand  *)
(*=================*)

BuildPackage@"ParticleSpectrum/ConstructSaturatedPropagator/UnmakeSymbolic/InitialExpand/BatchExpanded.m";

InitialExpand[SymbolicRules_,MatrixElementFileName_]:=Module[{
	ReducedNumerator,
	ReducedDenominator,
	FullElement,
	ListOfFileNames,
	CouplingAssumptions
	},

	Get@MatrixElementFileName;

	{CouplingAssumptions,FullElement}=ToExpression@"xAct`PSALTer`Private`MatrixElement";
	
	FullElement//=Together;

	ReducedNumerator=Numerator@FullElement;
	Assuming[CouplingAssumptions,ReducedNumerator//=Expand];

	ReducedDenominator=Denominator@FullElement;
	Assuming[CouplingAssumptions,ReducedDenominator//=Expand];

	ListOfFileNames=
		{BatchExpanded[{CouplingAssumptions,ReducedNumerator},
				"Numerator",
				SymbolicRules,
				MatrixElementFileName],
		BatchExpanded[{CouplingAssumptions,ReducedDenominator},
				"Denominator",
				SymbolicRules,
				MatrixElementFileName]};
ListOfFileNames];
