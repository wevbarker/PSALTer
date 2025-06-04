(*========================*)
(*  ConstrainInLightcone  *)
(*========================*)

ConstrainInLightcone[RawSector_,SourceComponentsToFreeSourceVariables_List]~Y~Module[{
	Sector=RawSector},

	Sector//=GradualExpand[CouplingAssumptions,#,SourceComponentsToFreeSourceVariables]&;
	Sector//=Expand;
Sector];
