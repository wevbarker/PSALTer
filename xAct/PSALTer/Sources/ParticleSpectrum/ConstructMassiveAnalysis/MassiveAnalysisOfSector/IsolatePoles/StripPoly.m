(*=============*)
(*  StripPoly  *)
(*=============*)

StripPoly[InputExpr_,NewCouplingAssumptions_]~Y~Module[{Expr=InputExpr},
	Expr//=(#/.{Def->Sqrt@DefSquared})&;
	Assuming[NewCouplingAssumptions,Expr//=Simplify];
	Expr//=(#/.{Sqrt@DefSquared->1})&;
	Expr/=DefSquared^$SomeHighPower;
	Expr//=Normal;
	Expr//=Numerator;
Expr];
