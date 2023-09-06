(*============================*)
(*  ConstructMassiveAnalysis  *)
(*============================*)

BuildPackage@"ParticleSpectrum/ConstructMassiveAnalysis/MassiveAnalysisOfSector.m";
BuildPackage@"ParticleSpectrum/ConstructMassiveAnalysis/SimplifyMasses.m";
BuildPackage@"ParticleSpectrum/ConstructMassiveAnalysis/MassiveGhost.m";

Options@ConstructMassiveAnalysis={
	Method->"Easy"};
ConstructMassiveAnalysis[ClassName_?StringQ,ValuesSaturatedPropagator_,ValuesInverseBMatricesValues_,BlockMassSigns_,OptionsPattern[]]:=Module[{	
	Couplings,
	Class,
	SignedInverseBMatrices,
	PrintedSpectrum
	},

	LocalSpectrum=" ** ConstructMassiveAnalysis...";

	Class=Evaluate@Symbol@ClassName;
	Couplings=Class@LagrangianCouplings;

	LocalSpectrum=" ** MassiveAnalysisOfSector...";

	Quiet@CreateDirectory[FileNameJoin@{NotebookDirectory[],"tmp"}];

	SpinParitySectorFileNames=Table[0,{i,Length@(ValuesSaturatedPropagator)}];
	Table[
		SpinParitySector=ValuesSaturatedPropagator[[i]];
		SpinParitySectorFileName=FileNameJoin@{NotebookDirectory[],
				"tmp",
				"SpinParitySector"<>ToString@i<>".mx"};
		SpinParitySectorFileNames[[i]]=SpinParitySectorFileName;
		DumpSave[SpinParitySectorFileName,SpinParitySector];
		SpinParitySector=0;
		SpinParitySectorFileName="";,
	{i,Length@(ValuesSaturatedPropagator)}];

	(Diagnostic@#)&@MatrixForm@SpinParitySectorFileNames;

	MassiveAnalysis=MapThread[
		((MassiveAnalysisOfSector[#1,#2,Method->#3]))&,
		(*(xAct`PSALTer`Private`PSALTerParallelSubmit@(MassiveAnalysisOfSector[#1,#2,Method->#3]))&,*)
		{(SpinParitySectorFileNames),
		Map[(Couplings)&,SpinParitySectorFileNames],
		Map[(OptionValue@Method)&,SpinParitySectorFileNames]}];
	MassiveAnalysis=MonitorParallel@MassiveAnalysis;

	Diagnostic@MassiveAnalysis;

	LocalSpectrum=" ** SimplifyMasses...";

	MassiveAnalysis//=PadRight[#,{Length@#,Max@(Length/@#)}]&;
	MassiveAnalysis=MapThread[
		(xAct`PSALTer`Private`PSALTerParallelSubmit@(SimplifyMasses[#1,#2,Method->#3]))&,
		{(MassiveAnalysis),
		Map[(Couplings)&,MassiveAnalysis,{2}],
		Map[(OptionValue@Method)&,MassiveAnalysis,{2}]},2];
	MassiveAnalysis=MonitorParallel@MassiveAnalysis;

	Diagnostic@MassiveAnalysis;

	LocalSpectrum=" ** MassiveGhost...";

	SignedInverseBMatrices=Times~MapThread~{(ValuesInverseBMatricesValues),(BlockMassSigns)};
	ksmsm=MapThread[ConstantArray[#1,Length@#2]&,{SignedInverseBMatrices,MassiveAnalysis},1];
	Diagnostic@ksmsm;
	ksmsm=Map[(Couplings)&,MassiveAnalysis,{2}];
	Diagnostic@ksmsm;
	MassiveGhostAnalysis=MapThread[
		(*((MassiveGhost[#1,#2,#3]))&,*)
		(xAct`PSALTer`Private`PSALTerParallelSubmit@(MassiveGhost[#1,#2,#3]))&,
		{MapThread[ConstantArray[#1,Length@#2]&,{SignedInverseBMatrices,MassiveAnalysis},1],
		MassiveAnalysis,
		Map[(Couplings)&,MassiveAnalysis,{2}]},2];
	MassiveGhostAnalysis=MonitorParallel@MassiveGhostAnalysis;
	MassiveGhostAnalysis=DeleteCases[#,0,Infinity]&/@MassiveGhostAnalysis;

	Diagnostic@MassiveGhostAnalysis;

	MassiveAnalysis=DeleteCases[#,0,Infinity]&/@MassiveAnalysis;

	Diagnostic@MassiveAnalysis;

	PrintedSpectrum=PrintSpectrum[MassiveAnalysis,MassiveGhostAnalysis,{},{},{}];

	If[(Length@PrintedSpectrum)==0,
		LocalSpectrum="(There are no massive particles)";,
		LocalSpectrum=PrintedSpectrum;
	];
];
