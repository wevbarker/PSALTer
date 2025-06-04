(*========================*)
(*  DenominatorOfElement  *)
(*========================*)

DenominatorOfElement[InputElement_]~Y~Module[{Expr=InputElement},
	Expr//=Together;
	Expr//=Denominator;
Expr];
