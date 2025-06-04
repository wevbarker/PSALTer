(*==============================*)
(*  NumericallyAssistedResidue  *)
(*==============================*)

IncludeHeader@"NumericalLowestOrder";
IncludeHeader@"ResidueFormula";
IncludeHeader@"ObtainTermReplacements";
IncludeHeader@"ProcessPart";

AssistedResidue[InputExpr_]~Y~Module[{
	Expr=InputExpr,
	NumeratorPower,
	DenominatorPower,
	ExprNumerator,
	ExprDenominator,
	ResidueNumerator,
	ResidueDenominator,
	SeriesCoefficients,
	TermReplacements},

	(*PolynomialQ*)
	Expr//=Together;
	ExprNumerator=Expr//Numerator;
	ExprDenominator=Expr//Denominator;
	NumeratorPower=LowestOrder@ExprNumerator;
	DenominatorPower=LowestOrder@ExprDenominator;
	ExprNumerator/=Parameter^NumeratorPower;
	ExprDenominator/=Parameter^DenominatorPower;
	{ResidueNumerator,
	ResidueDenominator,
	SeriesCoefficients}=NumeratorPower~ResidueFormula~DenominatorPower;
	TermReplacements=ObtainTermReplacements[SeriesCoefficients,
					ExprNumerator,ExprDenominator];
	ResidueNumerator//=ProcessPart[#,TermReplacements]&;
	ResidueDenominator//=ProcessPart[#,TermReplacements]&;

	Expr=ResidueNumerator/ResidueDenominator;
Expr];
