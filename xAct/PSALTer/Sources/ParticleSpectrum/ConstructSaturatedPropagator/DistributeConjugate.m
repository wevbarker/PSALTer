(*=======================*)
(*  DistributeConjugate  *)
(*=======================*)

DistributeConjugate[InputExpr_,CouplingAssumptions_]:=Module[{
		Expr=InputExpr,
		DistributedConjugate},

	DistributedConjugate[NewInputExpr_]:=CouplingAssumptions~Assuming~Simplify@Distribute[Conjugate@NewInputExpr,Plus,Conjugate];
	Expr=Expr/.{Conjugate->DistributedConjugate};
Expr];
