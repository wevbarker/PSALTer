(*===========================*)
(*  UpdateTheoryAssociation  *)
(*===========================*)

UpdateTheoryAssociation[Name_?StringQ,AssocKey_,Val_]~Y~Module[{
	TheoryAssociation},

	If[!(AssociationQ@Evaluate@Symbol@Name),(Evaluate@Symbol@Name)=<||>];
	TheoryAssociation=Evaluate@Symbol@Name;
	Clear@Name;
	TheoryAssociation@AssocKey=Val;
	(Evaluate@Symbol@Name)=TheoryAssociation;
	Quiet@Catch@DistributeDefinitions@Symbol@Name;
	DumpSave[FileNameJoin@{$WorkingDirectory,"ParticleSpectrograph"<>Name<>".mx"},{Name}];
];
