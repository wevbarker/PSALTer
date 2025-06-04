(*===========================*)
(*  MasslessAnalysisOfTotal  *)
(*===========================*)

IncludeHeader@"ExtractPart";

MasslessAnalysisOfTotal[InputMatrix_,InputDenominator_]~Y~Module[{
	NumeratorFreeSourceEigenvalues
	},

	NumeratorFreeSourceEigenvalues=ExtractPart[InputMatrix,InputDenominator];

NumeratorFreeSourceEigenvalues];
