(*=============================*)
(*  ConsolidateUnmakeSymbolic  *)
(*=============================*)

IncludeHeader@"GrabExpression";
IncludeHeader@"SimplifyIfSmall";

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
	ReducedNumerator//=SimplifyIfSmall[CouplingAssumptions,#]&;
	ReducedDenominator=(#[[2]])&/@(GrabExpression/@ListOfDenominatorFileNames);
	ReducedDenominator//=Total;
	ReducedDenominator//=Expand;
	Assuming[CouplingAssumptions,ReducedDenominator//=Simplify];
	FullElement=ReducedNumerator/ReducedDenominator;
	Assuming[CouplingAssumptions,FullElement//=FullSimplify];	
FullElement];
