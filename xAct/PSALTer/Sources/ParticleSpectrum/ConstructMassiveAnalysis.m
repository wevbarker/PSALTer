(*============================*)
(*  ConstructMassiveAnalysis  *)
(*============================*)

IncludeHeader@"MassiveAnalysisOfSector";
IncludeHeader@"SimplifyMasses";
IncludeHeader@"MassiveGhost";

Options@ConstructMassiveAnalysis={
	Method->"Easy"};
ConstructMassiveAnalysis[ClassName_?StringQ,
		ValuesSaturatedPropagator_,
		ValuesInverseBMatricesValues_,
		BlockMassSigns_,
		OptionsPattern[]]:=Module[{	
	Couplings,
	Class,
	SignedInverseBMatrices,
	TheSpins,
	RequiredSpins,
	NewMassiveAnalysis,
	NewMassiveGhostAnalysis
	},

	$LocalSpectrum=" ** ConstructMassiveAnalysis...";

	Class=Evaluate@Symbol@ClassName;
	Couplings=Class@LagrangianCouplings;

	$LocalSpectrum=" ** MassiveAnalysisOfSector...";

	SpinParitySectorFileNames=Table[0,{i,Length@(ValuesSaturatedPropagator)}];
	Table[
		SpinParitySector=ValuesSaturatedPropagator[[i]];
		SpinParitySectorFileName=CreateFile[];
		SpinParitySectorFileNames[[i]]=SpinParitySectorFileName;
		DumpSave[SpinParitySectorFileName,SpinParitySector];
		SpinParitySector=0;
		SpinParitySectorFileName="";,
	{i,Length@(ValuesSaturatedPropagator)}];

	(Diagnostic@#)&@MatrixForm@SpinParitySectorFileNames;

	MassiveAnalysis=MapThread[
		((MassiveAnalysisOfSector[#1,#2,Method->#3]))&,
		{(SpinParitySectorFileNames),
		Map[(Couplings)&,SpinParitySectorFileNames],
		Map[(OptionValue@Method)&,SpinParitySectorFileNames]}];
	MassiveAnalysis=MonitorParallel@MassiveAnalysis;
	DeleteFile/@Flatten@SpinParitySectorFileNames;
	Diagnostic@MassiveAnalysis;

	$LocalSpectrum=" ** SimplifyMasses...";
	MassiveAnalysis//=PadRight[#,{Length@#,Max@(Length/@#)}]&;
	MassiveAnalysis=MapThread[
		(xAct`PSALTer`Private`NewParallelSubmit@(SimplifyMasses[#1,#2,Method->#3]))&,
		{(MassiveAnalysis),
		Map[(Couplings)&,MassiveAnalysis,{2}],
		Map[(OptionValue@Method)&,MassiveAnalysis,{2}]},2];
	MassiveAnalysis=MonitorParallel@MassiveAnalysis;

	Diagnostic@MassiveAnalysis;

	$LocalSpectrum=" ** MassiveGhost...";

	SignedInverseBMatrices=Times~MapThread~{(ValuesInverseBMatricesValues),(BlockMassSigns)};
	ksmsm=MapThread[ConstantArray[#1,Length@#2]&,{SignedInverseBMatrices,MassiveAnalysis},1];
	Diagnostic@ksmsm;
	ksmsm=Map[(Couplings)&,MassiveAnalysis,{2}];
	Diagnostic@ksmsm;
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
	TheSpins=Class@Spins;
	Diagnostic@TheSpins;
	RequiredSpins={0,1,2,3};
	Diagnostic@RequiredSpins;
	NewMassiveAnalysis={};
	NewMassiveGhostAnalysis={};
	If[MemberQ[TheSpins,#],
		AppendTo[NewMassiveAnalysis,
			MassiveAnalysis[[2*First@First@Position[TheSpins,#]-1]]];
		AppendTo[NewMassiveAnalysis,
			MassiveAnalysis[[2*First@First@Position[TheSpins,#]]]];
		AppendTo[NewMassiveGhostAnalysis,
			MassiveGhostAnalysis[[2*First@First@Position[TheSpins,#]-1]]];
		AppendTo[NewMassiveGhostAnalysis,
			MassiveGhostAnalysis[[2*First@First@Position[TheSpins,#]]]];,
		AppendTo[NewMassiveAnalysis,{}];
		AppendTo[NewMassiveAnalysis,{}];
		AppendTo[NewMassiveGhostAnalysis,{}];
		AppendTo[NewMassiveGhostAnalysis,{}];
	]&/@RequiredSpins;

	$LocalSpectrum={NewMassiveAnalysis,
			NewMassiveGhostAnalysis,{},{},{},{}};
	Diagnostic@$LocalSpectrum;
];
