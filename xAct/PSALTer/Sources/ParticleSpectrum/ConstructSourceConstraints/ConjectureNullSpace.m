(*=======================*)
(*  ConjectureNullSpace  *)
(*=======================*)

IncludeHeader@"RemoveReferencesToMomentum";
IncludeHeader@"SymbolicNullSpace";
IncludeHeader@"CleanNullVector";
IncludeHeader@"EnsureLinearInCouplings";

ConjectureNullSpace[InputMatrix_,Couplings_,CouplingAssumptions_,Side_:Right]~Y~Module[{	
	TheInputMatrix=InputMatrix,
	FieldRescaledMatrix,
	ConstantDescalingRules,
	FieldRescalingMatrix,
	ScalingSolutions,
	RescaledNullSpace,
	DescaledNullSpace
	},

	If[Side===Left,
		TheInputMatrix//=Transpose;
		Diagnostic@TheInputMatrix;
		TheInputMatrix//=Conjugate;
		Diagnostic@TheInputMatrix;
		Assuming[CouplingAssumptions,TheInputMatrix//=FullSimplify];
		Diagnostic@TheInputMatrix;
	];

	TheInputMatrix//=Map[DistributeConjugate[#,CouplingAssumptions]&,#,{2}]&;
	Diagnostic@TheInputMatrix;
	{FieldRescaledMatrix,
	ConstantDescalingRules,
	FieldRescalingMatrix,
	ScalingSolutions}=RemoveReferencesToMomentum[TheInputMatrix,Couplings];
	Diagnostic@FieldRescaledMatrix;
	Diagnostic@ConstantDescalingRules;
	Diagnostic@FieldRescalingMatrix;
	Diagnostic@ScalingSolutions;
	RescaledNullSpace=SymbolicNullSpace@FieldRescaledMatrix;
	Diagnostic@RescaledNullSpace;
	DescaledNullSpace=((FieldRescalingMatrix.#)/.ConstantDescalingRules/.ScalingSolutions)&/@RescaledNullSpace;
	Diagnostic@DescaledNullSpace;
	CouplingAssumptions~Assuming~(DescaledNullSpace//=FullSimplify);
	Diagnostic@DescaledNullSpace;
	DescaledNullSpace//=(CleanNullVector[#,CouplingAssumptions]&/@#)&;
	Diagnostic@DescaledNullSpace;
	DescaledNullSpace=EnsureLinearInCouplings/@DescaledNullSpace;
	Diagnostic@DescaledNullSpace;
DescaledNullSpace];
