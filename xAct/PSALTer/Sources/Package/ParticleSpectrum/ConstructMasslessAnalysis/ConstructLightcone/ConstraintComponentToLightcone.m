(*==================================*)
(*  ConstraintComponentToLightcone  *)
(*==================================*)

ConstraintComponentToLightcone[ClassName_?StringQ,ConstraintComponent_]:=Module[{
	Class,
	Constraint=ConstraintComponent},

	Class=Evaluate@Symbol@ClassName;

	Block[{NoScalar=#&,xAct`PSALTer`Private`ToNewCanonical=#&},
		Constraint//=Class@ExpandSources;
	];

	Diagnostic@Constraint;

	Constraint//=xAct`xCoba`SeparateBasis[AIndex];
	Diagnostic@Constraint;
	Constraint//=NoScalar;
	Diagnostic@Constraint;
	Constraint=Constraint/.ToP;
	Diagnostic@Constraint;
	Constraint//=ToNewCanonical;
	Diagnostic@Constraint;
	Constraint//=NoScalar;
	Constraint=Constraint/.ToV;
	Constraint//=ToNewCanonical;
	Diagnostic@Constraint;
	Constraint=Constraint//NoScalar;
	Constraint=Constraint/.ToP;
	Constraint//=xAct`xCoba`SeparateBasis[AIndex];
	Constraint//=NoScalar;
	Constraint=Constraint/.ToP;
	Constraint//=NoScalar;
	Constraint//=xAct`xCoba`SeparateBasis[xAct`PSALTer`cartesian];
	Diagnostic@Constraint;
	Constraint//=NoScalar;
	Constraint=Constraint/.ToP;
	Constraint//=xAct`xCoba`ContractBasis;
	Constraint//=ScreenDollarIndices;
	Diagnostic@Constraint;
	Constraint//=NoScalar;
	Constraint//=(SeparateMetric[G][Evaluate@#]&);
	Constraint//=xAct`xCoba`SeparateBasis[xAct`PSALTer`cartesian];
	Diagnostic@Constraint;
	Constraint//=NoScalar;
	Constraint//=xAct`xCoba`ContractBasis;
	Diagnostic@Constraint;
	Constraint//=NoScalar;
	Constraint//=xAct`xCoba`TraceBasisDummy;
	Constraint=Constraint/.xAct`xCoba`TensorValues[P];
	Constraint=Constraint/.xAct`xCoba`TensorValues[G];
	Diagnostic@Constraint;

	(Constraint=Constraint/.xAct`xCoba`TensorValues[#])&/@(Class@Sources);

	Constraint=Constraint/.{Def->Sqrt[En^2-Mo^2]};
	Constraint/=(2*3*5*7*11*En Mo)^10;
	Diagnostic@Constraint;
	Constraint//=Together;
	Constraint//=Numerator;
	Constraint//=CollectTensors;
	Diagnostic@Constraint;
Constraint==0];
