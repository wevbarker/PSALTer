(*=========================*)
(*  UnmakeSymbolicElement  *)
(*=========================*)

BuildPackage@"ParticleSpectrum/ConstructSaturatedPropagator/GradualExpand.m";

UnmakeSymbolicElement[SymbolicRules_,MatrixElementFileName_]:=Module[{
	ReduceFirstIntermediateSymbols,
	FirstIntermediateSymbolsToSecondIntermediateSymbols,
	SecondIntermediateSymbolsToCouplingConstants,
	FullElement,
	ReducedNumerator,
	ReducedDenominator,
	PrintingVariable
	},

	Get@MatrixElementFileName;

	FullElement=ToExpression@"xAct`PSALTer`Private`MatrixElement";

	If[!(FullElement===0),
	
	{ReduceFirstIntermediateSymbols,FirstIntermediateSymbolsToSecondIntermediateSymbols,SecondIntermediateSymbolsToCouplingConstants}=SymbolicRules;

	(Diagnostic@#)&@"Now attempting to simplify a single element of the inverse...";
	PrintingVariable=PrintTemporary@"Collecting element...";
	FullElement//=Together;
	NotebookDelete@PrintingVariable;
	PrintingVariable=PrintTemporary@"Extracting numerator...";
	ReducedNumerator=Numerator@FullElement;
	NotebookDelete@PrintingVariable;
	PrintingVariable=PrintTemporary@"Expanding numerator...";
	ReducedNumerator//=Expand;
	NotebookDelete@PrintingVariable;
	PrintingVariable=PrintTemporary@"Expanding and refining numerator";
	ReducedNumerator=GradualExpand[ReducedNumerator,ReduceFirstIntermediateSymbols];
	ReducedNumerator=GradualExpand[ReducedNumerator,FirstIntermediateSymbolsToSecondIntermediateSymbols];
	ReducedNumerator=GradualExpand[ReducedNumerator,SecondIntermediateSymbolsToCouplingConstants];
	NotebookDelete@PrintingVariable;
	PrintingVariable=PrintTemporary@"Attempting FullSimplify on numerator...";
	ReducedNumerator//=FullSimplify;
	(Diagnostic@#)&@ReducedNumerator;
	NotebookDelete@PrintingVariable;

	PrintingVariable=PrintTemporary@"Extracting denominator...";
	ReducedDenominator=Denominator@FullElement;
	NotebookDelete@PrintingVariable;
	PrintingVariable=PrintTemporary@"Expanding denominator...";
	ReducedDenominator//=Expand;
	NotebookDelete@PrintingVariable;
	PrintingVariable=PrintTemporary@"Expanding and refining denominator";
	ReducedDenominator=GradualExpand[ReducedDenominator,ReduceFirstIntermediateSymbols];
	ReducedDenominator=GradualExpand[ReducedDenominator,FirstIntermediateSymbolsToSecondIntermediateSymbols];
	ReducedDenominator=GradualExpand[ReducedDenominator,SecondIntermediateSymbolsToCouplingConstants];
	NotebookDelete@PrintingVariable;
	PrintingVariable=PrintTemporary@"Attempting FullSimplify on denominator...";
	ReducedDenominator//=FullSimplify;
	(Diagnostic@#)&@ReducedDenominator;
	NotebookDelete@PrintingVariable;

	FullElement=ReducedNumerator/ReducedDenominator;
	FullElement//=FullSimplify;
	];
FullElement];
