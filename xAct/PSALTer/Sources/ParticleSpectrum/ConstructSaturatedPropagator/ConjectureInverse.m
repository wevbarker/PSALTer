(*=====================*)
(*  ConjectureInverse  *)
(*=====================*)

IncludeHeader@"DistributeConjugate";
IncludeHeader@"MakeSymbolic";
IncludeHeader@"IntermediateRules";
IncludeHeader@"ManualPseudoInverse";
IncludeHeader@"UnmakeSymbolic";

ConjectureInverse[InputMatrix_,Couplings_,CouplingAssumptions_]~Y~ConjectureInverse[InputMatrix,Couplings,CouplingAssumptions,0];
ConjectureInverse[InputMatrix_,Couplings_,CouplingAssumptions_,ParityPartition_]~Y~Module[{	
	TheInputMatrix=InputMatrix,
	ConjecturedRightNullSpace,
	SymbolicMatrix,
	FirstIntermediateSymbolsToCouplingConstants,
	ReduceFirstIntermediateSymbols,
	FirstIntermediateSymbolsToSecondIntermediateSymbols,
	SecondIntermediateSymbolsToCouplingConstants,
	InverseSymbolicMatrix,
	DeterminantSymbolic,
	SymbolicCouplingAssumptions,
	RankOfMatrix,
	NewInverseMatrix
	},

	(*Print@Length@NullSpace[TheInputMatrix];*)

	$LocalPropagator=" ** ConjectureNullSpace...";
	ConjecturedRightNullSpace=ConjectureNullSpace[TheInputMatrix,Couplings,CouplingAssumptions,Right];
	Diagnostic@(MatrixForm@ConjecturedRightNullSpace);

	$LocalPropagator=" ** ConjectureNullSpace...";
	ConjecturedLeftNullSpace=ConjectureNullSpace[TheInputMatrix,Couplings,CouplingAssumptions,Left];
	Diagnostic@(MatrixForm@ConjecturedRightNullSpace);

	If[!(Length@ConjecturedRightNullSpace==Length@ConjecturedLeftNullSpace),
		Quit[];
	];

	$LocalPropagator=" ** MakeSymbolic...";
	{SymbolicMatrix,FirstIntermediateSymbolsToCouplingConstants}=MakeSymbolic[TheInputMatrix,CouplingAssumptions,ParityPartition];
	Diagnostic@(MatrixForm@SymbolicMatrix);

	$LocalPropagator=" ** IntermediateRules...";
	{ReduceFirstIntermediateSymbols,FirstIntermediateSymbolsToSecondIntermediateSymbols,SecondIntermediateSymbolsToCouplingConstants}=IntermediateRules[FirstIntermediateSymbolsToCouplingConstants,Couplings];
	Diagnostic@ReduceFirstIntermediateSymbols;
	Diagnostic@FirstIntermediateSymbolsToSecondIntermediateSymbols;
	Diagnostic@SecondIntermediateSymbolsToCouplingConstants;

	$LocalPropagator=" ** ManualPseudoInverse...";
	{InverseSymbolicMatrix,DeterminantSymbolic}=ManualPseudoInverse[SymbolicMatrix,ConjecturedRightNullSpace,ConjecturedLeftNullSpace];

	SymbolicCouplingAssumptions=CouplingAssumptions;
	Diagnostic@SymbolicCouplingAssumptions;

	$LocalPropagator=" ** DistributeConjugate...";
	(*InverseSymbolicMatrix//=DistributeConjugate[#,SymbolicCouplingAssumptions]&;*)
	InverseSymbolicMatrix=MapThread[
		(xAct`PSALTer`Private`NewParallelSubmit@(DistributeConjugate[#1,#2]))&,
		{(InverseSymbolicMatrix),
		Map[(SymbolicCouplingAssumptions)&,InverseSymbolicMatrix,{2}]},2];
	InverseSymbolicMatrix=MonitorParallel@InverseSymbolicMatrix;
	Diagnostic@InverseSymbolicMatrix;
	DeterminantSymbolic//=DistributeConjugate[#,SymbolicCouplingAssumptions]&;
	Diagnostic@DeterminantSymbolic;

	$LocalPropagator=" ** UnmakeSymbolic...";
	InverseMatrix=UnmakeSymbolic[InverseSymbolicMatrix,DeterminantSymbolic,ReduceFirstIntermediateSymbols,FirstIntermediateSymbolsToSecondIntermediateSymbols,SecondIntermediateSymbolsToCouplingConstants,CouplingAssumptions,ParityPartition];
	Diagnostic@InverseMatrix;

	$LocalPropagator=" ** DistributeConjugate...";
	(*InverseMatrix//=DistributeConjugate[#,CouplingAssumptions]&;*)
	InverseMatrix=MapThread[
		(xAct`PSALTer`Private`NewParallelSubmit@(DistributeConjugate[#1,#2]))&,
		{(InverseMatrix),
		Map[(CouplingAssumptions)&,InverseMatrix,{2}]},2];
	InverseMatrix=MonitorParallel@InverseMatrix;
	Diagnostic@InverseMatrix;

	RankOfMatrix=Length@InputMatrix;
	NewInverseMatrix=<|
		ConjecturedInverse->Evaluate@InverseMatrix[[1;;RankOfMatrix,1;;RankOfMatrix]],
		ConjecturedDeterminant->InverseMatrix[[RankOfMatrix+1,RankOfMatrix+1]],
		ConjecturedAdjugate->InverseMatrix[[RankOfMatrix+2;;2*RankOfMatrix+1,
					RankOfMatrix+2;;2*RankOfMatrix+1]]
	|>;
	Diagnostic@NewInverseMatrix;

NewInverseMatrix];
