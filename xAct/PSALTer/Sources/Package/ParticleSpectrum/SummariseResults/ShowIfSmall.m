(*===============*)
(*  ShowIfSmall  *)
(*===============*)

ShowIfSmall[InputExpr_]:=Module[{LeafLength,Expr},
	LeafLength=LeafCount@InputExpr;
	If[LeafLength<=500,Expr=InputExpr,Expr="(Hidden for brevity)"];
Expr];
