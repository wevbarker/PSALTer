(*=====================*)
(*  ValidateTraceless  *)
(*=====================*)

ValidateModes::NotTraceless="The reduced-index mode `1`, when expanded in terms of the fundamental fields, appears not to be traceless over slots at positions `2`.";
ValidateTraceless[InputExpr_,Reduced_]:=Module[{
	FreeIndices,
	MetricsToContract,
	Contraction
	},

	FreeIndices=List@@(IndicesOf[Free]@Reduced);
	MetricsToContract=(xAct`PSALTer`G@@#)&/@(DeleteDuplicates@(Sort/@((Minus/@FreeIndices)~Permutations~{2})));
	Diagnostic@MetricsToContract;

	(
		Contraction=#*Reduced;
		Contraction//=ToNewCanonical;
		Contraction//=ToNewCanonical;
		Catch@If[!(Contraction===0),
			Diagnostic@Contraction;
			Throw[Message[ValidateModes::NotTraceless,InputExpr,((Minus/@FreeIndices)~Position~#)&/@(List@@(IndicesOf[Free]@#))]]
			];
	)&/@MetricsToContract;
];
