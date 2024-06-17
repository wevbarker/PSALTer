(*=======================*)
(*  MakeSaturatedMatrix  *)
(*=======================*)

MakeSaturatedMatrix[RawMasslessPropagatorResidue_,NullSpace_List]:=Module[{
	MasslessPropagatorResidue=RawMasslessPropagatorResidue,
	NullSpaceDimension,
	FreeSourceVariables,
	NumeratorFreeSourceCoefficientMatrix},

	$LocalMasslessSpectrum=" ** MakeSaturatedMatrix...";

	Diagnostic@MasslessPropagatorResidue;
	MasslessPropagatorResidue//=Expand;
	Diagnostic@MasslessPropagatorResidue;
	NullSpaceDimension=(Dimensions@NullSpace)[[1]];
	FreeSourceVariables=Table[Symbol["xAct`PSALTer`Private`X"<>ToString@i],{i,NullSpaceDimension}];
	NumeratorFreeSourceCoefficientMatrix=Last@CoefficientArrays[MasslessPropagatorResidue,FreeSourceVariables~Join~(Evaluate@Dagger[FreeSourceVariables]),"Symmetric"->False];
	NumeratorFreeSourceCoefficientMatrix=NumeratorFreeSourceCoefficientMatrix[[1;;(1/2)Length@#,(1/2)Length@#+1;;Length@#]]&@NumeratorFreeSourceCoefficientMatrix;
	NumeratorFreeSourceCoefficientMatrix//=Normal;
	Diagnostic@(MatrixForm@NumeratorFreeSourceCoefficientMatrix);

NumeratorFreeSourceCoefficientMatrix];
