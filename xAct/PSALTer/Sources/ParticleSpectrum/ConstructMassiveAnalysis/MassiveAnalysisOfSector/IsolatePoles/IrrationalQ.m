(*===============*)
(*  IrrationalQ  *)
(*===============*)

IrrationalQ[InputExpr_]~Y~Module[{AllVariables=InputExpr//Variables,NumericalCouplingRules,NumericalSamples},
	NumericalCouplingRules=Range@$NumericalSampleRange;
	NumericalCouplingRules//=((#~RandomSample~(Length@AllVariables))~Table~$MinimalExamples)&;
	NumericalCouplingRules//=DeleteDuplicates;
	NumericalCouplingRules//=(((#1->#2)&~MapThread~{AllVariables,#})&/@#)&;
	NumericalSamples=(FullSimplify@(InputExpr/.#))&/@NumericalCouplingRules;
	NumericalSamples//=((#~Element~Rationals)===True)&/@#&;
	NumericalSamples//=!(And@@#)&;
NumericalSamples];
