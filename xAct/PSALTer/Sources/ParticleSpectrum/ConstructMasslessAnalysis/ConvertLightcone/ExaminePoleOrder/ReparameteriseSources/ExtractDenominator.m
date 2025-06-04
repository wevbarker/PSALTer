(*======================*)
(*  ExtractDenominator  *)
(*======================*)

IncludeHeader@"DenominatorOfElement";

ExtractDenominator[InputMatrix_]~Y~Module[{OverallDenominator=InputMatrix},

	OverallDenominator//=Flatten;

	(*OverallDenominator//=(Denominator/@#)&;*)
	OverallDenominator=Map[
		(xAct`PSALTer`Private`NewParallelSubmit@(DenominatorOfElement@#))&,
		OverallDenominator];
	OverallDenominator//=MonitorParallel;

	OverallDenominator//=DeleteDuplicates;

	(*OverallDenominator//=(FactorTermsList/@#)&;*)
	OverallDenominator=Map[
		(xAct`PSALTer`Private`NewParallelSubmit@(FactorTermsList@#))&,
		OverallDenominator];
	OverallDenominator//=MonitorParallel;
	
	OverallDenominator//=DeleteCases[#,{_?NumericQ,_?NumericQ},Infinity]&;
	OverallDenominator//=Flatten;
	OverallDenominator//=DeleteDuplicates;
	OverallDenominator//=DeleteCases[#,_?NumericQ]&;
	OverallDenominator//=Times@@#&;
OverallDenominator];
