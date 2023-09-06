(*===============================*)
(*  MakeConstraintComponentList  *)
(*===============================*)

MakeConstraintComponentList[ClassName_?StringQ,PropagatorConstraints_List,ManualConstraints_List:{}]:=Module[{
	Class,
	AllConstraints,
	ConstraintComponents},

	Class=Evaluate@Symbol@ClassName;

	(*First join up the automatically and manually derived constraints lists*)
	AllConstraints=PropagatorConstraints~Join~ManualConstraints;
	(*Obtain nested lists of all the Cartesian components of the vanishing constraint functions*)
	ConstraintComponents=If[Length@FindFreeIndices@#!=0,xAct`xCoba`ComponentArray[xAct`xCoba`FreeToBasis[xAct`PSALTer`cartesian]@#],#]&/@AllConstraints;
	(*Flatten them*)
	ConstraintComponents=Flatten@ConstraintComponents;
	(*Use the symmetries of the SO(3) irreps to "canonicalise" these component expressions via folded rules*)
	(ConstraintComponents=ConstraintComponents/.xAct`xCoba`TensorValues@#)&/@(Flatten@Map[Values,Class@SourceSpinParityTensorHeads,{0,2}]);

	(*Remove symmetry-vanishing and duplicate entries that the "canonicalisation" reveals*)
	ConstraintComponents=ConstraintComponents~DeleteCases~0;
	ConstraintComponents//=DeleteDuplicates;
ConstraintComponents];
