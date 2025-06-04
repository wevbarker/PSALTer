(*=======================*)
(*  ManualPseudoInverse  *)
(*=======================*)

IncludeHeader@"ParameterisedNullVectorQ";
IncludeHeader@"CarefullyOrthogonalise";

ManualPseudoInverse[TheInputMatrix_List?MatrixQ/;Precision[TheInputMatrix]===Infinity,TheConjecturedRightNullSpace_,TheConjecturedLeftNullSpace_]~Y~Module[{
	DimensionsOfMatrix,
	OriginalRightNullSpace=TheConjecturedRightNullSpace,
	ColumnRightNullSpace,
	RowRightNullSpace,
	OriginalLeftNullSpace=TheConjecturedLeftNullSpace,
	ColumnLeftNullSpace,
	RowLeftNullSpace,
	CompensatorMatrix,
	RightCompensatorMatrix,
	LeftCompensatorMatrix,
	RightSimilarity,
	LeftSimilarity,
	RawInverse,
	PseudoInverseMatrix,
	PseudoDeterminant},
	
	$LocalPropagator=" ** ManualPseudoInverse...";
	DimensionsOfMatrix=Length@TheInputMatrix;
	OriginalRightNullSpace=If[OriginalRightNullSpace==={},
			{Table[0,{DimensionsOfMatrix}]},OriginalRightNullSpace];
	Diagnostic@OriginalRightNullSpace;
	OriginalLeftNullSpace=If[OriginalLeftNullSpace==={},
			{Table[0,{DimensionsOfMatrix}]},OriginalLeftNullSpace];
	Diagnostic@OriginalLeftNullSpace;

	$LocalPropagator=" ** CarefullyOrthogonalise...";
	OriginalRightNullSpace//=CarefullyOrthogonalise;
	Diagnostic@OriginalRightNullSpace;
	OriginalLeftNullSpace//=CarefullyOrthogonalise;
	Diagnostic@OriginalLeftNullSpace;

	$LocalPropagator=" ** Transpose...";
	ColumnRightNullSpace=Transpose@OriginalRightNullSpace;
	Assuming[xAct`PSALTer`Def>0,RowRightNullSpace=Conjugate@OriginalRightNullSpace];
	Diagnostic@RowRightNullSpace;
	Diagnostic@(MatrixForm@Assuming[xAct`PSALTer`Def>0,
			FullSimplify@(RowRightNullSpace.ColumnRightNullSpace)]);
	ColumnLeftNullSpace=Transpose@OriginalLeftNullSpace;
	Assuming[xAct`PSALTer`Def>0,RowLeftNullSpace=Conjugate@OriginalLeftNullSpace];
	Diagnostic@RowLeftNullSpace;
	Diagnostic@(MatrixForm@Assuming[xAct`PSALTer`Def>0,
			FullSimplify@(RowLeftNullSpace.ColumnLeftNullSpace)]);

	CompensatorMatrix=ColumnLeftNullSpace.RowRightNullSpace;
	(*CompensatorMatrix=ColumnRightNullSpace.RowRightNullSpace;*)
	Diagnostic@CompensatorMatrix;
	Assuming[xAct`PSALTer`Def>0,CompensatorMatrix//=FullSimplify];
	Diagnostic@CompensatorMatrix;

	RightCompensatorMatrix=ColumnRightNullSpace.RowRightNullSpace;
	Diagnostic@RightCompensatorMatrix;
	Assuming[xAct`PSALTer`Def>0,RightCompensatorMatrix//=FullSimplify];
	Diagnostic@RightCompensatorMatrix;

	LeftCompensatorMatrix=ColumnLeftNullSpace.RowLeftNullSpace;
	Diagnostic@LeftCompensatorMatrix;
	Assuming[xAct`PSALTer`Def>0,LeftCompensatorMatrix//=FullSimplify];
	Diagnostic@LeftCompensatorMatrix;

	RightSimilarity=(IdentityMatrix@DimensionsOfMatrix)-RightCompensatorMatrix;
	Diagnostic@RightSimilarity;
	Diagnostic@(MatrixForm@Assuming[xAct`PSALTer`Def>0,
			FullSimplify@(RightSimilarity.ColumnRightNullSpace)]);

	LeftSimilarity=(IdentityMatrix@DimensionsOfMatrix)-LeftCompensatorMatrix;
	Diagnostic@LeftSimilarity;
	Diagnostic@(MatrixForm@Assuming[xAct`PSALTer`Def>0,
			FullSimplify@(LeftSimilarity.ColumnLeftNullSpace)]);
	
	$LocalPropagator=" ** Adjugate...";
	PseudoInverseMatrix=Assuming[xAct`PSALTer`Def>0,
				Adjugate[TheInputMatrix+CompensatorMatrix]];
	Diagnostic@PseudoInverseMatrix;

	$LocalPropagator=" ** Det...";
	PseudoDeterminant=Det[TheInputMatrix+CompensatorMatrix];
	Diagnostic@PseudoDeterminant;
	PseudoInverseMatrix=Assuming[xAct`PSALTer`Def>0,
				PseudoInverseMatrix.LeftSimilarity];
	Diagnostic@PseudoInverseMatrix;

	$LocalPropagator=" ** ConjugateTranspose...";
	PseudoInverseMatrix=Assuming[xAct`PSALTer`Def>0,
				(ConjugateTranspose@RightSimilarity).PseudoInverseMatrix];
	Diagnostic@PseudoInverseMatrix;
{PseudoInverseMatrix,PseudoDeterminant}];
