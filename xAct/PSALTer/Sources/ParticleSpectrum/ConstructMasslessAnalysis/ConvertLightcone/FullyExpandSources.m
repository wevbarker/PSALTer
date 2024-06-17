(*======================*)
(*  FullyExpandSources  *)
(*======================*)

FullyExpandSources[ClassName_?StringQ,RawSector_]:=Module[{
	Class,
	Sector=RawSector},

	Class=Evaluate@Symbol@ClassName;

	Sector//=Class@ExpandSources;
	Sector//=Expand;
Sector];
