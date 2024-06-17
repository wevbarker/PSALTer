(*================*)
(*  StripFactors  *)
(*================*)

StripFactors[MasslessEigenvalue_]:=Module[{Expr,
	MasslessEigenvalueNumerator=Numerator@Normal@MasslessEigenvalue,
	MasslessEigenvalueDenominator=Denominator@Normal@MasslessEigenvalue},
	MasslessEigenvalueNumerator/=(2*3*5*7*11)^10;
	MasslessEigenvalueNumerator//=Simplify;
	MasslessEigenvalueNumerator//=Numerator;
	MasslessEigenvalueDenominator/=(2*3*5*7*11)^10;
	MasslessEigenvalueDenominator//=Simplify;
	MasslessEigenvalueDenominator//=Numerator;
	Expr=MasslessEigenvalueNumerator/MasslessEigenvalueDenominator;
	Expr//=FullSimplify;
Expr];
