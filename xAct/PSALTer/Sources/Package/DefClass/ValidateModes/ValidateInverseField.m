(*========================*)
(*  ValidateInverseField  *)
(*========================*)

ValidateModes::NoInverseField="The fundamental field `1` appears not to be invertible using the provided rules; this can cause a catastropic error in the particle spectrum analysis.";
ValidateInverseField[InputExpr_,Expanded_,Fundamental_]:=Catch@If[!(Expanded===Fundamental),
			Print@Fundamental;
			Print@Expanded;
			Throw[Message[ValidateModes::NoInverseField,InputExpr]]
			];
