(*=======================*)
(*  ConjectureNullSpace  *)
(*=======================*)

IncludeHeader@"CommonNullVector";
IncludeHeader@"RemoveReferencesToMomentum";
IncludeHeader@"CreateList";
IncludeHeader@"CleanNullVector";
IncludeHeader@"EnsureLinearInCouplings";

ConjectureNullSpace[InputMatrix_,Couplings_,CouplingAssumptions_]:=Module[{	
	FieldRescaledMatrix,
	ConstantDescalingRules,
	FieldRescalingMatrix,
	ScalingSolutions,
	RescaledNullSpace,
	DescaledNullSpace
	},

	{FieldRescaledMatrix,
	ConstantDescalingRules,
	FieldRescalingMatrix,
	ScalingSolutions}=RemoveReferencesToMomentum[InputMatrix,Couplings];
	Diagnostic@(MatrixForm@FieldRescaledMatrix);
	Diagnostic@ConstantDescalingRules;
	Diagnostic@(MatrixForm@FieldRescalingMatrix);
	Diagnostic@ScalingSolutions;
	RescaledNullSpace=NullSpace@FieldRescaledMatrix;
	DescaledNullSpace=((FieldRescalingMatrix.#)/.ConstantDescalingRules/.ScalingSolutions)&/@RescaledNullSpace;
	CouplingAssumptions~Assuming~(DescaledNullSpace//=FullSimplify);
	DescaledNullSpace//=(CleanNullVector[#,CouplingAssumptions]&/@#)&;
	DescaledNullSpace=EnsureLinearInCouplings/@DescaledNullSpace;

DescaledNullSpace];
