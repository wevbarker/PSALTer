(*===========================*)
(*  MassiveAnalysisOfSector  *)
(*===========================*)

IncludeHeader@"PoleToSquareMass";
IncludeHeader@"IsolatePoles";

Options@MassiveAnalysisOfSector={
	Method->"Easy"};
MassiveAnalysisOfSector[SpinParitySectorFileName_,Couplings_,OptionsPattern[]]:=Module[{
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

	InputDenominator=Denominator@Sector;
	CouplingAssumptions=(#~Element~Reals)&/@Couplings;

	Switch[OptionValue@Method,
		"Easy",
		(
			Sector=(1/InputDenominator);
			Poles=Sector~FunctionPoles~xAct`PSALTer`Def;
			SquareMassesValues=(
				First/@(
						(PoleToSquareMass/@Poles)~Cases~
						(
							Except@(_?((Variables@First@#~MemberQ~xAct`PSALTer`Mo)&))
						)
					)
				);
			SquareMassesValues//=DeleteDuplicates;
			SquareMassesValues//=DeleteCases[#,0,Infinity]&;
			SquareMassesValues//=DeleteCases[#,_?NumericQ]&;
			SquareMassesValues=FullSimplify/@SquareMassesValues;
		),
		"Hard",
		(
			SquareMassesValues=IsolatePoles[InputDenominator,CouplingAssumptions];
		)
	];
SquareMassesValues];
