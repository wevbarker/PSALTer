(*=======================*)
(*  ValidateInverseMode  *)
(*=======================*)

ValidateModes::NoInverseMode="The reduced-index mode `1` appears not to be invertible using the provided rules; this can cause a catastropic error in the particle spectrum analysis.";
ValidateInverseMode[InputExpr_,Decomposed_,Reduced_]:=Catch@If[!(Decomposed===Reduced),
			Print@Reduced;
			Print@Decomposed;
			Throw[Message[ValidateModes::NoInverseMode,InputExpr]]
			];
