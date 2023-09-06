(*====================*)
(*  SummariseResults  *)
(*====================*)

BuildPackage@"ParticleSpectrum/SummariseResults/ShowIfSmall.m";
BuildPackage@"ParticleSpectrum/SummariseResults/Colours.m";
BuildPackage@"ParticleSpectrum/SummariseResults/MakeLabel.m";
BuildPackage@"ParticleSpectrum/SummariseResults/WignerGrid.m";
BuildPackage@"ParticleSpectrum/SummariseResults/RaggedBlock.m";
BuildPackage@"ParticleSpectrum/SummariseResults/PrintSourceConstraints.m";
BuildPackage@"ParticleSpectrum/SummariseResults/ReMagnify.m";
BuildPackage@"ParticleSpectrum/SummariseResults/ParallelGrid.m";
BuildPackage@"ParticleSpectrum/SummariseResults/MonitorParallel.m";

SummariseTheory[Theory_?StringQ]:=Theory;

NotStringQ[InputExpr_]:=!StringQ@InputExpr;

SummariseTheory[Theory_?NotStringQ]:=Module[{DisplayVersion},
	DisplayVersion=(Action==Integrate@@({((CollectConstants@Theory))@@#}~Join~(#[[1;;4]]))&@{TCoordinate,XCoordinate,YCoordinate,ZCoordinate});
	DisplayVersion//=Evaluate;
DisplayVersion];

SummariseResults[WaveOperator_,Propagator_,SourceConstraints_,Spectrum_,MasslessSpectrum_,OverallUnitarity_,SummaryOfTheory_]:=Module[{
	Computing,
	TheWaveOperator,
	ThePropagator,
	TheSourceConstraints,
	TheSpectrum,
	TheMasslessSpectrum,
	TheOverallUnitarity,
	SummaryOfResults
	},

	Computing=Row[{ProgressIndicator[Appearance->"Necklace",ImageSize->Small],"Pending..."},Invisible@MakeLabel@"  ",Alignment->{Left,Center}];
	FullWidth=First@Rasterize[Show[Graphics[Circle[]],ImageSize->Full],"RasterSize"];

	If[WaveOperator===Null,
		TheWaveOperator=Computing,
		(*TheWaveOperator=ReMagnify[WaveOperator]];*)
		TheWaveOperator=WaveOperator];
	If[Propagator===Null,
		ThePropagator=Computing,
		(*ThePropagator=ReMagnify[Propagator]];*)
		ThePropagator=Propagator];
	If[SourceConstraints===Null,
		TheSourceConstraints=Computing,
		If[SourceConstraints==={},
			TheSourceConstraints="(None)",
			(*TheSourceConstraints=ReMagnify[SourceConstraints]];*)
			TheSourceConstraints=SourceConstraints];
		];
	If[Spectrum===Null,
		TheSpectrum=Computing,
		(*TheSpectrum=ReMagnify[Spectrum]];*)
		TheSpectrum=Spectrum];
	If[MasslessSpectrum===Null,
		TheMasslessSpectrum=Computing,
		(*TheMasslessSpectrum=ReMagnify[MasslessSpectrum]];*)
		TheMasslessSpectrum=MasslessSpectrum];
	If[OverallUnitarity===Null,
		TheOverallUnitarity=Computing,
		If[OverallUnitarity===False,
			TheOverallUnitarity="(Unitarity is demonstrably impossible)",
			(*TheOverallUnitarity=ReMagnify[OverallUnitarity]];*)
			TheOverallUnitarity=OverallUnitarity];
	];

	SummaryOfResults=Column[{
		MakeLabel@"PSALTer results panel",
		SummariseTheory@SummaryOfTheory,
		MakeLabel@"Wave operator",
		TheWaveOperator,
		MakeLabel@"Saturated propagator",
		ThePropagator,
		MakeLabel@"Source constraints",
		TheSourceConstraints,
		MakeLabel@"Massive spectrum",
		TheSpectrum,
		MakeLabel@"Massless spectrum",
		TheMasslessSpectrum,
		MakeLabel@"Gauge symmetries",
		"(Not yet implemented in PSALTer)",
		MakeLabel@"Unitarity conditions",
		TheOverallUnitarity,
		MakeLabel@"Validity assumptions",
		"(Not yet implemented in PSALTer)"
		},Spacings->{2,2},Frame->True,Background->PanelColor,Alignment->{Left,Center}];
SummaryOfResults];
