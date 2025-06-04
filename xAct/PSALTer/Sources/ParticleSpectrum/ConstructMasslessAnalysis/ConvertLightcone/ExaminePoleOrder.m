(*====================*)
(*  ExaminePoleOrder  *)
(*====================*)

IncludeHeader@"NullResidue";
IncludeHeader@"BasicNullResidue";
IncludeHeader@"ExtractSecularEquation";
IncludeHeader@"MasslessAnalysisOfTotal";
IncludeHeader@"ReparameteriseSources";
IncludeHeader@"PrepareReduction";
IncludeHeader@"TestDependency";
IncludeHeader@"PerformReduction";

ExaminePoleOrder[LightconePropagator_,LaurentDepth_]~Y~Module[{
	LightconePropagatorValue=LightconePropagator,
	SymbolicLightconePropagator,
	ReducedMatrixElements,
	TheUniqueMatrixElements,
	InputMatrix,
	InputDenominator,
	NumeratorFreeSourceEigenvalues,
	SecularEquation
	},

	SymbolicLightconePropagator=LightconePropagatorValue//MatrixToSymbolic;

	Diagnostic@SymbolicLightconePropagator;
	Diagnostic@(SymbolicLightconePropagator@UniqueMatrixElements);

	ReducedMatrixElements=Map[
		(xAct`PSALTer`Private`NewParallelSubmit@(PrepareReduction@#))&,
		SymbolicLightconePropagator@UniqueMatrixElements];	
	ReducedMatrixElements//=MonitorParallel;
	Diagnostic@ReducedMatrixElements;

	ReducedMatrixElements=Map[
		(xAct`PSALTer`Private`NewParallelSubmit@(TestDependency[First@#,Last@#,LaurentDepth]))&,
	ReducedMatrixElements,{2}];
	ReducedMatrixElements//=MonitorParallel;
	Diagnostic@ReducedMatrixElements;

	ReducedMatrixElements//=({DeleteDuplicates@Flatten@#})&/@#&;
	Diagnostic@ReducedMatrixElements;

	TheUniqueMatrixElements=MapThread[
		(xAct`PSALTer`Private`NewParallelSubmit@(PerformReduction[#1,#2,LaurentDepth]))&,
	{({#})&/@(SymbolicLightconePropagator@UniqueMatrixElements),
	ReducedMatrixElements},2];
	TheUniqueMatrixElements//=MonitorParallel;
	Diagnostic@TheUniqueMatrixElements;
(*
	TheUniqueMatrixElements=Map[
		(xAct`PSALTer`Private`NewParallelSubmit@(NullResidue[#,LaurentDepth]))&,
	({#})&/@(SymbolicLightconePropagator@UniqueMatrixElements),{2}];
	TheUniqueMatrixElements//=MonitorParallel;
	Diagnostic@TheUniqueMatrixElements;
*)
	TheUniqueMatrixElements=First/@TheUniqueMatrixElements;
	Diagnostic@TheUniqueMatrixElements;
	LightconePropagatorValue=MatrixFromSymbolic[
			SymbolicLightconePropagator@SymbolicMatrix,
			SymbolicLightconePropagator@SymbolicMatrixElements,
			TheUniqueMatrixElements];

	{InputMatrix,InputDenominator}=LightconePropagatorValue//ReparameteriseSources;

	$LocalMasslessSpectrum=" ** ExtractSecularEquation...";
	SecularEquation=ExtractSecularEquation[InputMatrix,LaurentDepth];
	Diagnostic@SecularEquation;

	$LocalMasslessSpectrum=" ** MasslessAnalysisOfTotal...";
	NumeratorFreeSourceEigenvalues=MasslessAnalysisOfTotal[InputMatrix,InputDenominator];
	Diagnostic@NumeratorFreeSourceEigenvalues;

{NumeratorFreeSourceEigenvalues,SecularEquation}];
