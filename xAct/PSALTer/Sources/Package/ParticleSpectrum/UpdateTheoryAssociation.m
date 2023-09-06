(*===========================*)
(*  UpdateTheoryAssociation  *)
(*===========================*)

Options@UpdateTheoryAssociation={Advertise->False,ExportTheory->False};

UpdateTheoryAssociation[Name_?StringQ,AssocKey_,Val_,OptionsPattern[]]:=Module[{
	TheoryAssociation,
	PrintVariable},


	(*PrintVariable=PrintTemporary["** DefTheory: Defining association key ",ToString@AssocKey," for the theory association ",Name];*)

	If[!(AssociationQ@Evaluate@Symbol@Name),(Evaluate@Symbol@Name)=<||>];
	TheoryAssociation=Evaluate@Symbol@Name;
	Clear@Name;
	TheoryAssociation@AssocKey=Val;
	(Evaluate@Symbol@Name)=TheoryAssociation;
	(*NotebookDelete@PrintVariable;*)

	Quiet@Catch@DistributeDefinitions@Symbol@Name;

	If[OptionValue@Advertise,
		(*Print["** DefTheory: Defining association key ",ToString@AssocKey," for the theory association ",Name];*)
	];

	If[OptionValue@ExportTheory,
		(*Print[" ** DefTheory: Exporting the binary at "<>Name<>".thr.mx"];*)
		DumpSave[FileNameJoin@{$WorkingDirectory,Name<>".thr.mx"},{Name}];
	];

];
