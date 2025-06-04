(*====================*)
(*  ParticleSpectrum  *)
(*====================*)

IncludeHeader@"ValidateTheoryName";
IncludeHeader@"ValidateMaxLaurentDepth";
IncludeHeader@"ValidateLagrangian";
IncludeHeader@"CombineAssociations";
IncludeHeader@"UpdateTheoryAssociation";
IncludeHeader@"ConstructLinearAction";
IncludeHeader@"ConstructWaveOperator";
IncludeHeader@"ConstructSourceConstraints";
IncludeHeader@"ConstructSaturatedPropagator";
IncludeHeader@"ConstructMassiveAnalysis";
IncludeHeader@"ConstructMasslessAnalysis";
IncludeHeader@"ConstructUnitarityConditions";
IncludeHeader@"ConstructSpectrograph";

Off[Set::write];
Off[SetDelayed::write];

Options@ParticleSpectrumActual={TheoryName->False,MaxLaurentDepth->1,Neglect->{},MasslessSpectrum->True,AspectRatio->Landscape,ShowPropagator->True,Method->"Easy"};
ParticleSpectrumActual[Expr_,OptionsPattern[]]~Y~Module[{
	CallStack,	
	TheoryContext,
	PDFSummaryOfResults},

	ValidateTheoryName@OptionValue@TheoryName;
	ValidateMaxLaurentDepth@OptionValue@MaxLaurentDepth;
	ValidateNeglect@OptionValue@Neglect;
	ValidateLagrangian@Expr;

	If[!$CLI,
		CallStack=PrintTemporary@Dynamic@Refresh[
			GUICallStack@$CallStack,
			TrackedSymbols->{$CallStack}];
	];

	CombineAssociations[Expr,TheoryContext];
	ConstructLinearAction[
				"xAct`PSALTer`Private`ClassName",
				Expr];
	ConstructWaveOperator[
				"xAct`PSALTer`Private`ClassName",
				Expr,OptionValue@Neglect];
	ConstructSourceConstraints[
				"xAct`PSALTer`Private`ClassName",
				CouplingAssumptions,
				Rescalings,
				RaisedIndexSources,
				MatrixLagrangian];
	ConstructSaturatedPropagator[
				"xAct`PSALTer`Private`ClassName",
				MatrixLagrangian,
				CouplingAssumptions,
				RaisedIndexSources,
				LoweredIndexSources];
	ConstructMassiveAnalysis[
				"xAct`PSALTer`Private`ClassName"];
	ConstructMasslessAnalysis[
				"xAct`PSALTer`Private`ClassName",
				ValuesOfSourceConstraints,
				MasslessSpectrum->OptionValue@MasslessSpectrum,
				MaxLaurentDepth->OptionValue@MaxLaurentDepth];
	ConstructUnitarityConditions[
				"xAct`PSALTer`Private`ClassName",
				MassiveAnalysis,
				MassiveGhostAnalysis,
				MasslessAnalysisValue,
				QuarticAnalysisValue,
				HexicAnalysisValue];

	PDFSummaryOfResults=ConstructSpectrograph[
		$LocalSummaryOfTheory,
		$LocalSourceConstraints,
		$LocalWaveOperator,
		$LocalPropagator,
		$LocalMasslessSpectrum,
		$LocalSpectrum,
		$LocalUnresolvedPoles,
		$LocalOverallUnitarity];
	UsingFrontEnd@Export[FileNameJoin@{$WorkingDirectory,
		"ParticleSpectrograph"<>OptionValue@TheoryName<>".pdf"},
		PDFSummaryOfResults
	];

	MapThread[
			UpdateTheoryAssociation[OptionValue@TheoryName,#1,#2]&
		,
		{
			{		
				WaveOperator,
				PseudoDeterminant
			}
		,
			{
				$ValuesAllMatrices,
				$AllPseudoDeterminants
			}
		}
	];

	If[!$CLI,
		FinishDynamic[];
		NotebookDelete@CallStack;
	];

	Print@PDFSummaryOfResults;

];

On[Set::write];
On[SetDelayed::write];

Unprotect@ParticleSpectrum;
Options@ParticleSpectrum={TheoryName->False,MaxLaurentDepth->1,Neglect->{},MasslessSpectrum->True,AspectRatio->Landscape,ShowPropagator->True,Method->"Easy"};
ParticleSpectrum[Args___,Opts:OptionsPattern[]]~Y~If[!$Disabled,$AspectRatio=OptionValue@AspectRatio;$ShowPropagator=OptionValue@ShowPropagator;ParticleSpectrumActual[Args,Opts]];
Protect@ParticleSpectrum;
