(*===================*)
(*  ValidateSpatial  *)
(*===================*)

DefField::NotSpatial="The reduced-index mode `1`, when expanded in terms of the fundamental fields, appears not to be orthogonal to the unit-timelike vector contracted with the index at slot `2`.";
ValidateSpatial[InputExpr_,Expanded_]:=Module[{
	FreeIndices,
	Contraction},

	FreeIndices=List@@(IndicesOf[Free]@Expanded);
	(
		Contraction=V[-#]*Expanded;
		Contraction//=ToNewCanonical;
		Contraction//=ToNewCanonical;
		Catch@If[!(Contraction===0),
			Print@Contraction;
			Throw[Message[DefField::NotSpatial,InputExpr,FreeIndices~Position~#]]
			];
	)&/@FreeIndices;
];
