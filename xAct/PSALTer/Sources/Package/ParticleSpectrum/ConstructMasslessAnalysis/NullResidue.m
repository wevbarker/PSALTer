(*===============*)
(*  NullResidue  *)
(*===============*)

NullResidue[LightconePropagator_,LaurentDepth_]:=Module[{
	MasslessPropagaor=LightconePropagator,
	MasslessPropagaorResidue},

	MasslessPropagaor//=Together;
	MasslessPropagaorResidue=((2*Mo)^LaurentDepth)*Residue[MasslessPropagaor*((En-Mo)^(LaurentDepth-1)),{En,Mo}]//Simplify;
	(*MasslessPropagaorResidue=2*Mo*Residue[MasslessPropagaor,{En,Mo}]//Simplify;*)
MasslessPropagaorResidue];
