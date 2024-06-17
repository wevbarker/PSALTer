(*=======================*)
(*  ValidateInverseMode  *)
(*=======================*)

DefField::NoInverseMode="The reduced-index mode `1` appears not to be invertible using the provided rules.";
ValidateInverseMode[InputExpr_,Decomposed_,Reduced_]:=Catch@If[!(Decomposed===Reduced),
			Print@Reduced;
			Print@Decomposed;
			Throw[Message[DefField::NoInverseMode,InputExpr]]
			];
