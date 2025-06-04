(*================================*)
(*  ConstructSaturatedPropagator  *)
(*================================*)

IncludeHeader@"ConjectureInverse";

ConstructSaturatedPropagator[ClassName_?StringQ,
		MatrixLagrangian_,
		CouplingAssumptions_,
		RaisedIndexSources_,
		LoweredIndexSources_]~Y~Module[{
	NewCouplingAssumptions,
	Couplings,
	SymbolicLagrangian,
	Symbols,
	RaisedIndexFields,
	LoweredIndexFields,
	SourceSpinParityTensorHeadsValue,
	NEven,
	NOdd,
	SpinParityConstantSymbols,
	SpinParityRescalingSymbols,
	ImaginaryParts,
	RealParts,
	NullSpaces,
	MatrixPropagator,
	ManualMatrixPropagator,
	AutomaticMatrixPropagator,
	InverseBMatricesValues,
	Class,
	SourceInvariantMatrixValue},

	NewCouplingAssumptions=CouplingAssumptions~Join~{(xAct`PSALTer`Def~Element~Reals)};

	$LocalPropagator=" ** ConstructSaturatedPropagator...";
	Class=Evaluate@Symbol@ClassName;
	Couplings=Class@LagrangianCouplings;

	PartitionedBMatricesValues=<||>;
	$BlockMassSigns={};
	Table[
		SourceSpinParityTensorHeadsValue=Class@SourceSpinParityTensorHeads;
		Diagnostic@SourceSpinParityTensorHeadsValue;
		NEven=1~Max~Length@Flatten@((((#)@Spin)@Even)&/@Values@SourceSpinParityTensorHeadsValue);
		Diagnostic@NEven;
		NOdd=1~Max~Length@Flatten@((((#)@Spin)@Odd)&/@Values@SourceSpinParityTensorHeadsValue);
		Diagnostic@NOdd;
		If[Length@$BMatricesValues@Spin==2,
			PartitionedBMatricesValues@Spin=$BMatricesValues@Spin;
			$BlockMassSigns~AppendTo~(IdentityMatrix@NEven);
			$BlockMassSigns~AppendTo~(-IdentityMatrix@NOdd);
		,
			PartitionedBMatricesValues@Spin={First@$BMatricesValues@Spin,NEven};
			$BlockMassSigns~AppendTo~(Normal@BlockDiagonalMatrix@{IdentityMatrix@NEven,-IdentityMatrix@NOdd});
		];
		,
	{Spin,Keys@$BMatricesValues}];
	Diagnostic@PartitionedBMatricesValues;
	ManualMatrixPropagator=Map[If[ListQ@(#[[2]]),
					ConjectureInverse[#,Couplings,NewCouplingAssumptions]&/@#,
					{ConjectureInverse[First@#,Couplings,NewCouplingAssumptions,#[[2]]]}]&
				,
				PartitionedBMatricesValues];
	Diagnostic@ManualMatrixPropagator;

	InverseBMatricesValues=ManualMatrixPropagator;
	Diagnostic@InverseBMatricesValues;

	AbbreviateSpinParitySector[InputSpinParitySector_,Spin_,Parity_]~Y~Module[{
					AbbreviatedSpinParitySector},
		If[(LeafCount@InputSpinParitySector@ConjecturedDeterminant>=$MaxDeterminantSize)&&(LeafCount@InputSpinParitySector@ConjecturedDeterminant>LeafCount@1),
			AbbreviatedSpinParitySector=InputSpinParitySector@ConjecturedAdjugate;
			AbbreviatedSpinParitySector/=((PseudoDeterminantSymbols@Spin)@Parity);
			PseudoDeterminantsSpin~AppendTo~(((PseudoDeterminantSymbols@Spin)@Parity)->(InputSpinParitySector@ConjecturedDeterminant));
			,
			AbbreviatedSpinParitySector=InputSpinParitySector@ConjecturedInverse;
		];
		Diagnostic@PseudoDeterminantsSpin;
		AllPseudoDeterminantsSpin~AppendTo~(InputSpinParitySector@ConjecturedDeterminant);
	AbbreviatedSpinParitySector];

	PseudoDeterminants={};
	Diagnostic@PseudoDeterminants;

	$AllPseudoDeterminants={};
	Diagnostic@$AllPseudoDeterminants;

	AbbreviateSpinSector[InputSpinSector_,Spin_]~Y~Module[{
					AbbreviatedSpinSector=InputSpinSector
					},

		PseudoDeterminantsSpin={};
		AllPseudoDeterminantsSpin={};
		Diagnostic@PseudoDeterminantsSpin;
		If[Length@InputSpinSector==2,
			AbbreviatedSpinSector=Plus[
				AbbreviateSpinParitySector[InputSpinSector[[1]],
								Spin,Even],
				AbbreviateSpinParitySector[InputSpinSector[[2]],
								Spin,Odd]
			];
		,
			AbbreviatedSpinSector=AbbreviateSpinParitySector[InputSpinSector[[1]],
								Spin,Mixed]
		];
		InverseBMatricesValues@Spin=AbbreviatedSpinSector;
		PseudoDeterminants~AppendTo~PseudoDeterminantsSpin;
		$AllPseudoDeterminants~AppendTo~AllPseudoDeterminantsSpin;
		Diagnostic@PseudoDeterminantsSpin;
	];

	((InverseBMatricesValues@Spin)~AbbreviateSpinSector~Spin)~Table~{Spin,TheSpins};
	Diagnostic@InverseBMatricesValues;
	InverseBMatricesValues//=Values;
	Diagnostic@InverseBMatricesValues;
	Diagnostic@PseudoDeterminants;

	ManualMatrixPropagator=(If[Length@#==2,(#[[1]])@ConjecturedInverse+(#[[2]])@ConjecturedInverse,(#[[1]])@ConjecturedInverse])&/@ManualMatrixPropagator;
	Diagnostic@ManualMatrixPropagator;
	MatrixPropagator=ManualMatrixPropagator;
	Diagnostic@MatrixPropagator;

	$ValuesInverseBMatricesValues=MatrixPropagator;
	AntiMaskMatrixValue=Class@AntiMaskMatrix;

	$ValuesInverseBMatricesValues=MapThread[
			(If[
				Simplify@DeleteCases[Simplify@Flatten@(#2-MapThread[Times,{#1@Even,#2}]-MapThread[Times,{#1@Odd,#2}]),0,Infinity]==={},
				(If[#=={},{{0}},#,#])&/@{(MapThread[Times,{#1@Even,#2}])[[1;;Tr@(#1@Even),1;;Tr@(#1@Even)]],MapThread[Times,{#1@Odd,#2}][[(Tr@(#1@Even)+1);;Length@(#1@Even),(Tr@(#1@Even)+1);;Length@(#1@Even)]]},{#2}])&,
			{AntiMaskMatrixValue,
			$ValuesInverseBMatricesValues}];
	Diagnostic@$ValuesInverseBMatricesValues;
	MatrixPropagator=MapThread[
		MapThread[(#1*#2)&,{#1,#2}]&,
			{MatrixPropagator,
			Class@RescalingMatrix}
	]/.Class@RescalingSolutions;
	Diagnostic@MatrixPropagator;

	MaskedMatrixPropagator=MatrixPropagator;
	Diagnostic@MaskedMatrixPropagator;
	AntiMaskMatrixValue=Class@AntiMaskMatrix;
	Diagnostic@AntiMaskMatrixValue;

	MatrixPropagator=MapThread[
			(If[
				DeleteCases[Simplify@Flatten@(#2-MapThread[Times,{#1@Even,#2}]-MapThread[Times,{#1@Odd,#2}]),0,Infinity]=={},
				{MapThread[Times,{#1@Even,#2}],MapThread[Times,{#1@Odd,#2}]},
				{#2}
			])&,
			{AntiMaskMatrixValue,
			MatrixPropagator}];
	Diagnostic@MatrixPropagator;

	SourceInvariantMatrixValue=Class@SourceInvariantMatrix;	
	SaturatedPropagator=MapThread[
			(If[
				Length@#2==2,
				{Total@Flatten@MapThread[Times,{#1,#2[[1]]}],
					Total@Flatten@MapThread[Times,{#1,#2[[2]]}]},
				{Total@Flatten@MapThread[Times,{#1,#2[[1]]}]}
			])&,
			{SourceInvariantMatrixValue,
			MatrixPropagator}];

	Diagnostic@SaturatedPropagator;
	SaturatedPropagator=ToNewCanonical/@SaturatedPropagator;
	SaturatedPropagator=CollectTensors/@SaturatedPropagator;
	Diagnostic@SaturatedPropagator;
	Diagnostic@$BlockMassSigns;


	$ValuesSaturatedPropagator=Flatten[Values@SaturatedPropagator,{1,2}];
	Diagnostic@$ValuesSaturatedPropagator;
	$ValuesInverseBMatricesValues=Flatten[Values@$ValuesInverseBMatricesValues,{1,2}];
	Diagnostic@$ValuesInverseBMatricesValues;

	$LocalPropagator={InverseBMatricesValues,Sizes,TheSpins,SourcesLeft,SourcesTop,PseudoDeterminants};
];
