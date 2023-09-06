(*=====================================*)
(*  MakeAutomaticallyNotAntisymmetric  *)
(*=====================================*)

MakeAutomaticallyNotAntisymmetric::MakeNotAntisymmetric="Can't remove antisymmetric part `1`.";

MakeAutomaticallyNotAntisymmetric[InputExpr_?xTensorQ]:=Module[{
	TensorName=InputExpr,
	NumberOfIndices=Length@SlotsOfTensor@InputExpr
	},
	Diagnostic@TensorName;

	If[NumberOfIndices===3,

		TensorContractions=AllContractions[IndexFree@(TensorName*xAct`PSALTer`epsilonG*xAct`PSALTer`V),UncontractedIndices->None,Parallelization->False];
		Diagnostic@TensorContractions;

		(
		TensorAntisymmetric=#;
		Diagnostic@TensorAntisymmetric;
		DaggerTensorAntisymmetric=Dagger@TensorAntisymmetric;
		Diagnostic@DaggerTensorAntisymmetric;

		Quiet@AutomaticRules[
			Evaluate@(Dagger@TensorName),
			MakeRule[{Evaluate@DaggerTensorAntisymmetric,0},
			MetricOn->All,
			ContractMetrics->True]];

		Quiet@AutomaticRules[
			Evaluate@TensorName,
			MakeRule[{Evaluate@TensorAntisymmetric,0},
			MetricOn->All,
			ContractMetrics->True]];

		If[!(ToCanonical@TensorAntisymmetric===0),
			Throw[Message[MakeAutomaticallyNotAntisymmetric::MakeNotAntisymmetric,TensorAntisymmetric],
				HaltBuild]
			];
		If[!(ToCanonical@DaggerTensorAntisymmetric===0),
			Throw[Message[MakeAutomaticallyNotAntisymmetric::MakeNotAntisymmetric,DaggerTensorAntisymmetric],
				HaltBuild]
			];

		)&/@TensorContractions;
	];	
];
