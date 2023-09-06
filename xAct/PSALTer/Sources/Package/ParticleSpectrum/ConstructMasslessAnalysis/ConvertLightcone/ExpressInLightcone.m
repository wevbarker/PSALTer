(*======================*)
(*  ExpressInLightcone  *)
(*======================*)

ExpressInLightcone[ClassName_?StringQ,RawSector_,SourceComponentsToFreeSourceVariables_List]:=Module[{
	Class,
	Sector=RawSector},

	Class=Evaluate@Symbol@ClassName;

	LocalMasslessSpectrum=" ** MassiveAnalysisOfSector...";

	Sector//=Class@ExpandSources;

	Sector//=xAct`xCoba`SeparateBasis[AIndex];
	Sector=Sector/.ToP;
	Sector//=NoScalar;
	Sector//=ToNewCanonical;
	Sector=Sector/.ToV;
	Sector//=ToNewCanonical;
	Sector=Sector/.ToP;
	Sector//=xAct`xCoba`SeparateBasis[AIndex];
	Sector//=NoScalar;
	Sector=Sector/.ToP;
	Sector//=ToNewCanonical;
	Sector//=NoScalar;

	LocalMasslessSpectrum=" ** SeparateMetric...";
	Sector=SeparateMetric[G][Evaluate@Sector];

	LocalMasslessSpectrum=" ** SeparateBasis...";
	Sector//=xAct`xCoba`SeparateBasis[cartesian];

	LocalMasslessSpectrum=" ** ContractBasis...";
	Sector//=xAct`xCoba`ContractBasis;

	LocalMasslessSpectrum=" ** TraceBasisDummy...";
	Sector//=xAct`xCoba`TraceBasisDummy;

	LocalMasslessSpectrum=" ** TensorValues...";
	Sector=Sector/.xAct`xCoba`TensorValues[P];
	Sector=Sector/.xAct`xCoba`TensorValues[G];

	(Sector=Sector/.xAct`xCoba`TensorValues[#])&/@(Class@Sources);
	(Sector=Sector/.xAct`xCoba`TensorValues[#])&/@(Dagger/@(Class@Sources));

	Sector=Sector/.{Def->Sqrt[En^2-Mo^2]};
	Sector//=Together;

	LocalMasslessSpectrum=" ** Imposing conserved sources...";
	Sector=Sector/.SourceComponentsToFreeSourceVariables;
	Sector//=Together;

Sector];
