(*===============================*)
(*  MakeConstraintComponentList  *)
(*===============================*)

MakeConstraintComponentList[ClassName_?StringQ,PropagatorConstraints_List,ManualConstraints_List:{}]:=Module[{
	Class,
	AllConstraints,
	ConstraintComponents},

	Class=Evaluate@Symbol@ClassName;
	AllConstraints=PropagatorConstraints~Join~ManualConstraints;
	ConstraintComponents=If[Length@FindFreeIndices@#!=0,xAct`xCoba`ComponentArray[xAct`xCoba`FreeToBasis[xAct`PSALTer`cartesian]@#],#]&/@AllConstraints;
	ConstraintComponents=Flatten@ConstraintComponents;
	(ConstraintComponents=ConstraintComponents/.xAct`xCoba`TensorValues@#)&/@(Flatten@Map[Values,Class@SourceSpinParityTensorHeads,{0,2}]);
	ConstraintComponents=ConstraintComponents~DeleteCases~0;
	ConstraintComponents//=DeleteDuplicates;
ConstraintComponents];
