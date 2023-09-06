(*=========================*)
(*  ValidateSymmetryField  *)
(*=========================*)

ValidateModes::NoSymmField="The symmetries of the fundamental field `1` are `2`, but these appear not to match the symmetries of the field when it is expanded into reduced-index modes, which are `3`; this may indicate that the provided rules are incorrect.";
ValidateSymmetryField[InputExpr_,Decomposed_,Fundamental_]:=Catch@Module[{
	SymmetriesOfExpanded,
	SymmetriesOfDecomposed
	},

	SymmetriesOfExpanded=SymmetryOfExpression@Fundamental;
	SymmetriesOfDecomposed=SymmetryOfExpression@Decomposed;
	If[!(SymmetriesOfDecomposed===SymmetriesOfExpanded),
			Throw[Message[ValidateModes::NoSymmField,InputExpr,SymmetriesOfExpanded,SymmetriesOfDecomposed]]
			];
];
