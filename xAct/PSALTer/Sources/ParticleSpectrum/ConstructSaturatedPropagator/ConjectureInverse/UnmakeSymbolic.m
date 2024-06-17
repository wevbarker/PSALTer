(*==================*)
(*  UnmakeSymbolic  *)
(*==================*)

IncludeHeader@"InitialExpand";
IncludeHeader@"GradualExpandSubTask";
IncludeHeader@"ConsolidateUnmakeSymbolic";
IncludeHeader@"ConsolidateFinalElement";

UnmakeSymbolic[InverseSymbolicMatrix_,
	DeterminantSymbolic_,
	ReduceFirstIntermediateSymbols_,
	FirstIntermediateSymbolsToSecondIntermediateSymbols_,
	SecondIntermediateSymbolsToCouplingConstants_,
	CouplingAssumptions_]:=Module[{
		RankOfMatrix,
		SubTaskFileNames,
		GraduallyExpandedSubTasks,
		InverseMatrix,
		CombinedRules,
		TheInverseSymbolicMatrix},

	$LocalPropagator=" ** UnmakeSymbolic...";
	RankOfMatrix=Length@InverseSymbolicMatrix;
	MatrixElementFileNames=Table[0,{i,RankOfMatrix+1},{j,RankOfMatrix+1}];
	TheInverseSymbolicMatrix=InverseSymbolicMatrix~PadRight~{RankOfMatrix+1,RankOfMatrix+1};
	TheInverseSymbolicMatrix[[RankOfMatrix+1,RankOfMatrix+1]]=Evaluate@(DeterminantSymbolic);

	Table[
		If[j>=i,
			MatrixElement={CouplingAssumptions,Evaluate@(TheInverseSymbolicMatrix[[i,j]])}
			,
			MatrixElement={CouplingAssumptions,0}
		];
		MatrixElementFileName=CreateFile[];
		MatrixElementFileNames[[i,j]]=MatrixElementFileName;
		DumpSave[MatrixElementFileName,MatrixElement];
		MatrixElement=0;
		MatrixElementFileName="";,
	{i,RankOfMatrix+1},{j,RankOfMatrix+1}];

	Diagnostic@MatrixElementFileNames;

	CombinedRules={ReduceFirstIntermediateSymbols,
			FirstIntermediateSymbolsToSecondIntermediateSymbols,
			SecondIntermediateSymbolsToCouplingConstants};

	$LocalPropagator=" ** InitialExpand...";
	SubTaskFileNames=MapThread[
		(xAct`PSALTer`Private`NewParallelSubmit@(InitialExpand[#1,#2]))&,
		{Map[(CombinedRules)&,MatrixElementFileNames,{2}],
		MatrixElementFileNames},2];
	SubTaskFileNames=MonitorParallel@SubTaskFileNames;
	DeleteFile/@Flatten@MatrixElementFileNames;
	Diagnostic@SubTaskFileNames;

	$LocalPropagator=" ** GradualExpandSubTask...";
	MonitorParallel@Map[
		(xAct`PSALTer`Private`NewParallelSubmit@(GradualExpandSubTask[#1]))&,
		SubTaskFileNames,{4}];

	$LocalPropagator=" ** ConsolidateUnmakeSymbolic...";
	InverseMatrix=Map[
		(xAct`PSALTer`Private`NewParallelSubmit@(ConsolidateUnmakeSymbolic[#1]))&,
		SubTaskFileNames,{2}];
	InverseMatrix=MonitorParallel@InverseMatrix;
	DeleteFile/@Flatten@SubTaskFileNames;
	Diagnostic@InverseMatrix;

	InverseMatrix=InverseMatrix[[1;;RankOfMatrix,1;;RankOfMatrix]]/InverseMatrix[[RankOfMatrix+1,RankOfMatrix+1]];

	$LocalPropagator=" ** ConsolidateFinalElement...";
	InverseMatrix=Map[
		(xAct`PSALTer`Private`NewParallelSubmit@(ConsolidateFinalElement[#1]))&,
		Map[{CouplingAssumptions,#}&,InverseMatrix,{2}],{2}];
	InverseMatrix=MonitorParallel@InverseMatrix;
	Diagnostic@InverseMatrix;

	$LocalPropagator=" ** Conjugate...";
	Table[
		If[j<i,
			InverseMatrix[[i,j]]=Assuming[
					CouplingAssumptions,
					Conjugate@Evaluate@(InverseMatrix[[j,i]])]
		],
	{i,RankOfMatrix},
	{j,RankOfMatrix}];

	$LocalPropagator=" ** ConsolidateFinalElement...";
	InverseMatrix=Map[
		(xAct`PSALTer`Private`NewParallelSubmit@(ConsolidateFinalElement[#1]))&,
		Map[{CouplingAssumptions,#}&,InverseMatrix,{2}],{2}];
	InverseMatrix=MonitorParallel@InverseMatrix;
	Diagnostic@InverseMatrix;

InverseMatrix];
