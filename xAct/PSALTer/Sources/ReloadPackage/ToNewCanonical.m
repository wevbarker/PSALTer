(*==================*)
(*  ToNewCanonical  *)
(*==================*)

ToNewCanonical[Expr_]~Y~Module[{CanonicalisedExpr=Expr},

	CanonicalisedExpr//=NoScalar;
	CanonicalisedExpr//=ToCanonical;
	CanonicalisedExpr//=ContractMetric;
	CanonicalisedExpr//=ScreenDollarIndices;
CanonicalisedExpr];
