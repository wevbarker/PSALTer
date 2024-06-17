(*=================*)
(*  AppendToField  *)
(*=================*)

AppendToField[KinematicContext_,AssocKey_,InputValue_]:=Module[{
	FieldAssociationValue},

	(!(AssociationQ@FieldAssociation@KinematicContext))~If~(FieldAssociation@KinematicContext:=<||>);
	FieldAssociationValue=FieldAssociation@KinematicContext;
	Clear@KinematicContext;
	FieldAssociationValue@AssocKey=InputValue;
	FieldAssociation@KinematicContext:=FieldAssociationValue;
];
