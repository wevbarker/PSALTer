(*=====================*)
(*  RescaleNullVector  *)
(*=====================*)

RescaleNullVector[ClassName_?StringQ,SourceComponents_List,NullVector_List]:=Module[{
	Class,
	TrialPower,
	RescaledNullVector=NullVector,
	Rescaled,
	LocalSourceEngineeringDimensions,
	SourceEngineeringDimensionsList,
	UltravioletNullVector,
	NullVectorDegreeOfDivergence},

	Class=Evaluate@Symbol@ClassName;

	(*First we get rid of infrared and lightcone singularities, i.e. those
which are introduced by poles*)
	TrialPower=10;
	Rescaled=False;

	Diagnostic@RescaledNullVector;

	While[TrialPower>0&&!Rescaled,
		Diagnostic@TrialPower;
		If[Total@(Abs/@Residue[#,{En,Mo}]&/@Evaluate[RescaledNullVector*(En-Mo)^(TrialPower-1)])==0,
			Rescaled=False,
			RescaledNullVector*=((En-Mo)/Mo)^TrialPower;Rescaled=True,
			RescaledNullVector*=((En-Mo)/Mo)^TrialPower;Rescaled=True
		];
		TrialPower--
	];

	LocalSourceEngineeringDimensions=Class@SourceEngineeringDimensions;
	Diagnostic@LocalSourceEngineeringDimensions;

	SourceEngineeringDimensionsList=(LocalSourceEngineeringDimensions@(Head@#))&/@SourceComponents;
	Diagnostic@SourceEngineeringDimensionsList;

	UltravioletNullVector=FullSimplify@Total@MapThread[(Abs@((#1/(Mo^#2))/.{En->Pi Mo}))&,
		{RescaledNullVector,
		SourceEngineeringDimensionsList}
	];
	Diagnostic@UltravioletNullVector;

	NullVectorDegreeOfDivergence=(Log@UltravioletNullVector/Log@Mo//FullSimplify)~Limit~(Mo->Infinity);
	Diagnostic@NullVectorDegreeOfDivergence;

	RescaledNullVector*=Mo^(-NullVectorDegreeOfDivergence);
RescaledNullVector];
