(*=================*)
(*  NonTrivialDot  *)
(*=================*)

NonTrivialDot[LeftOperand_,RightOperand_]~Y~If[((LeftOperand=={})||(LeftOperand=={})),
		0,
		LeftOperand~Dot~RightOperand,
		LeftOperand~Dot~RightOperand];
