(*=========================*)
(*  IndependentComponents  *)
(*=========================*)

IndependentComponents[ClassName_?StringQ,Tensors_List]:=Module[{
	Class,
	ComponentsList},

	Class=Evaluate@Symbol@ClassName;

	(*make a big nested array of components*)
	ComponentsList=xAct`xCoba`ComponentArray[xAct`xCoba`FreeToBasis[xAct`PSALTer`cartesian]@#]&/@Tensors;
	(*flatten it*)
	ComponentsList=Flatten@ComponentsList;

	(ComponentsList=ComponentsList/.xAct`xCoba`TensorValues[#])&/@(Class@Sources);

	(*get rid of zereos*)
	ComponentsList=ComponentsList~DeleteCases~0; 

	(*we want to get rid of minus signs*)
	ComponentsList=Sqrt[ComponentsList ComponentsList]//PowerExpand;
	ComponentsList=ComponentsList//DeleteDuplicates;
ComponentsList];
