(*======================*)
(*  CatalogueInvariant  *)
(*======================*)

Options@CatalogueInvariant={Mixed->False};
CatalogueInvariant[
	ClassName_?StringQ,
	LeftTensor_,
	LeftTensorConstantSymbol_,
	RightTensor_,
	RightTensorConstantSymbol_,
	OptionsPattern[]]:=Module[{
	Class,
	TensorContraction},
	
	If[Evaluate@Total@((Length@SlotsOfTensor@#)&/@({LeftTensor,RightTensor}))>0,
		Off[$RecursionLimit::reclim2];
		Off[$RecursionLimit::reclim];
		Off[$IterationLimit::itlim];
		Off[ToCanonical::noident];
		If[OptionValue@Mixed,
		If[Head@#===List,TensorContraction=First@#,TensorContraction=#]&@AllContractions[
				IndexFree@((LeftTensor~Times~RightTensor)~Times~xAct`PSALTer`Eps),
				Parallelization->False];,
		If[Head@#===List,TensorContraction=First@#,TensorContraction=#]&@AllContractions[
				IndexFree@(LeftTensor~Times~RightTensor),
				Parallelization->False];
		];
		On[ToCanonical::noident];
		On[$IterationLimit::itlim];
		On[$RecursionLimit::reclim];
		On[$RecursionLimit::reclim2];,
		TensorContraction=Times@@((#[])&/@({LeftTensor,RightTensor}));
	];

	Class=Evaluate@Symbol@ClassName;
	InvariantToConstantRulesValue=Class@InvariantToConstantRules;

	InvariantToConstantRulesValue=InvariantToConstantRulesValue~Join~
			MakeRule[{
				Evaluate@TensorContraction,
				LeftTensorConstantSymbol~Times~RightTensorConstantSymbol
			},MetricOn->All,ContractMetrics->True];

	UpdateClassAssociation[ClassName,InvariantToConstantRules,InvariantToConstantRulesValue];
TensorContraction];
