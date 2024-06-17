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
	TrialPower=10;
	Rescaled=False;
	Diagnostic@RescaledNullVector;
	While[TrialPower>0&&!Rescaled,
		Diagnostic@TrialPower;
		If[DeleteDuplicates@(Abs/@Residue[#,{En,Mo}]&/@Evaluate[RescaledNullVector*(En-Mo)^(TrialPower-1)])=={0},
			Rescaled=False,
			RescaledNullVector*=((En-Mo))^TrialPower;Rescaled=True,
			RescaledNullVector*=((En-Mo))^TrialPower;Rescaled=True
		];
		TrialPower--
	];
	SourceEngineeringDimensionsList=(0)&/@SourceComponents;
	Diagnostic@SourceEngineeringDimensionsList;
	UltravioletNullVector=FullSimplify@Total@MapThread[(Abs@((#1/(Mo^#2))/.{En->Pi Mo}))&,
		{RescaledNullVector,
		SourceEngineeringDimensionsList}
	];
	Diagnostic@UltravioletNullVector;
	NullVectorDegreeOfDivergence=(Log@UltravioletNullVector/Log@Mo//FullSimplify)~Limit~(Mo->Infinity);
	Diagnostic@NullVectorDegreeOfDivergence;

RescaledNullVector];
