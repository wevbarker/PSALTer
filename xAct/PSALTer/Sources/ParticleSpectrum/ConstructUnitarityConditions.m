(*================================*)
(*  ConstructUnitarityConditions  *)
(*================================*)

IncludeHeader@"TimedReduce";

ParticleSpectrum::Timeout="Unitarity computation timeout after "<>ToString@$UnitarityTime<>" seconds";
ConstructUnitarityConditions[ClassName_?StringQ,
		MassiveAnalysis_,
		MassiveGhostAnalysis_,
		MasslessAnalysisValue_,
		QuarticAnalysisValue_,
		HexicAnalysisValue_]~Y~Module[{
	Class,
	Couplings,
	PositiveSystem=Join[MassiveAnalysis,MassiveGhostAnalysis,MasslessAnalysisValue,QuarticAnalysisValue,HexicAnalysisValue],
	CouplingAssumptions
	},

	$LocalOverallUnitarity=" ** ConstructUnitarityConditions...";

	Class=Evaluate@Symbol@ClassName;
	Couplings=Class@LagrangianCouplings;
	
	CouplingAssumptions=(#~Element~Reals)&/@Couplings;
	Diagnostic@CouplingAssumptions;
	CouplingAssumptions~AppendTo~(xAct`PSALTer`Mo>0);
	Diagnostic@CouplingAssumptions;

	PositiveSystem//=Flatten;
	Diagnostic@PositiveSystem;
	PositiveSystem=(#>0)&/@PositiveSystem;
	Diagnostic@PositiveSystem;
	PositiveSystem=PositiveSystem/.{Mo->1,En->1,Def->1};
	Diagnostic@PositiveSystem;

	$LocalOverallUnitarity=Map[(xAct`PSALTer`Private`NewParallelSubmit@(TimedReduce[CouplingAssumptions,Couplings,#]))&,{PositiveSystem}];
	$LocalOverallUnitarity//=MonitorParallel;
	$LocalOverallUnitarity//=First;
	Diagnostic@$LocalOverallUnitarity;
	If[$LocalOverallUnitarity==Null,Message@ParticleSpectrum::Timeout];
];
