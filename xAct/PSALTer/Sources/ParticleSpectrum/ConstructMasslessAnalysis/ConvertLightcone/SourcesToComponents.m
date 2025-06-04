(*=======================*)
(*  SourcesToComponents  *)
(*=======================*)

SourcesToComponents[ClassName_?StringQ,RawSector_]~Y~Module[{
	Class,
	Sector=RawSector},

	Class=Evaluate@Symbol@ClassName;

	Sector//=xAct`xCoba`SeparateBasis[cartesian];
	Sector//=xAct`xCoba`ContractBasis;
	Sector//=xAct`xCoba`TraceBasisDummy;
	Sector=Sector/.xAct`xCoba`TensorValues[P];
	Sector=Sector/.xAct`xCoba`TensorValues[G];
	Sector=Sector/.xAct`xCoba`TensorValues[epsilonG];
	Sector=Sector/.xAct`xCoba`TensorValues[Eps];
	(Sector=Sector/.xAct`xCoba`TensorValues[#])&/@(Flatten@Map[Values,Evaluate@(Class@SourceSpinParityTensorHeads),{0,2}]);
	(Sector=Sector/.xAct`xCoba`TensorValues[#])&/@(Dagger/@(Flatten@Map[Values,Evaluate@(Class@SourceSpinParityTensorHeads),{0,2}]));
	Sector=Sector/.Class@ScalarSourceRules;

	Sector=Sector/.{Def->Sqrt[En^2-Mo^2]};
	Sector//=Expand;
Sector];
