(*=====================================*)
(*  MakeAutomaticallyNotAntisymmetric  *)
(*=====================================*)

IncludeHeader@"RemoveContraction";

MakeAutomaticallyNotAntisymmetric[InputExpr_?xTensorQ]~Y~Module[{
	TensorName=InputExpr,
	NumberOfIndices=Length@SlotsOfTensor@InputExpr
	},

	Diagnostic@TensorName;
	If[IsNegativeParitySpinTwo@TensorName,
		TensorContractions=AllContractions[IndexFree@(TensorName*xAct`PSALTer`epsilonG*xAct`PSALTer`V),UncontractedIndices->None,Parallelization->False];
		Diagnostic@TensorContractions;
		RemoveContraction[#,TensorName]&/@TensorContractions;
	];	
];
