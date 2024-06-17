(*===================*)
(*  SimplifyIfSmall  *)
(*===================*)

$SimplifyIfSmallLength=500;
SimplifyIfSmall[InputAssume_,InputExpr_]:=Module[{
	Expr=InputExpr,
	Numer,
	Denom,
	ExprLength},


	Expr//=Together;

	Numer=Numerator@Expr;
	Numer//=Expand;

	Denom=Denominator@Expr;
	Denom//=Expand;

	ExprLength=List@(Numer/.{Plus->List})~Join~List@(Denom/.{Plus->List});
	ExprLength//=Flatten;
	ExprLength//=Length;

	If[ExprLength<=$SimplifyIfSmallLength,
		Assuming[InputAssume,Numer//=Simplify];
		Assuming[InputAssume,Denom//=Simplify];
		Expr=Numer/Denom;
		Assuming[InputAssume,Expr//=Simplify];
	];
Expr];
