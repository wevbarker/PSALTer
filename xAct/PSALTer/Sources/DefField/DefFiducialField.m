(*====================*)
(*  DefFiducialField  *)
(*====================*)

DefFiducialField[FiducialFieldName_[FiducialFieldInds___]]:=DefFiducialField[FiducialFieldName[FiducialFieldInds],GenSet[]];

DefFiducialField[FiducialFieldName_[FiducialFieldInds___],SymmExpr_]:=Module[{
	SourceFiducialFieldName,
	FieldName},

	MultiTermSymmetriesOf@FiducialFieldName^=OptionValue@MultiTermSymmetries;
	
	DefTensor[
		FiducialFieldName[FiducialFieldInds],
		xAct`PSALTer`M4,
		SymmExpr,
		PrintAs->xAct`PSALTer`Private`PrintAsValue,
		Dagger->Complex];	
	AppendToField[Context[],FieldSpinParityTensorHeads,<|FiducialFieldName-><||>|>];

	SourceFiducialFieldName=ToExpression@((ToString@FiducialFieldName)~StringReplace~("Rank"->"SourceRank"));
	DefTensor[
		SourceFiducialFieldName[FiducialFieldInds],
		xAct`PSALTer`M4,
		SymmExpr,
		PrintAs->xAct`PSALTer`Private`PrintSourceAsValue,
		Dagger->Complex];
	AppendToField[Context[],SourceSpinParityTensorHeads,<|SourceFiducialFieldName-><||>|>];
	FieldName=StringReplace[Context[],"xAct`PSALTer`"->""];
	FieldName=StringReplace[FieldName,"`"->""];
	FieldToFiducialFieldValue=MakeRule[{Evaluate[(Symbol@FieldName)@FiducialFieldInds],FiducialFieldName@FiducialFieldInds},MetricOn->All,ContractMetrics->True];
	AppendToField[Context[],FieldToFiducialField,FieldToFiducialFieldValue];
];
