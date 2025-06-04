(*===========================*)
(*  MassiveAnalysisOfSector  *)
(*===========================*)

IncludeHeader@"PoleToSquareMass";
IncludeHeader@"IsolatePoles";

MassiveAnalysisOfSector[SpinParitySectorFileName_,Couplings_]~Y~Module[{
	Sector,
	InputDenominator,
	CouplingAssumptions,
	Poles,
	Singularities,
	SquareMassesValues},

	$LocalSpectrum=" ** MassiveAnalysisOfSector...";

	Get@SpinParitySectorFileName;
	Sector=ToExpression@"xAct`PSALTer`Private`SpinParitySector";
	Sector//=Together;
	Diagnostic@Sector;

	InputDenominator=Denominator@Sector;
	CouplingAssumptions=(#~Element~Reals)&/@Couplings;

	SquareMassesValues=IsolatePoles[InputDenominator,CouplingAssumptions];
SquareMassesValues];
