(*====================*)
(*  ParticleSpectrum  *)
(*====================*)

BuildPackage@"ParticleSpectrum/UpdateTheoryAssociation.m";
BuildPackage@"ParticleSpectrum/PSALTerParallelSubmit.m";

BuildPackage@"ParticleSpectrum/SummariseResults.m";
BuildPackage@"ParticleSpectrum/ParticleSpectrumSummary.m";
BuildPackage@"ParticleSpectrum/PrintSpectrum.m";

BuildPackage@"ParticleSpectrum/ConstructLinearAction.m";
BuildPackage@"ParticleSpectrum/ConstructWaveOperator.m";
BuildPackage@"ParticleSpectrum/ConstructSourceConstraints.m";
BuildPackage@"ParticleSpectrum/ConstructSaturatedPropagator.m";
BuildPackage@"ParticleSpectrum/ConstructMassiveAnalysis.m";
BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis.m";
BuildPackage@"ParticleSpectrum/ConstructUnitarityConditions.m";

Off[Set::write];
Off[SetDelayed::write];
Options@ParticleSpectrum={
	ClassName->False,
	TheoryName->False,
	Method->"Easy",
	MaxLaurentDepth->1
	};

ParticleSpectrum::WrongClassName="You must pass a string to the option ClassName, from the list of defined classes `1`.";
ValidateClassName[ClassNameValue_,ClassNames_]:=If[!(ClassNames~MemberQ~ClassNameValue),
			Throw@Message[ParticleSpectrum::WrongClassName,ClassNames]
			];
ParticleSpectrum::WrongTheoryName="You must pass a string to the option TheoryName.";
ValidateTheoryName[TheoryNameValue_]:=If[!(StringQ@TheoryNameValue),
			Throw@Message[ParticleSpectrum::WrongTheoryName,TheoryNameValue]
			];
ParticleSpectrum::WrongMethod="The method `1` for evaluating the source constraints and matrix pseudoinverses appears not to be either of the strings Easy, Hard or Both.";
ValidateMethod[MethodValue_]:=If[!({"Easy","Hard","Both"}~MemberQ~MethodValue),
			Throw@Message[ParticleSpectrum::WrongMethod,MethodValue]
			];
ParticleSpectrum::WrongMaxLaurentDepth="The maximum requested depth n of the 1/k^(2n) residue n=`1` appears not to be a natural number 1, 2 or 3.";
ValidateMaxLaurentDepth[MaxLaurentDepthValue_]:=If[!({1,2,3}~MemberQ~MaxLaurentDepthValue),
			Throw@Message[ParticleSpectrum::WrongMaxLaurentDepth,MaxLaurentDepthValue]
			];

ParticleSpectrum[Expr_,OptionsPattern[]]:=Catch@Module[{
	SummariseResultsOngoing,
	ClassNames
},

	ClassNames={"ScalarTheory",
		"VectorTheory",
		"TensorTheory",
		"ScalarTensorTheory",
		"PoincareGaugeTheory",
		"WeylGaugeTheory",
		"MetricAffineGravity",
		"ZeroTorsionPalatini"};

	ValidateClassName[OptionValue@ClassName,ClassNames];
	ValidateTheoryName@OptionValue@TheoryName;
	ValidateMethod@OptionValue@Method;
	ValidateMaxLaurentDepth@OptionValue@MaxLaurentDepth;

	LocalWaveOperator=Null;
	LocalPropagator=Null;
	LocalSourceConstraints=Null;
	LocalSpectrum=Null;
	LocalMasslessSpectrum=Null;
	LocalOverallUnitarity=Null;
	LocalSummaryOfTheory=Null;

	SummariseResultsOngoing=PrintTemporary@Dynamic[Refresh[SummariseResults[
			LocalWaveOperator,
			LocalPropagator,
			LocalSourceConstraints,
			LocalSpectrum,
			LocalMasslessSpectrum,
			LocalOverallUnitarity,
			LocalSummaryOfTheory],
		TrackedSymbols->{
			LocalWaveOperator,
			LocalPropagator,
			LocalSourceConstraints,
			LocalSpectrum,
			LocalMasslessSpectrum,
			LocalOverallUnitarity,
			LocalSummaryOfTheory}]];

	ConstructLinearAction[
				OptionValue@ClassName,
				Expr];


	ConstructWaveOperator[
				OptionValue@ClassName,
				Expr];
	UpdateTheoryAssociation[
				OptionValue@TheoryName,
				BMatrices,
				ValuesAllMatrices,
				ExportTheory->False];
	UpdateTheoryAssociation[
				OptionValue@TheoryName,
				MomentumSpaceLagrangian,
				DecomposeFieldsdLagrangian,
				ExportTheory->False];


	ConstructSourceConstraints[
				OptionValue@ClassName,
				CouplingAssumptions,
				Rescalings,
				RaisedIndexSources,
				MatrixLagrangian,
				Method->OptionValue@Method];
	UpdateTheoryAssociation[
				OptionValue@TheoryName,
				SourceConstraints,
				ValuesOfSourceConstraints,
				ExportTheory->False];


	ConstructSaturatedPropagator[
				OptionValue@ClassName,
				MatrixLagrangian,
				CouplingAssumptions,
				BMatricesValues,
				RaisedIndexSources,
				LoweredIndexSources,
				Method->OptionValue@Method];
	UpdateTheoryAssociation[
				OptionValue@TheoryName,
				InverseBMatrices,
				ValuesInverseBMatricesValues,
				ExportTheory->False];


	ConstructMassiveAnalysis[
				OptionValue@ClassName,
				ValuesSaturatedPropagator,
				ValuesInverseBMatricesValues,
				BlockMassSigns,
				Method->OptionValue@Method];
	UpdateTheoryAssociation[
				OptionValue@TheoryName,
				SquareMasses,
				MassiveAnalysis,
				ExportTheory->False];


	ConstructMasslessAnalysis[
				OptionValue@ClassName,
				ValuesOfSourceConstraints,
				ValuesSaturatedPropagator,
				MaxLaurentDepth->OptionValue@MaxLaurentDepth];
	UpdateTheoryAssociation[
				OptionValue@TheoryName,
				MasslessEigenvalues,
				MasslessAnalysisValue,
				ExportTheory->False];
	UpdateTheoryAssociation[
				OptionValue@TheoryName,
				SourceConstraintComponents,
				ConstraintComponentList,
				ExportTheory->False];


	ConstructUnitarityConditions[
				OptionValue@ClassName,
				MassiveAnalysis,
				MassiveGhostAnalysis,
				MasslessAnalysisValue,
				QuarticAnalysisValue,
				HexicAnalysisValue];
	UpdateTheoryAssociation[
				OptionValue@TheoryName,
				PositiveSystem,
				PositiveSystemValue,
				ExportTheory->False];


	FinishDynamic[];
	NotebookDelete@SummariseResultsOngoing;
	SummaryOfResults=SummariseResults[
		LocalWaveOperator,
		LocalPropagator,
		LocalSourceConstraints,
		LocalSpectrum,
		LocalMasslessSpectrum,
		LocalOverallUnitarity,
		LocalSummaryOfTheory];
	Print@SummaryOfResults;
	If[$ExportPDF,
		Export[FileNameJoin@{$WorkingDirectory,OptionValue@TheoryName<>".pdf"},
					SummaryOfResults]
	];
];
On[Set::write];
On[SetDelayed::write];
Protect@ParticleSpectrum;
