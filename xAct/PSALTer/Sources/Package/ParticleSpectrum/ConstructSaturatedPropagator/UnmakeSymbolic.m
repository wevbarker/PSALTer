(*==================*)
(*  UnmakeSymbolic  *)
(*==================*)

BuildPackage@"ParticleSpectrum/ConstructSaturatedPropagator/UnmakeSymbolic/InitialExpand.m";
BuildPackage@"ParticleSpectrum/ConstructSaturatedPropagator/UnmakeSymbolic/GradualExpandSubTask.m";
BuildPackage@"ParticleSpectrum/ConstructSaturatedPropagator/UnmakeSymbolic/ConsolidateUnmakeSymbolic.m";

UnmakeSymbolic[InverseSymbolicMatrix_,
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

	LocalPropagator=" ** UnmakeSymbolic...";

	RankOfMatrix=Length@InverseSymbolicMatrix;

	Quiet@CreateDirectory[FileNameJoin@{NotebookDirectory[],"tmp"}];

	MatrixElementFileNames=Table[0,{i,RankOfMatrix},{j,RankOfMatrix}];
	Table[
		MatrixElement={CouplingAssumptions,Evaluate@(InverseSymbolicMatrix[[i,j]])};
		MatrixElementFileName=FileNameJoin@{NotebookDirectory[],
				"tmp",
				"MatrixElement"<>ToString@i<>ToString@j<>".mx"};
		MatrixElementFileNames[[i,j]]=MatrixElementFileName;
		DumpSave[MatrixElementFileName,MatrixElement];
		MatrixElement=0;
		MatrixElementFileName="";,
	{i,RankOfMatrix},{j,RankOfMatrix}];

	Diagnostic@MatrixElementFileNames;

	CombinedRules={ReduceFirstIntermediateSymbols,
			FirstIntermediateSymbolsToSecondIntermediateSymbols,
			SecondIntermediateSymbolsToCouplingConstants};

	LocalPropagator=" ** InitialExpand...";
	SubTaskFileNames=MapThread[
		(xAct`PSALTer`Private`PSALTerParallelSubmit@(InitialExpand[#1,#2]))&,
		{Map[(CombinedRules)&,MatrixElementFileNames,{2}],
		MatrixElementFileNames},2];
	SubTaskFileNames=MonitorParallel@SubTaskFileNames;
	Diagnostic@SubTaskFileNames;

	LocalPropagator=" ** GradualExpandSubTask...";
	MonitorParallel@Map[
		(xAct`PSALTer`Private`PSALTerParallelSubmit@(GradualExpandSubTask[#1]))&,
		SubTaskFileNames,{4}];

	LocalPropagator=" ** ConsolidateUnmakeSymbolic...";
	InverseMatrix=Map[
		(xAct`PSALTer`Private`PSALTerParallelSubmit@(ConsolidateUnmakeSymbolic[#1]))&,
		SubTaskFileNames,{2}];
	InverseMatrix=MonitorParallel@InverseMatrix;
	Diagnostic@InverseMatrix;

InverseMatrix];
