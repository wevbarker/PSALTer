(*============================*)
(*  AllIndependentComponents  *)
(*============================*)

IncludeHeader@"IndependentComponents";

AllIndependentComponents[ClassName_?StringQ]:=Module[{
	Class,
	Tensors,
	ComponentsList},

	Class=Evaluate@Symbol@ClassName;
	Tensors=((FromIndexFree@ToIndexFree@#)/.{-SomeIndex_?TangentM4`Q->SomeIndex}/.{SomeIndex_?TangentM4`Q->-SomeIndex})&/@(Class@Sources);
	ComponentsList=IndependentComponents[ClassName,Tensors];
ComponentsList];
