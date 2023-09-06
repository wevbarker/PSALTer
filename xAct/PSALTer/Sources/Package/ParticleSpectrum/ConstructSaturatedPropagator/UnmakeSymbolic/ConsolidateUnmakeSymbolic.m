(*=============================*)
(*  ConsolidateUnmakeSymbolic  *)
(*=============================*)

BuildPackage@"ParticleSpectrum/ConstructSaturatedPropagator/UnmakeSymbolic/ConsolidateUnmakeSymbolic/GrabExpression.m";
BuildPackage@"ParticleSpectrum/ConstructSaturatedPropagator/UnmakeSymbolic/ConsolidateUnmakeSymbolic/SimplifyIfSmall.m";

ConsolidateUnmakeSymbolic[ListOfFileNames_]:=Module[{
	ListOfNumeratorFileNames,
	ListOfDenominatorFileNames,
	FullElement,
	CouplingAssumptions,
	ReducedNumerator,
	ReducedDenominator},

	{ListOfNumeratorFileNames,ListOfDenominatorFileNames}=ListOfFileNames;
	ReducedNumerator=(#[[2]])&/@(GrabExpression/@ListOfNumeratorFileNames);
	CouplingAssumptions=First@((#[[1]])&/@(GrabExpression/@ListOfNumeratorFileNames));
	ReducedNumerator//=Total;
	ReducedNumerator//=Expand;
	(*ReducedNumerator//=Collect[#,Def,FullSimplify]&;*)
	ReducedNumerator//=SimplifyIfSmall[CouplingAssumptions,#]&;
	(*ReducedNumerator//=FullSimplify;*)

	ReducedDenominator=(#[[2]])&/@(GrabExpression/@ListOfDenominatorFileNames);
	ReducedDenominator//=Total;
	ReducedDenominator//=Expand;
	(*ReducedDenominator//=Collect[#,Def,FullSimplify]&;*)
	Assuming[CouplingAssumptions,ReducedDenominator//=Simplify];
	(*ReducedDenominator//=FullSimplify;*)

	FullElement=ReducedNumerator/ReducedDenominator;
	Assuming[CouplingAssumptions,FullElement//=FullSimplify];
	
FullElement];
