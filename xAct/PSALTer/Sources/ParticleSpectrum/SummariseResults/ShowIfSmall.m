(*===============*)
(*  ShowIfSmall  *)
(*===============*)

$ShowIfSmallLength=5000;
ShowIfSmall[InputExpr_]:=Module[{LeafLength,Expr},
	LeafLength=LeafCount@InputExpr;
	If[LeafLength<=$ShowIfSmallLength,Expr=InputExpr,Expr="(Hidden for brevity)"];
Expr];
