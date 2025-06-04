(*============================*)
(*  ConstructMassiveAnalysis  *)
(*============================*)

IncludeHeader@"MassiveAnalysisOfSector";
IncludeHeader@"SimplifyMasses";
IncludeHeader@"MassiveGhost";
IncludeHeader@"UnresolvedPoleQ";
IncludeHeader@"SquareMassQ";

ConstructMassiveAnalysis[ClassName_?StringQ]~Y~Module[{	
	Couplings,
	Class,
	SignedInverseBMatrices,
	TheSpins,
	RequiredSpins,
	UnresolvedPoles,
	NewMassiveAnalysis,
	NewMassiveGhostAnalysis,
	SpoofValuesSaturatedPropagator,
	SpoofBlockMassSigns,
	SpoofValuesInverseBMatricesValues},

	Class=Evaluate@Symbol@ClassName;
	Couplings=Class@LagrangianCouplings;

	SpoofValuesSaturatedPropagator=$ValuesSaturatedPropagator;
	SpoofBlockMassSigns=$BlockMassSigns;
	SpoofValuesInverseBMatricesValues=$ValuesInverseBMatricesValues;
	SpoofValuesSaturatedPropagator//=Flatten;
	Diagnostic@SpoofValuesSaturatedPropagator;
	Diagnostic@SpoofBlockMassSigns;
	Diagnostic@SpoofValuesInverseBMatricesValues;

	SpinParitySectorFileNames=Table[0,{i,Length@(SpoofValuesSaturatedPropagator)}];
	Table[
		SpinParitySector=SpoofValuesSaturatedPropagator[[i]];
		SpinParitySectorFileName=CreateFile[];
		SpinParitySectorFileNames[[i]]=SpinParitySectorFileName;
		DumpSave[SpinParitySectorFileName,SpinParitySector];
		SpinParitySector=0;
		SpinParitySectorFileName="";,
	{i,Length@(SpoofValuesSaturatedPropagator)}];

	(Diagnostic@#)&@MatrixForm@SpinParitySectorFileNames;

	MassiveAnalysis=MapThread[
		(xAct`PSALTer`Private`NewParallelSubmit@(MassiveAnalysisOfSector[#1,#2]))&,
		{(SpinParitySectorFileNames),
		Map[(Couplings)&,SpinParitySectorFileNames]}];
	MassiveAnalysis=MonitorParallel@MassiveAnalysis;
	DeleteFile/@Flatten@SpinParitySectorFileNames;
	Diagnostic@MassiveAnalysis;

	UnresolvedPoles=DeleteCases[MassiveAnalysis,_?SquareMassQ,{2}];
	Diagnostic@UnresolvedPoles;
	MassiveAnalysis=DeleteCases[MassiveAnalysis,_?UnresolvedPoleQ,{2}];
	Diagnostic@MassiveAnalysis;
	MassiveAnalysis//=PadRight[#,{Length@#,Max@(Length/@#)}]&;
	Diagnostic@MassiveAnalysis;

	MassiveAnalysis=MapThread[
		(xAct`PSALTer`Private`NewParallelSubmit@(SimplifyMasses[#1,#2]))&,
		{(MassiveAnalysis),
		Map[(Couplings)&,MassiveAnalysis,{2}]},2];
	MassiveAnalysis=MonitorParallel@MassiveAnalysis;
	Diagnostic@MassiveAnalysis;

	SignedInverseBMatrices=(#1.#2)&~MapThread~{(SpoofValuesInverseBMatricesValues),(SpoofBlockMassSigns)};
	CombinedArray=MapThread[ConstantArray[#1,Length@#2]&,{SignedInverseBMatrices,MassiveAnalysis},1];
	Diagnostic@CombinedArray;
	CombinedArray=Map[(Couplings)&,MassiveAnalysis,{2}];
	Diagnostic@CombinedArray;
	MassiveGhostAnalysis=MapThread[
		(xAct`PSALTer`Private`NewParallelSubmit@(MassiveGhost[#1,#2,#3]))&,
		{MapThread[ConstantArray[#1,Length@#2]&,{SignedInverseBMatrices,MassiveAnalysis},1],
		MassiveAnalysis,
		Map[(Couplings)&,MassiveAnalysis,{2}]},2];
	MassiveGhostAnalysis=MonitorParallel@MassiveGhostAnalysis;
	MassiveGhostAnalysis=DeleteCases[#,0,Infinity]&/@MassiveGhostAnalysis;
	Diagnostic@MassiveGhostAnalysis;
	MassiveAnalysis=DeleteCases[#,0,Infinity]&/@MassiveAnalysis;
	Diagnostic@MassiveAnalysis;

	DoubleUnresolvedPoles={};
	DoubleMassiveAnalysis={};
	DoubleMassiveGhostAnalysis={};
	Table[If[(PositiveDefiniteMatrixQ@$BlockMassSigns[[i]])||(NegativeDefiniteMatrixQ@$BlockMassSigns[[i]]),
		AppendTo[DoubleUnresolvedPoles,UnresolvedPoles[[i]]];
		AppendTo[DoubleMassiveAnalysis,MassiveAnalysis[[i]]];
		AppendTo[DoubleMassiveGhostAnalysis,MassiveGhostAnalysis[[i]]];,
		AppendTo[DoubleUnresolvedPoles,UnresolvedPoles[[i]]];
		AppendTo[DoubleUnresolvedPoles,UnresolvedPoles[[i]]];
		AppendTo[DoubleMassiveAnalysis,MassiveAnalysis[[i]]];
		AppendTo[DoubleMassiveAnalysis,MassiveAnalysis[[i]]];
		AppendTo[DoubleMassiveGhostAnalysis,MassiveGhostAnalysis[[i]]];
		AppendTo[DoubleMassiveGhostAnalysis,MassiveGhostAnalysis[[i]]];
	],{i,Length@$BlockMassSigns}];

	Diagnostic@DoubleUnresolvedPoles;
	Diagnostic@DoubleMassiveAnalysis;
	Diagnostic@DoubleMassiveGhostAnalysis;

	TheSpins=Class@Spins;
	Diagnostic@TheSpins;
	RequiredSpins={0,1,2,3};
	Diagnostic@RequiredSpins;
	NewUnresolvedPoles={};
	NewMassiveAnalysis={};
	NewMassiveGhostAnalysis={};
	If[MemberQ[TheSpins,#],
		AppendTo[NewUnresolvedPoles,
			DoubleUnresolvedPoles[[2*First@First@Position[TheSpins,#]-1]]];
		AppendTo[NewUnresolvedPoles,
			DoubleUnresolvedPoles[[2*First@First@Position[TheSpins,#]]]];
		AppendTo[NewMassiveAnalysis,
			DoubleMassiveAnalysis[[2*First@First@Position[TheSpins,#]-1]]];
		AppendTo[NewMassiveAnalysis,
			DoubleMassiveAnalysis[[2*First@First@Position[TheSpins,#]]]];
		AppendTo[NewMassiveGhostAnalysis,
			DoubleMassiveGhostAnalysis[[2*First@First@Position[TheSpins,#]-1]]];
		AppendTo[NewMassiveGhostAnalysis,
			DoubleMassiveGhostAnalysis[[2*First@First@Position[TheSpins,#]]]];
	,
		AppendTo[NewUnresolvedPoles,{}];
		AppendTo[NewUnresolvedPoles,{}];
		AppendTo[NewMassiveAnalysis,{}];
		AppendTo[NewMassiveAnalysis,{}];
		AppendTo[NewMassiveGhostAnalysis,{}];
		AppendTo[NewMassiveGhostAnalysis,{}];
	]&/@RequiredSpins;
	Diagnostic@NewMassiveAnalysis;
	Diagnostic@NewMassiveGhostAnalysis;

	$LocalUnresolvedPoles=NewUnresolvedPoles;
	$LocalSpectrum={NewMassiveAnalysis,
			NewMassiveGhostAnalysis,{},{},{},{}};
	Diagnostic@$LocalSpectrum;
];
