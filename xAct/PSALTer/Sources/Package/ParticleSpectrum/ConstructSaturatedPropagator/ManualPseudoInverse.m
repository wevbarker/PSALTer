(*=======================*)
(*  ManualPseudoInverse  *)
(*=======================*)

ManualPseudoInverse[TheInputMatrix_List?MatrixQ/;Precision[TheInputMatrix]===Infinity,TheConjecturedNullSpace_]:=Module[{
	DimensionsOfMatrix,
	OriginalNullSpace=TheConjecturedNullSpace,
	ColumnNullSpace,
	RowNullSpace,
	CompensatorMatrix,
	Similarity,
	RawInverse,
	PseudoInverseMatrix},
	
	LocalPropagator=" ** ManualPseudoInverse...";

	DimensionsOfMatrix=Length@TheInputMatrix;

	OriginalNullSpace=If[OriginalNullSpace==={},
			{Table[0,{DimensionsOfMatrix}]},OriginalNullSpace];

	Assuming[xAct`PSALTer`Def>0,
		OriginalNullSpace=FullSimplify@Orthogonalize@OriginalNullSpace];

	ColumnNullSpace=Transpose@OriginalNullSpace;
	Assuming[xAct`PSALTer`Def>0,RowNullSpace=Conjugate@OriginalNullSpace];

	(MatrixForm@Assuming[xAct`PSALTer`Def>0,
			FullSimplify@(RowNullSpace.ColumnNullSpace)]);

	CompensatorMatrix=ColumnNullSpace.RowNullSpace;
	Assuming[xAct`PSALTer`Def>0,CompensatorMatrix//=FullSimplify];
	Diagnostic@@CompensatorMatrix;

	Similarity=(IdentityMatrix@DimensionsOfMatrix)-CompensatorMatrix;

	(MatrixForm@Assuming[xAct`PSALTer`Def>0,
			FullSimplify@(Similarity.ColumnNullSpace)]);

	PseudoInverseMatrix=Assuming[xAct`PSALTer`Def>0,
				Inverse[TheInputMatrix+CompensatorMatrix]];

	PseudoInverseMatrix=Assuming[xAct`PSALTer`Def>0,
				PseudoInverseMatrix.Similarity];

	PseudoInverseMatrix=Assuming[xAct`PSALTer`Def>0,
				(ConjugateTranspose@Similarity).PseudoInverseMatrix];

	(*PseudoInverseMatrix=Inverse[(ConjugateTranspose@TheInputMatrix).TheInputMatrix+(ConjugateTranspose@CompensatorMatrix).CompensatorMatrix].(ConjugateTranspose@TheInputMatrix);*)
(*
	PseudoInverseMatrix=Inverse[(ConjugateTranspose@TheInputMatrix).TheInputMatrix+(ConjugateTranspose@CompensatorMatrix).CompensatorMatrix].(ConjugateTranspose@TheInputMatrix);
*)
PseudoInverseMatrix];
