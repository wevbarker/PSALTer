(*====================*)
(*  SummariseResults  *)
(*====================*)

IncludeHeader@"CLIPrint";
IncludeHeader@"ShowIfSmall";
IncludeHeader@"DetailCell";
IncludeHeader@"MakeLabel";
IncludeHeader@"WignerGrid";
IncludeHeader@"PrintSourceConstraints";
IncludeHeader@"SummariseTheory";
IncludeHeader@"PrintSpectrum";
IncludeHeader@"PrintUnitarityConditions";
IncludeHeader@"SplitWignerGrid";
IncludeHeader@"ResultsMosaic";

Options@SummariseResults={SummaryType->ResultsPanel};

SummariseResults[TheoryName_?StringQ,WaveOperator_,Propagator_,SourceConstraints_,Spectrum_,MasslessSpectrum_,OverallUnitarity_,SummaryOfTheory_,OptionsPattern[]]:=Module[{
	Computing,
	TheSummaryOfTheory,
	TheWaveOperator,
	ThePropagator,
	TheSourceConstraints,
	TheSpectrum,
	TheMasslessSpectrum,
	TheOverallUnitarity,
	SummaryOfResults
	},

	If[OptionValue@SummaryType==ResultsPanel,
		If[$CLI,
			SummaryOfResults=CLIPrint[
				TheoryName,
				WaveOperator,
				Propagator,
				SourceConstraints,
				Spectrum,
				MasslessSpectrum,
				OverallUnitarity];
		,
			Computing=Row[{ProgressIndicator[
					Appearance->"Necklace",
					ImageSize->Small],
					"Pending..."},
					Invisible@MakeLabel@"  ",Alignment->{Left,Center}];
			FullWidth=First@Rasterize[Show[Graphics[Circle[]],
							ImageSize->Full],"RasterSize"];

			If[SummaryOfTheory===Null,
				TheSummaryOfTheory=Computing,
				TheSummaryOfTheory=SummariseTheory@SummaryOfTheory];
			If[WaveOperator===Null,
				TheWaveOperator=Computing,
				TheWaveOperator=WignerGrid@@WaveOperator];
			If[Propagator===Null,
				ThePropagator=Computing,
				ThePropagator=WignerGrid@@Propagator];
			If[SourceConstraints===Null,
				TheSourceConstraints=Computing,
				TheSourceConstraints=PrintSourceConstraints@@SourceConstraints];
			If[Spectrum===Null,
				TheSpectrum=Computing,
				TheSpectrum=If[ListQ@#,
				Grid[Partition[#,UpTo@2],Alignment->{Left,Top}],
				#,#]&@(PrintSpectrumMassive@@Spectrum)];
			If[MasslessSpectrum===Null,
				TheMasslessSpectrum=Computing,
				TheMasslessSpectrum=If[ListQ@#,
				Grid[Partition[#,UpTo@2],Alignment->{Left,Top}],
				#,#]&@(PrintSpectrumMassless@@MasslessSpectrum)];
			If[OverallUnitarity===Null,
				TheOverallUnitarity=Computing,
				TheOverallUnitarity=DetailCell@(PrintUnitarityConditions@OverallUnitarity)];
			If[$MatricesOnly,
				SummaryOfResults=Column[{
					MakeLabel["Particle spectrograph",20],
					TheSummaryOfTheory,
					MakeLabel@"Wave operator",
					TheWaveOperator,
					MakeLabel@"Saturated propagator",
					ThePropagator,
					MakeLabel@"Source constraints",
					TheSourceConstraints},
					Spacings->{1,1},
					Background->$PanelColor,
					Alignment->{Left,Center}];
			,
				SummaryOfResults=Column[{
					MakeLabel["Particle spectrograph",20],
					TheSummaryOfTheory,
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
					MakeLabel@"Unitarity conditions",
					TheOverallUnitarity},
					Spacings->{1,1},
					Background->$PanelColor,
					Alignment->{Left,Center}];
			];
		];
	];

	If[OptionValue@SummaryType==ResultsMosaic,	

		FullWidth=First@Rasterize[Show[Graphics[Circle[]],
						ImageSize->Full],"RasterSize"];

		TheSummaryOfTheory=SummariseTheory@SummaryOfTheory;
		TheWaveOperator=SplitWignerGrid@@WaveOperator;
		ThePropagator=SplitWignerGrid@@Propagator;
		TheSourceConstraints=PrintSourceConstraints@@SourceConstraints;
		TheSpectrum=If[ListQ@#,#,{#},{#}]&@(PrintSpectrumMassive@@Spectrum);
		TheMasslessSpectrum=If[ListQ@#,#,{#},{#}]&@(PrintSpectrumMassless@@MasslessSpectrum);
		TheOverallUnitarity=DetailCell@(PrintUnitarityConditions@OverallUnitarity);

		SummaryOfResults=ResultsMosaic[
				TheSummaryOfTheory,
				TheWaveOperator,
				ThePropagator,
				TheSourceConstraints,
				TheSpectrum,
				TheMasslessSpectrum,
				TheOverallUnitarity];
	];
SummaryOfResults];
