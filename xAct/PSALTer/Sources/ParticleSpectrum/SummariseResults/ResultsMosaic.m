(*=================*)
(*  ResultsMosaic  *)
(*=================*)

IncludeHeader@"GraphicsMosaic";

ResultsMosaic[
		TheSummaryOfTheory_,
		TheWaveOperator_,
		ThePropagator_,
		TheSourceConstraints_,
		TheSpectrum_,
		TheMasslessSpectrum_,
		TheOverallUnitarity_]:=Module[{
	MatricesGroup=Join[TheWaveOperator,ThePropagator,
			{TheSourceConstraints},{TheSummaryOfTheory}],
	SpectrumGroup=TheSpectrum~Join~TheMasslessSpectrum,
	FinalElement,
	MaxWidth,
	FinalGraphic},

	SpectrumGroup~AppendTo~TheOverallUnitarity;	
	MatricesGroup=Vectorize/@MatricesGroup;
	SpectrumGroup=Vectorize/@SpectrumGroup;

	FinalElement=MatricesGroup[[-1]];
	MatricesGroup//=(#~Drop~(-1))&;
	MatricesGroup//=(#~Join~{FinalElement})&;
	MaxWidth=Max@((First/@(ImageDimensions/@(MatricesGroup~Join~SpectrumGroup)))~Join~{500});

	MatricesGroup=GraphicsMosaic[MatricesGroup,MaxWidth];
	SpectrumGroup=GraphicsMosaic[SpectrumGroup,MaxWidth];

	If[$MatricesOnly,
		FinalGraphic={
				MatricesGroup
		};
	,
		FinalGraphic={
				MatricesGroup,
				SpectrumGroup
		};
	];

	FinalGraphic//=Column[#,
			Alignment->{Left,Center},
			Background->$PanelColor,
			Frame->False]&;
FinalGraphic];
