(*===============*)
(*  ExtractPart  *)
(*===============*)

ExpectRationalEigenvalues[SampleMatrix_]~Y~Module[{Expr=SampleMatrix},
	Expr//=Eigenvalues;
	Expr//=((#~Element~Rationals)===True)&/@#&;
	Expr//=(And@@#)&;	
Expr];

ParticleSpectrum::IrrationalResidues="At least one massless pole residue is not a rational function of the Lagrangian coupling coefficients.";
ExtractPart[InputMatrix_,InputDenominator_]~Y~Module[{
	Expr=InputMatrix,
	AllVariables,
	NumericalCouplingRules,
	SampleMatrices
	},
(*
	AllVariables=Flatten@(Variables/@(Flatten@InputMatrix));
	AllVariables//=DeleteDuplicates;
	NumericalCouplingRules=Range@$NumericalSampleRange;
	NumericalCouplingRules//=((#~RandomSample~(Length@AllVariables))~Table~$MinimalExamples)&;
	NumericalCouplingRules//=DeleteDuplicates;
	NumericalCouplingRules//=(((#1->#2)&~MapThread~{AllVariables,#})&/@#)&;
	SampleMatrices=(FullSimplify@(InputMatrix/.#))&/@NumericalCouplingRules;
*)
	Expr//=Eigenvalues;
	Expr//=DeleteCases[#,0,Infinity]&;
	Expr/=InputDenominator;
(*
	If[And@@(ExpectRationalEigenvalues/@SampleMatrices),
		Expr//=Eigenvalues;
		Expr//=DeleteCases[#,0,Infinity]&;
		Expr/=InputDenominator;
	,
		Expr//=Eigenvalues;
		Expr//=DeleteCases[#,0,Infinity]&;
		Expr/=InputDenominator;
(*
		Message@ParticleSpectrum::IrrationalResidues;
		$LocalMasslessSpectrum="(The massless analysis is omitted because at least one massless pole residue is not a rational function of the Lagrangian coupling coefficients)";
		$LocalOverallUnitarity="(The unitarity analysis is omitted because the massless analysis is omitted)";
		Break[];
*)
	];
*)
Expr];
