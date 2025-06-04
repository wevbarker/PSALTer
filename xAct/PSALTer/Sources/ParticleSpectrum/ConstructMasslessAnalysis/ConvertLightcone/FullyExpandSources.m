(*======================*)
(*  FullyExpandSources  *)
(*======================*)

FullyExpandSources[ClassName_?StringQ,RawSector_]~Y~Module[{
	Class,
	Sector=RawSector},

	Class=Evaluate@Symbol@ClassName;

	Sector//=Class@ExpandSources;
	Sector//=Expand;
Sector];
