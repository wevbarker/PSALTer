(*================================*)
(*  ConstructUnitarityConditions  *)
(*================================*)

ConstructUnitarityConditions[ClassName_?StringQ,MassiveAnalysis_,MassiveGhostAnalysis_,MasslessAnalysisValue_,QuarticAnalysisValue_,HexicAnalysisValue_]:=Module[{
	Couplings,
	Class,
	PositiveSystem=Join[MassiveAnalysis,MassiveGhostAnalysis,MasslessAnalysisValue],
	PathologicalSystem=Join[QuarticAnalysisValue,HexicAnalysisValue],
	CouplingAssumptions
	},

	LocalOverallUnitarity=" ** ConstructUnitarityConditions...";

	Class=Evaluate@Symbol@ClassName;
	Couplings=Class@LagrangianCouplings;
	
	CouplingAssumptions=(#~Element~Reals)&/@Couplings;
	Diagnostic@CouplingAssumptions;
	CouplingAssumptions~AppendTo~(xAct`PSALTer`Mo>0);
	Diagnostic@CouplingAssumptions;

	PathologicalSystem//=Flatten;
	Diagnostic@PathologicalSystem;
	PathologicalSystem=(0<#>0)&/@PathologicalSystem;
	Diagnostic@PathologicalSystem;

	PositiveSystem//=Flatten;
	Diagnostic@PositiveSystem;
	PositiveSystem=(#>0)&/@PositiveSystem;
	Diagnostic@PositiveSystem;

	PositiveSystem=PositiveSystem~Join~PathologicalSystem;

	PositiveSystem=PositiveSystem/.{Mo->1,En->1,Def->1};
	(*Quiet wrapper used since there are some PrintAs warnings*)
	PositiveSystem//=Quiet@Assuming[CouplingAssumptions,Reduce[#,Couplings]]&;
	Diagnostic@PositiveSystem;
	LocalOverallUnitarity=PositiveSystem;
	PositiveSystemValue=PositiveSystem;
];
