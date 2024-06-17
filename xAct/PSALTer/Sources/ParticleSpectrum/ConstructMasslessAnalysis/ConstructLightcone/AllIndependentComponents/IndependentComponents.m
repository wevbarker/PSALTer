(*=========================*)
(*  IndependentComponents  *)
(*=========================*)

IndependentComponents[ClassName_?StringQ,Tensors_List]:=Module[{
	Class,
	ComponentsList},

	Class=Evaluate@Symbol@ClassName;
	ComponentsList=xAct`xCoba`ComponentArray[xAct`xCoba`FreeToBasis[xAct`PSALTer`cartesian]@#]&/@Tensors;
	ComponentsList//=Flatten;
	(ComponentsList=ComponentsList/.xAct`xCoba`TensorValues[#])&/@(Class@Sources);
	ComponentsList=ComponentsList~DeleteCases~0; 
	ComponentsList=Sqrt[ComponentsList ComponentsList]//PowerExpand;
	ComponentsList//=DeleteDuplicates;
ComponentsList];
