(*====================*)
(*  ExaminePoleOrder  *)
(*====================*)

IncludeHeader@"NullResidue";
IncludeHeader@"ExtractSecularEquation";
IncludeHeader@"MasslessAnalysisOfTotal";
IncludeHeader@"ReparameteriseSources";

ExaminePoleOrder[LightconePropagator_,LaurentDepth_]:=Module[{
	LightconePropagatorValue=LightconePropagator,
	SymbolicLightconePropagator,
	TheUniqueMatrixElements,
	InputMatrix,
	InputDenominator,
	NumeratorFreeSourceEigenvalues,
	SecularEquation
	},

	$LocalMasslessSpectrum=" ** NullResidue...";
	SymbolicLightconePropagator=LightconePropagatorValue//MatrixToSymbolic;
	Diagnostic@SymbolicLightconePropagator;
	Diagnostic@(SymbolicLightconePropagator@UniqueMatrixElements);
	TheUniqueMatrixElements=Map[
		(xAct`PSALTer`Private`NewParallelSubmit@(NullResidue[#,LaurentDepth]))&,
	({#})&/@(SymbolicLightconePropagator@UniqueMatrixElements),{2}];
	TheUniqueMatrixElements=MonitorParallel@TheUniqueMatrixElements;
	Diagnostic@TheUniqueMatrixElements;
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
