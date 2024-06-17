(*==============*)
(*  DefSummary  *)
(*==============*)

DefSummary[]:=Module[{
	Class,
	TensorsValue,
	SourcesValue,
	SpinsValue},

	Class=FieldAssociation@Context[];

	TensorsValue=Keys@Class@FieldSpinParityTensorHeads;
	SourcesValue=Keys@Class@SourceSpinParityTensorHeads;
	SpinsValue=Sort@DeleteDuplicates@Flatten@(Keys/@(Values@Class@FieldSpinParityTensorHeads));
	AppendToField[Context[],Tensors,TensorsValue];
	AppendToField[Context[],Sources,SourcesValue];
	AppendToField[Context[],Spins,SpinsValue];
];
