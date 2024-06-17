(*=========================*)
(*  ValidateSymmetryField  *)
(*=========================*)

DefField::NoSymmField="The symmetries of the fundamental field `1` are `2`, but these appear not to match the symmetries of the field when it is expanded into reduced-index modes, which are `3`.";
ValidateSymmetryField[InputExpr_,Decomposed_,Fundamental_]:=Catch@Module[{
	SymmetriesOfExpanded,
	SymmetriesOfDecomposed
	},

	SymmetriesOfExpanded=SymmetryOfExpression@Fundamental;
	SymmetriesOfDecomposed=SymmetryOfExpression@Decomposed;
	If[!(SymmetriesOfDecomposed===SymmetriesOfExpanded),
			Throw[Message[DefField::NoSymmField,InputExpr,SymmetriesOfExpanded,SymmetriesOfDecomposed]]
			];
];
