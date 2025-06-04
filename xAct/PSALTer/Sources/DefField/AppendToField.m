(*=================*)
(*  AppendToField  *)
(*=================*)

AppendToField[KinematicContext_,AssocKey_,InputValue_]~Y~Module[{
	FieldAssociationValue},

	(!(AssociationQ@FieldAssociation@KinematicContext))~If~(FieldAssociation@KinematicContext~Y~<||>);
	FieldAssociationValue=FieldAssociation@KinematicContext;
	Clear@KinematicContext;
	FieldAssociationValue@AssocKey=InputValue;
	FieldAssociation@KinematicContext~Y~FieldAssociationValue;
];
