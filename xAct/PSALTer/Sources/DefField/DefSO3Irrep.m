(*===============*)
(*  DefSO3Irrep  *)
(*===============*)

IncludeHeader@"MakeAutomaticallyTraceless";
IncludeHeader@"MakeAutomaticallyNotAntisymmetric";
IncludeHeader@"MakeUniqueQuadratic";
IncludeHeader@"DefSymbol";

Options@DefSO3Irrep={
	MultiTermSymmetries->{},
	Spin->0,	
	Parity->Even};

DefSO3Irrep[SO3IrrepName_[SO3IrrepInds___],
		Opts___?OptionQ]:=DefSO3Irrep[SO3IrrepName[SO3IrrepInds],GenSet[],Opts];

DefSO3Irrep[SO3IrrepName_[SO3IrrepInds___],
		SymmExpr_,OptionsPattern[]]:=Module[{
	Symb,
	SourceSO3IrrepName,
	FiducialFieldName,
	FiducialSourceName,
	Expr},

	MultiTermSymmetriesOf@SO3IrrepName^=OptionValue@MultiTermSymmetries;
	FiducialFieldName=First@Keys@((FieldAssociation@Context[])@FieldSpinParityTensorHeads);
	Expr=First@Values@((FieldAssociation@Context[])@FieldSpinParityTensorHeads);
	(!(AssociationQ@Expr@(OptionValue@Spin)))~If~(Expr@(OptionValue@Spin)=<|Even->{},Odd->{}|>);
	((Expr@(OptionValue@Spin))@(OptionValue@Parity))~AppendTo~SO3IrrepName;
	Expr=<|FiducialFieldName->Expr|>;
	AppendToField[Context[],FieldSpinParityTensorHeads,Expr];
	Symb=DefSymbol[xAct`PSALTer`Private`PrintAsValue,Spin->OptionValue@Spin,Parity->OptionValue@Parity,Duplicate->Length@(((Expr@FiducialFieldName)@(OptionValue@Spin))@(OptionValue@Parity))];
	DefTensor[
		SO3IrrepName[SO3IrrepInds],
		xAct`PSALTer`M4,
		SymmExpr,
		PrintAs->Symb,
		OrthogonalTo->((V@Minus@#)&/@(List@SO3IrrepInds)),
		Dagger->Complex];	
	MakeAutomaticallyTraceless@SO3IrrepName;	
	MakeAutomaticallyNotAntisymmetric@SO3IrrepName;
	MakeUniqueQuadratic@SO3IrrepName;

	SourceSO3IrrepName=ToExpression@((ToString@SO3IrrepName)~StringReplace~("Rank"->"SourceRank"));
	MultiTermSymmetriesOf@SourceSO3IrrepName^=((OptionValue@MultiTermSymmetries)/.{SO3IrrepName->SourceSO3IrrepName});
	FiducialSourceName=First@Keys@((FieldAssociation@Context[])@SourceSpinParityTensorHeads);
	Expr=First@Values@((FieldAssociation@Context[])@SourceSpinParityTensorHeads);
	(!(AssociationQ@Expr@(OptionValue@Spin)))~If~(Expr@(OptionValue@Spin)=<|Even->{},Odd->{}|>);
	((Expr@(OptionValue@Spin))@(OptionValue@Parity))~AppendTo~SourceSO3IrrepName;
	Expr=<|FiducialSourceName->Expr|>;
	AppendToField[Context[],SourceSpinParityTensorHeads,Expr];
	Symb=DefSymbol[xAct`PSALTer`Private`PrintSourceAsValue,Spin->OptionValue@Spin,Parity->OptionValue@Parity,Duplicate->Length@(((Expr@FiducialSourceName)@(OptionValue@Spin))@(OptionValue@Parity))];
	DefTensor[
		SourceSO3IrrepName[SO3IrrepInds],
		xAct`PSALTer`M4,
		SymmExpr,
		PrintAs->Symb,
		OrthogonalTo->(V@Minus@#)&/@(List@SO3IrrepInds),
		Dagger->Complex];	
	MakeAutomaticallyTraceless@SourceSO3IrrepName;
	MakeAutomaticallyNotAntisymmetric@SourceSO3IrrepName;
	MakeUniqueQuadratic@SourceSO3IrrepName;
];
