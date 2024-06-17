(*======================*)
(*  ExpressInLightcone  *)
(*======================*)

ExpressInLightcone[ClassName_?StringQ,RawSector_]:=Module[{
	Class,
	Sector=RawSector},

	Class=Evaluate@Symbol@ClassName;

	Sector//=xAct`xCoba`SeparateBasis[cartesian];
	Sector//=xAct`xCoba`ContractBasis;
	Sector//=xAct`xCoba`TraceBasisDummy;
	Sector=Sector/.xAct`xCoba`TensorValues[P];
	Sector=Sector/.xAct`xCoba`TensorValues[G];
	(Sector=Sector/.xAct`xCoba`TensorValues[#])&/@(Class@Sources);
	(Sector=Sector/.xAct`xCoba`TensorValues[#])&/@(Dagger/@(Class@Sources));
	Sector=Sector/.{Def->Sqrt[En^2-Mo^2]};
	Sector//=Expand;
Sector];
