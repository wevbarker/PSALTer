(*===========================*)
(*  MasslessAnalysisOfTotal  *)
(*===========================*)

MasslessAnalysisOfTotal[RawMasslessPropagatorResidue_List,NullSpace_List]:=Module[{
	MasslessPropagatorResidue=RawMasslessPropagatorResidue,
	NullSpaceDimension,
	FreeSourceVariables,
	NumeratorFreeSourceCoefficientMatrix,
	NumeratorFreeSourceEigenvalues},

	LocalMasslessSpectrum=" ** MasslessAnalysisOfTotal...";

	Diagnostic@MasslessPropagatorResidue;
	MasslessPropagatorResidue//=Flatten;
	MasslessPropagatorResidue//=Total;
	MasslessPropagatorResidue//=Simplify;
	Diagnostic@MasslessPropagatorResidue;

	If[!(MasslessPropagatorResidue===0),
		NullSpaceDimension=(Dimensions@NullSpace)[[1]];
		FreeSourceVariables=Table[Symbol["X"<>ToString@i],{i,NullSpaceDimension}];

		NumeratorFreeSourceCoefficientMatrix=Last@CoefficientArrays[MasslessPropagatorResidue,FreeSourceVariables~Join~(Evaluate@Dagger[FreeSourceVariables]),"Symmetric"->False];
		NumeratorFreeSourceCoefficientMatrix=NumeratorFreeSourceCoefficientMatrix[[1;;(1/2)Length@#,(1/2)Length@#+1;;Length@#]]&@NumeratorFreeSourceCoefficientMatrix;
		NumeratorFreeSourceEigenvalues=Eigenvalues@NumeratorFreeSourceCoefficientMatrix;
		NumeratorFreeSourceEigenvalues//=DeleteCases[#,0,Infinity]&;,

		NumeratorFreeSourceEigenvalues={};
	];

{MasslessPropagatorResidue,NumeratorFreeSourceEigenvalues}];
