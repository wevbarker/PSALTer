(*=========================*)
(*  ConstructSpectrograph  *)
(*=========================*)

IncludeHeader@"AbbreviationRow";
IncludeHeader@"TheoryRows";
IncludeHeader@"SourceConstraintRows";
IncludeHeader@"UnresolvedPoleRows";
IncludeHeader@"AllParticleRows";
IncludeHeader@"UnitarityRow";
IncludeHeader@"WignerGrid";
IncludeHeader@"ShowIfSmall";
IncludeHeader@"CLICallStack";
IncludeHeader@"GUICallStack";

ConstructSpectrograph[
		SummaryOfTheory_,
		SourceConstraints_,
		WaveOperator_,
		Propagator_,
		MasslessSpectrum_,
		Spectrum_,
		UnresolvedPoles_,
		OverallUnitarity_]~Y~Module[{
	TheWaveOperator,
	ThePropagator,
	TheFullSpectrum,
	Expr},

	TheWaveOperator=FirstWignerGrid@@WaveOperator;
	ThePropagator=ColumnWignerGrid@@Propagator;
	TheFullSpectrum=Module[{Expr,ItemSizes},
		Expr=Join[
			AbbreviationRow@$DisplayAbbreviationRules,
			TheoryRows@SummaryOfTheory,
			SourceConstraintRows@@SourceConstraints,
			UnresolvedPoleRows@UnresolvedPoles,
			MasslessSpectrum~AllParticleRows~Spectrum,
			UnitarityRow@OverallUnitarity
		];
		Expr//=NewFramed@Grid[#,
			ItemStyle->{LineIndent->0},	
			ItemSize->{Automaic,Full},
			Dividers->Center,
			Alignment->{Center,Center}
		]&;
	Expr];

	(*TheWaveOperator//=Vectorize;
	ThePropagator//=Vectorize;
	TheFullSpectrum//=Vectorize;*)

	If[$AspectRatio===Landscape,
		If[$ShowPropagator,
			Expr={{TheWaveOperator,ThePropagator,TheFullSpectrum}};
		,
			Expr={{TheWaveOperator,TheFullSpectrum}};
		];
	];

	If[$AspectRatio===Portrait,
		If[$ShowPropagator,
			Expr={{TheWaveOperator},
				{ThePropagator},
				{TheFullSpectrum}};
		,
			Expr={{TheWaveOperator},
				{TheFullSpectrum}};
		];
	];

	Expr//=Grid[#,
		Alignment->{Center,Center},
		Background->$PanelColor,
		Frame->False,ItemSize->Full]&;
Expr];
