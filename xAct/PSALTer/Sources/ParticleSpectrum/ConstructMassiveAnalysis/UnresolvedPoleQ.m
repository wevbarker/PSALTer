(*===================*)
(*  UnresolvedPoleQ  *)
(*===================*)

UnresolvedPoleQ[InputExpr_]~Y~((Variables@InputExpr)~MemberQ~Def);
