(*================================*)
(*  ConstructSaturatedPropagator  *)
(*================================*)

IncludeHeader@"DistributeConjugate";
IncludeHeader@"ConjectureInverse";

Options@ConstructSaturatedPropagator={
	Method->"Easy"};

ConstructSaturatedPropagator[ClassName_?StringQ,
		MatrixLagrangian_,
		CouplingAssumptions_,
		BMatricesValues_,
		RaisedIndexSources_,
		LoweredIndexSources_,
		OptionsPattern[]]:=Module[{
	NewCouplingAssumptions,
	Couplings,
	SourceSpinParityTensorHeadsValue,
	SymbolicLagrangian,
	Symbols,
	RaisedIndexFields,
	LoweredIndexFields,
	SpinParityConstantSymbols,
	SpinParityRescalingSymbols,
	ImaginaryParts,
	RealParts,
	NullSpaces,
	MatrixPropagator,
	ManualMatrixPropagator,
	AutomaticMatrixPropagator,
	InverseBMatricesValues,
	Class},

	NewCouplingAssumptions=CouplingAssumptions~Join~{(xAct`PSALTer`Def~Element~Reals)};

	$LocalPropagator=" ** ConstructSaturatedPropagator...";
	Class=Evaluate@Symbol@ClassName;
	Couplings=Class@LagrangianCouplings;
	Switch[OptionValue@Method,
		"Easy",
		(
			AutomaticMatrixPropagator=Assuming[NewCouplingAssumptions,
						((PseudoInverse@#))&/@MatrixLagrangian];
			AutomaticMatrixPropagator=
				((#)~FullSimplify~NewCouplingAssumptions)&/@AutomaticMatrixPropagator;
			Diagnostic@AutomaticMatrixPropagator;
			MatrixPropagator=AutomaticMatrixPropagator;
		),
		"Hard",
		(
			ManualMatrixPropagator=Map[ConjectureInverse[#,
							Couplings,
							NewCouplingAssumptions]&,
							BMatricesValues,{2}];
			ManualMatrixPropagator=(#[[1]]+#[[2]])&/@ManualMatrixPropagator;
			Diagnostic@ManualMatrixPropagator;
			MatrixPropagator=ManualMatrixPropagator;
		)
	];

	InverseBMatricesValues=MatrixPropagator;
	AntiMaskMatrixValue=Class@AntiMaskMatrix;
	InverseBMatricesValues=MapThread[
			({MapThread[Times,{#1@Even,#2}],MapThread[Times,{#1@Odd,#2}]})&,
			{AntiMaskMatrixValue,
			InverseBMatricesValues}];
	Diagnostic@InverseBMatricesValues;
	MatrixPropagator=MapThread[
		MapThread[(#1*#2)&,{#1,#2}]&,
			{MatrixPropagator,
			Class@RescalingMatrix}
	]/.Class@RescalingSolutions;
	Diagnostic@MatrixPropagator;
	MaskMatrixValue=Class@MaskMatrix;
	Diagnostic@MaskMatrixValue;
	MaskedMatrixPropagator=MapThread[
			MapThread[Times,{#1,#2}]&,
			{MaskMatrixValue,
			MatrixPropagator}];
	Diagnostic@MaskedMatrixPropagator;
	AntiMaskMatrixValue=Class@AntiMaskMatrix;
	Diagnostic@AntiMaskMatrixValue;
	MatrixPropagator=MapThread[
			({MapThread[Times,{#1@Even,#2}],MapThread[Times,{#1@Odd,#2}]})&,
			{AntiMaskMatrixValue,
			MatrixPropagator}];
	Diagnostic@MatrixPropagator;
	SaturatedPropagator=MapThread[{#1 . #2[[1]] . #3,#1 . #2[[2]] . #3}&,
			{Dagger/@RaisedIndexSources,
			MatrixPropagator,
			LoweredIndexSources}];
	Diagnostic@SaturatedPropagator;
	SaturatedPropagator=ToNewCanonical/@SaturatedPropagator;
	SaturatedPropagator=CollectTensors/@SaturatedPropagator;
	Diagnostic@SaturatedPropagator;
	Diagnostic@ValuesAllMatrices;
	BlockMassSigns=Table[-(-1)^n,{n,1,2*Length@SaturatedPropagator}];
	Diagnostic@BlockMassSigns;
	ValuesSaturatedPropagator=Flatten[Values@SaturatedPropagator,{1,2}];
	ValuesInverseBMatricesValues=Flatten[Values@InverseBMatricesValues,{1,2}];

	$LocalPropagator={((Plus@@#)&/@Partition[ValuesInverseBMatricesValues,2]),Sizes,TheSpins,SourcesLeft,SourcesTop};
];
