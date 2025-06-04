(*=======================*)
(*  MakeSaturatedMatrix  *)
(*=======================*)

MakeSaturatedMatrix[RawMasslessPropagatorResidue_,NullSpace_List]~Y~Module[{
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
	Diagnostic@FreeSourceVariables;
	NumeratorFreeSourceCoefficientMatrix=Last@CoefficientArrays[MasslessPropagatorResidue,FreeSourceVariables~Join~(Evaluate@Dagger[FreeSourceVariables]),"Symmetric"->False];
	Diagnostic@NumeratorFreeSourceCoefficientMatrix;
	NumeratorFreeSourceCoefficientMatrix=NumeratorFreeSourceCoefficientMatrix[[1;;(1/2)Length@#,(1/2)Length@#+1;;Length@#]]&@NumeratorFreeSourceCoefficientMatrix;
	Diagnostic@NumeratorFreeSourceCoefficientMatrix;
	NumeratorFreeSourceCoefficientMatrix//=Normal;
	Diagnostic@NumeratorFreeSourceCoefficientMatrix;

NumeratorFreeSourceCoefficientMatrix];
