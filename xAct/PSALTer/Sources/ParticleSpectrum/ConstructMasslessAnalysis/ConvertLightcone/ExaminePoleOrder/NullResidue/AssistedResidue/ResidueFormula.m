(*==================*)
(*  ResidueFormula  *)
(*==================*)

ResidueFormula[NumeratorPower_,DenominatorPower_]~Y~Module[{
		ExprNumerator,
		ExprDenominator,
		InputOrder,
		Expr},

	InputOrder=DenominatorPower-NumeratorPower-1;
	ExprNumerator=Plus@@Table[Symbol@StringJoin["a",ToString@TermPower]*Parameter^TermPower,{TermPower,0,$MaxSeriesTerms}];
	ExprDenominator=Plus@@Table[Symbol@StringJoin["b",ToString@TermPower]*Parameter^TermPower,{TermPower,0,$MaxSeriesTerms}];
	Expr=ExprNumerator/ExprDenominator;
	Expr//=Series[#,{Parameter,0,$MaxSeriesTerms}]&;
	Expr//=Normal;
	Expr//=SeriesCoefficient[#,{Parameter,0,InputOrder}]&;
	Expr//=Together;
{Numerator@Expr,Denominator@Expr,Variables@Expr}];
