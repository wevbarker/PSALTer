(*=======================*)
(*  DistributeConjugate  *)
(*=======================*)

DistributeConjugate[InputExpr_,CouplingAssumptions_]~Y~Module[{
		Expr=InputExpr,
		DistributedConjugate},

	DistributedConjugate[NewInputExpr_]~Y~(CouplingAssumptions~Assuming~Simplify@Distribute[Conjugate@NewInputExpr,Plus,Conjugate]);
	Expr=Expr/.{Conjugate->DistributedConjugate};
Expr];
