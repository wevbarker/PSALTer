(*==================*)
(*  ToNewCanonical  *)
(*==================*)

ToNewCanonical[Expr_]:=Module[{CanonicalisedExpr=Expr},

	CanonicalisedExpr//=NoScalar;
	CanonicalisedExpr//=ToCanonical;
	CanonicalisedExpr//=ContractMetric;
	CanonicalisedExpr//=ScreenDollarIndices;
CanonicalisedExpr];
