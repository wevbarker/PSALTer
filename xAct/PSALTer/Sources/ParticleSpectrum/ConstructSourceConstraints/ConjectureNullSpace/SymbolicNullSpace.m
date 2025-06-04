(*=====================*)
(*  SymbolicNullSpace  *)
(*=====================*)

IncludeHeader@"CommonNullVector";
IncludeHeader@"MinimalExampleCaseNullSpace";

SymbolicNullSpace[InputMatrix_]~Y~Module[{
	Couplings=DeleteDuplicates@Flatten@(Variables/@Flatten@InputMatrix),
	NumericalCouplingRules,
	MinimalExampleCaseNullSpaces,
	CandidateNullVectors,
	CommonNullVectors},

	Diagnostic@Couplings;
	NumericalCouplingRules=(#~ConstantArray~(Length@Couplings))&/@(Range@9);
	NumericalCouplingRules//=Flatten;
	NumericalCouplingRules//=((#~RandomSample~(Length@Couplings))~Table~$MinimalExamples)&;
	NumericalCouplingRules//=DeleteDuplicates;
	NumericalCouplingRules//=(((#1->#2)&~MapThread~{Couplings,#})&/@#)&;

	MinimalExampleCaseNullSpaces=MapThread[
		(xAct`PSALTer`Private`NewParallelSubmit@(MinimalExampleCaseNullSpace[#1,#2]))&,
		{Map[(InputMatrix)&,NumericalCouplingRules],
		NumericalCouplingRules}];
	MinimalExampleCaseNullSpaces//=MonitorParallel;
	Diagnostic@MinimalExampleCaseNullSpaces;

	CandidateNullVectors=DeleteDuplicates@(Join@@MinimalExampleCaseNullSpaces);
	CommonNullVectors={};
	(((#~CommonNullVector~MinimalExampleCaseNullSpaces)&&(ResourceFunction["LinearlyIndependent"]@(CommonNullVectors~Join~{#})))~If~(CommonNullVectors~AppendTo~#))&/@CandidateNullVectors;
CommonNullVectors];
