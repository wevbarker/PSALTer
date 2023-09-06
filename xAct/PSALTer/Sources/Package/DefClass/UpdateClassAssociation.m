(*==========================*)
(*  UpdateClassAssociation  *)
(*==========================*)

Options@UpdateClassAssociation={Advertise->False,ExportClass->False};

UpdateClassAssociation[Name_?StringQ,AssocKey_,Val_,OptionsPattern[]]:=Module[{
	ClassAssociation,
	PrintVariable},

	PrintVariable=PrintTemporary["** DefClass: Defining association key ",ToString@AssocKey," for the class association ",Name];

	If[!(AssociationQ@Evaluate@Symbol@Name),(Evaluate@Symbol@Name)=<||>];
	ClassAssociation=Evaluate@Symbol@Name;
	Clear@Name;
	ClassAssociation@AssocKey=Val;
	(Evaluate@Symbol@Name)=ClassAssociation;
	NotebookDelete@PrintVariable;

	Quiet@Catch@DistributeDefinitions@Symbol@Name;

	If[OptionValue@Advertise,
		Print["** DefClass: Defining association key ",ToString@AssocKey," for the class association ",Name];
	];

	If[OptionValue@ExportClass,
		Print[" ** DefClass: Exporting the binary at "<>Name<>".cla.mx"];
		DumpSave[FileNameJoin@{$WorkingDirectory,Name<>".cla.mx"},{Name}];
	];

];
