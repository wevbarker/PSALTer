(*=======================*)
(*  ManualPseudoInverse  *)
(*=======================*)

IncludeHeader@"ParameterisedNullVectorQ";
IncludeHeader@"CarefullyOrthogonalise";

ManualPseudoInverse[TheInputMatrix_List?MatrixQ/;Precision[TheInputMatrix]===Infinity,TheConjecturedNullSpace_]:=Module[{
	DimensionsOfMatrix,
	OriginalNullSpace=TheConjecturedNullSpace,
	ColumnNullSpace,
	RowNullSpace,
	CompensatorMatrix,
	Similarity,
	RawInverse,
	PseudoInverseMatrix,
	PseudoDeterminant},
	
	$LocalPropagator=" ** ManualPseudoInverse...";
	DimensionsOfMatrix=Length@TheInputMatrix;
	OriginalNullSpace=If[OriginalNullSpace==={},
			{Table[0,{DimensionsOfMatrix}]},OriginalNullSpace];
	Diagnostic@OriginalNullSpace;

	$LocalPropagator=" ** CarefullyOrthogonalise...";
	OriginalNullSpace//=CarefullyOrthogonalise;
	Diagnostic@OriginalNullSpace;

	$LocalPropagator=" ** Transpose...";
	ColumnNullSpace=Transpose@OriginalNullSpace;
	Assuming[xAct`PSALTer`Def>0,RowNullSpace=Conjugate@OriginalNullSpace];
	Diagnostic@RowNullSpace;
	Diagnostic@(MatrixForm@Assuming[xAct`PSALTer`Def>0,
			FullSimplify@(RowNullSpace.ColumnNullSpace)]);
	CompensatorMatrix=ColumnNullSpace.RowNullSpace;
	Diagnostic@CompensatorMatrix;
	Assuming[xAct`PSALTer`Def>0,CompensatorMatrix//=FullSimplify];
	Diagnostic@CompensatorMatrix;
	Similarity=(IdentityMatrix@DimensionsOfMatrix)-CompensatorMatrix;
	Diagnostic@Similarity;
	Diagnostic@(MatrixForm@Assuming[xAct`PSALTer`Def>0,
			FullSimplify@(Similarity.ColumnNullSpace)]);
	
	$LocalPropagator=" ** Adjugate...";
	PseudoInverseMatrix=Assuming[xAct`PSALTer`Def>0,
				Adjugate[TheInputMatrix+CompensatorMatrix]];
	Diagnostic@PseudoInverseMatrix;

	$LocalPropagator=" ** Det...";
	PseudoDeterminant=Det[TheInputMatrix+CompensatorMatrix];
	Diagnostic@PseudoDeterminant;
	PseudoInverseMatrix=Assuming[xAct`PSALTer`Def>0,
				PseudoInverseMatrix.Similarity];
	Diagnostic@PseudoInverseMatrix;

	$LocalPropagator=" ** ConjugateTranspose...";
	PseudoInverseMatrix=Assuming[xAct`PSALTer`Def>0,
				(ConjugateTranspose@Similarity).PseudoInverseMatrix];
	Diagnostic@PseudoInverseMatrix;
{PseudoInverseMatrix,PseudoDeterminant}];
