(*===========================*)
(*  EnsureLinearInCouplings  *)
(*===========================*)

EnsureLinearInCouplings[NullVector_]~Y~Module[{
	Expr=NullVector,
	LinearNullVector=NullVector},

	Expr=Together/@Expr;	
	Expr=Denominator/@Expr;
	Expr=Times@@Expr;	
	LinearNullVector*=Expr;
	LinearNullVector//=FullSimplify;
LinearNullVector];
