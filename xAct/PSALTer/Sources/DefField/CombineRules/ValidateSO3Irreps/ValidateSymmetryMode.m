(*========================*)
(*  ValidateSymmetryMode  *)
(*========================*)

DefField::NoSymmMode="The symmetries of the reduced-index mode `1` are `2`, but these appear not to match the symmetries of the mode when it is expanded into fundamental fields, which are `3`.";
ValidateSymmetryMode[InputExpr_,Expanded_,Reduced_]:=Catch@Module[{
	SymmetriesOfExpanded,
	SymmetriesOfDecomposed
	},

	SymmetriesOfDecomposed=SymmetryOfExpression@Reduced;
	SymmetriesOfExpanded=SymmetryOfExpression@Expanded;
	Catch@If[!(SymmetriesOfDecomposed===SymmetriesOfExpanded),
		Throw[Message[DefField::NoSymmMode,InputExpr,SymmetriesOfDecomposed,SymmetriesOfExpanded]]
		];
];
