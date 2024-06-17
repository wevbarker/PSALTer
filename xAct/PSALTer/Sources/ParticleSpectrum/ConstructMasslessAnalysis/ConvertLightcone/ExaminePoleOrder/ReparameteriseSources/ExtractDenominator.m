(*======================*)
(*  ExtractDenominator  *)
(*======================*)

ExtractDenominator[InputMatrix_]:=Module[{OverallDenominator,Expr},

	OverallDenominator=InputMatrix;
	OverallDenominator//=Flatten;
	OverallDenominator//=Total;
	OverallDenominator//=Together;
	OverallDenominator//=Denominator;
OverallDenominator];
