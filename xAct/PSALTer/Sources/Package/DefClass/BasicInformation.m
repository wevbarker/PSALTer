(*====================*)
(*  BasicInformation  *)
(*====================*)

BasicInformation[ClassName_?StringQ]:=Module[{
	Class,
	TensorsValue,
	SourcesValue,
	SpinsValue
	},

	Class=Evaluate@Symbol@ClassName;

	TensorsValue=Keys@Class@FieldSpinParityTensorHeads;
	SourcesValue=Keys@Class@SourceSpinParityTensorHeads;
	SpinsValue=Sort@DeleteDuplicates@Flatten@(Keys/@(Values@Class@FieldSpinParityTensorHeads));

	UpdateClassAssociation[ClassName,Tensors,TensorsValue];
	UpdateClassAssociation[ClassName,Sources,SourcesValue];
	UpdateClassAssociation[ClassName,Spins,SpinsValue];
];
