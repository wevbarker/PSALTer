(*============*)
(*  DefClass  *)
(*============*)

BuildPackage@"DefClass/BasicInformation.m";
BuildPackage@"DefClass/GetTensorComponents.m";
BuildPackage@"DefClass/ValidateModes.m";
BuildPackage@"DefClass/GenerateAnsatz.m";
BuildPackage@"DefClass/NormaliseRescalings.m";

BuildPackage@"DefClass/UndefClass.m";
BuildPackage@"DefClass/UpdateClassAssociation.m";

DefClass::notclassname="Argument `1` is not a string from which a symbol can be defined to store the class association.";
DefClass::nobin="The binary at `1` cannot be found; quitting.";

Options[DefClass]={
	ExportClass->False,
	ImportClass->False};

DefClass[ClassName_?StringQ,
	LagrangianCouplingsInput_?ListQ,
	FieldSpinParityTensorHeadsInput_?AssociationQ,
	SourceSpinParityTensorHeadsInput_?AssociationQ,
	SourceEngineeringDimensionsInput_?AssociationQ,
	ExpandFieldsInput_,
	DecomposeFieldsInput_,
	ExpandSourcesInput_,
	OptionsPattern[]]:=Module[{},

	(*Firstly we remove all definitions which might be associated with a class already*)
	UndefClass[];
	If[OptionValue@ImportClass,

		Print[" ** DefClass: Incorporating the binary at "<>ClassName<>".cla.mx"];

		Check[ToExpression["<<"<>FileNameJoin@{$WorkingDirectory,ClassName<>".cla.mx"}<>";"],Throw@Message[DefClass::nobin,FileNameJoin@{$WorkingDirectory,ClassName<>".cla.mx"}];Quit[];];,

		Print["** DefClass: The information presented below will be stored in the association ",ClassName,", so you will be able to recover it later in your session by typing \"",ClassName,"[<--some_association_key-->]\"."];

		UpdateClassAssociation[ClassName,LagrangianCouplings,LagrangianCouplingsInput];
		UpdateClassAssociation[ClassName,FieldSpinParityTensorHeads,FieldSpinParityTensorHeadsInput];
		UpdateClassAssociation[ClassName,SourceSpinParityTensorHeads,SourceSpinParityTensorHeadsInput];
		UpdateClassAssociation[ClassName,ExpandFields,ExpandFieldsInput];
		UpdateClassAssociation[ClassName,DecomposeFields,DecomposeFieldsInput];
		UpdateClassAssociation[ClassName,ExpandSources,ExpandSourcesInput];
		UpdateClassAssociation[ClassName,SourceEngineeringDimensions,SourceEngineeringDimensionsInput];

		(*--------------------------------------------*)
		(*  These functions do much of the hard work  *)
		(*--------------------------------------------*)

		BasicInformation[ClassName];
		ValidateModes[ClassName];
		GetTensorComponents[ClassName];
		GenerateAnsatz[ClassName];
		NormaliseRescalings[ClassName];
	];

	If[OptionValue@ExportClass,
		Print[" ** DefClass: Exporting the binary at "<>ClassName<>".cla.mx"];
		DumpSave[FileNameJoin@{$WorkingDirectory,ClassName<>".cla.mx"},{ClassName}];
	];
	ToExpression@("xAct`PSALTer`Private`ClassNames~AppendTo~"<>ClassName);
];
