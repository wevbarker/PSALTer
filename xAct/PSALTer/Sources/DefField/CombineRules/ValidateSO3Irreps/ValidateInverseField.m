(*========================*)
(*  ValidateInverseField  *)
(*========================*)

DefField::NoInverseField="The fundamental field `1` appears not to be invertible using the provided rules.";
ValidateInverseField[InputExpr_,Expanded_,Fundamental_]:=Catch@If[!(Expanded===Fundamental),
			Print@Fundamental;
			Print@Expanded;
			Throw[Message[DefField::NoInverseField,InputExpr]]
			];
