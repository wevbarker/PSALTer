(*========================*)
(*  ConstrainInLightcone  *)
(*========================*)

ConstrainInLightcone[RawSector_,SourceComponentsToFreeSourceVariables_List]:=Module[{
	Sector=RawSector},

	Sector//=GradualExpand[CouplingAssumptions,#,SourceComponentsToFreeSourceVariables]&;
	Sector//=Expand;
Sector];
