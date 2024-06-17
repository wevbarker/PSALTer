(*===========================*)
(*  MasslessAnalysisOfTotal  *)
(*===========================*)

IncludeHeader@"ExtractPart";

MasslessAnalysisOfTotal[InputMatrix_,InputDenominator_]:=Module[{
	NumeratorFreeSourceEigenvalues,
	StillComputing=True,
	NewOrder=0
	},

	Diagnostic@NumeratorFreeSourceCoefficientMatrix;


	TimeConstrained[
	(
		NumeratorFreeSourceEigenvalues=ExtractPart[InputMatrix,InputDenominator,Infinity];
	),
	10,
	(
		While[StillComputing&&(NewOrder<=2),
			TimeConstrained[
			(
				NumeratorFreeSourceEigenvalues=ExtractPart[
						InputMatrix,
						InputDenominator,
						NewOrder];
				NewOrder+=1;
			)
			,
			10,
			(
				StillComputing=False;
			)
			];
			
		];
	)
	];

NumeratorFreeSourceEigenvalues];
