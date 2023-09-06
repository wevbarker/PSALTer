(*==============================*)
(*  ConstructSourceConstraints  *)
(*==============================*)

BuildPackage@"ParticleSpectrum/ConstructSourceConstraints/ConjectureNullSpace.m";
BuildPackage@"ParticleSpectrum/ConstructSourceConstraints/NonTrivialDot.m";
BuildPackage@"ParticleSpectrum/ConstructSourceConstraints/ToCovariantForm.m";

Options@ConstructSourceConstraints={
	Method->"Easy"};

ConstructSourceConstraints[ClassName_?StringQ,CouplingAssumptions_,Rescalings_,RaisedIndexSources_,MatrixLagrangian_,OptionsPattern[]]:=Module[{
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
	Class},

	LocalSourceConstraints=" ** ConstructSourceConstraints...";

	Class=Evaluate@Symbol@ClassName;
	SourceSpinParityTensorHeadsValue=Class@SourceSpinParityTensorHeads;
	Couplings=Class@LagrangianCouplings;

	Switch[OptionValue@Method,
		"Easy",
		(
			NullSpaces=Assuming[CouplingAssumptions,
						NullSpace[Transpose[#]]&/@(MatrixLagrangian)];
			Diagnostic@NullSpaces;
		),
		"Hard",
		(
			NullSpaces=ConjectureNullSpace[Transpose[#],
						Couplings,
						CouplingAssumptions]&/@(MatrixLagrangian);
			Diagnostic@NullSpaces;
		),
		"Both",
		(
			Print@Null;
		)
	];

	NullSpaces=((#)~FullSimplify~CouplingAssumptions)&/@NullSpaces;
	Diagnostic@NullSpaces;

	If[(Length@Flatten@Values@NullSpaces)==0,
		ValuesOfSourceConstraints={};
		NewValuesOfSourceConstraints={};,

		ValuesOfSourceConstraints=Quiet@DeleteCases[
			Flatten@Values@MapThread[(#1~NonTrivialDot~#2)&,
				{NullSpaces,
				MapThread[
					MapThread[(#2/#1)&,{#1,#2}]&,
						{Rescalings,
						RaisedIndexSources}
					]}
			],0,Infinity]/.Class@RescalingSolutions;
		ValuesOfSourceConstraints=Numerator@Together[#/Sqrt[2^5*3^5*5^5*7^5]]&/@ValuesOfSourceConstraints;
		Diagnostic@ValuesOfSourceConstraints;

		NewValuesOfSourceConstraints=Quiet@DeleteCases[
			MapThread[(#1~NonTrivialDot~#2)&,
				{NullSpaces,
				MapThread[
					MapThread[(#2/#1)&,{#1,#2}]&,
						{Rescalings,
						RaisedIndexSources}
					]}
			],0,Infinity]/.Class@RescalingSolutions;
		NewValuesOfSourceConstraints=Map[Numerator@Together[#/Sqrt[2^5*3^5*5^5*7^5]]&,NewValuesOfSourceConstraints,{2}];

		NewValuesOfSourceConstraints=Table[{((Simplify@(#==0))&)@#,((Simplify@(#==0))&)@ToCovariantForm[ClassName,#,SourceSpinParityTensorHeadsValue],2*Spin+1}&/@NewValuesOfSourceConstraints@Spin,{Spin,(Keys@NewValuesOfSourceConstraints)}];
		NewValuesOfSourceConstraints=Transpose@Flatten[NewValuesOfSourceConstraints,{1,2}];

	];

	Diagnostic@NewValuesOfSourceConstraints;
	If[(Length@NewValuesOfSourceConstraints)==0,
		LocalSourceConstraints="(There are no source constraints and no gauge symmetries)";,
		LocalSourceConstraints=PrintSourceConstraints@@NewValuesOfSourceConstraints;
	];
];
