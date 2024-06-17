(*=====================*)
(*  FullyCanonicalise  *)
(*=====================*)

FullyCanonicalise[RawSector_]:=Module[{	
	Sector=RawSector},

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
	Sector=SeparateMetric[G][Evaluate@Sector];
Sector];
