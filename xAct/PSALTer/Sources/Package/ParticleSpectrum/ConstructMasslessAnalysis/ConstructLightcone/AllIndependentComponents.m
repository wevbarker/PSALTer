(*============================*)
(*  AllIndependentComponents  *)
(*============================*)

BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConstructLightcone/IndependentComponents.m";

AllIndependentComponents[ClassName_?StringQ]:=Module[{
	Class,
	Tensors,
	ComponentsList},

	Class=Evaluate@Symbol@ClassName;

	Tensors=((FromIndexFree@ToIndexFree@#)/.{-SomeIndex_?TangentM4`Q->SomeIndex}/.{SomeIndex_?TangentM4`Q->-SomeIndex})&/@(Class@Sources);

	(*make a big nested array of components*)
	ComponentsList=IndependentComponents[ClassName,Tensors];

ComponentsList];
