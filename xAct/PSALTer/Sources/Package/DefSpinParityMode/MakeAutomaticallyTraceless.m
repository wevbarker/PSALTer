(*==============================*)
(*  MakeAutomaticallyTraceless  *)
(*==============================*)

MakeAutomaticallyTraceless::MakeTraceless="Can't remove trace `1`.";

MakeAutomaticallyTraceless[InputExpr_?xTensorQ]:=Module[{
	TensorName=InputExpr,
	TensorIndexed=InputExpr,
	NumberOfIndices=Length@SlotsOfTensor@InputExpr
	},
	Diagnostic@TensorName;

	If[NumberOfIndices>=2,
		TensorIndexed//=ToIndexFree;
		TensorIndexed//=FromIndexFree;	
		TensorContractions=AllContractions[TensorIndexed,UncontractedIndices->(NumberOfIndices-2),Parallelization->False];
		Diagnostic@TensorContractions;

		(
		TensorTrace=#;
		Diagnostic@TensorTrace;
		DaggerTensorTrace=Dagger@TensorTrace;
		Diagnostic@DaggerTensorTrace;

		Quiet@AutomaticRules[
			Evaluate@(Dagger@TensorName),
			MakeRule[{Evaluate@DaggerTensorTrace,0},
			MetricOn->All,
			ContractMetrics->True]];

		Quiet@AutomaticRules[
			Evaluate@TensorName,
			MakeRule[{Evaluate@TensorTrace,0},
			MetricOn->All,
			ContractMetrics->True]];

		If[!(ToCanonical@TensorTrace===0),
			Throw[Message[MakeAutomaticallyTraceless::MakeTraceless,TensorTrace],
				HaltBuild]
			];
		If[!(ToCanonical@DaggerTensorTrace===0),
			Throw[Message[MakeAutomaticallyTraceless::MakeTraceless,DaggerTensorTrace],
				HaltBuild]
			];

		)&/@TensorContractions;
	];	
];
