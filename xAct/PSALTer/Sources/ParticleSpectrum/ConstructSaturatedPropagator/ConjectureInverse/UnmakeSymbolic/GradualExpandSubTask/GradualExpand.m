(*=================*)
(*  GradualExpand  *)
(*=================*)

GradualExpand[CouplingAssumptions_,Expr_,SetOfRules_]:=Module[{ExpandedExpr=Expr},
	Assuming[CouplingAssumptions,ExpandedExpr=Expand@(ExpandedExpr/.#)]&/@Table[Take[SetOfRules,i],{i,Length@SetOfRules}];
ExpandedExpr];
