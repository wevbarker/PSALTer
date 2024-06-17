(*=======================*)
(*  MakeUniqueQuadratic  *)
(*=======================*)

MakeUniqueQuadratic::MakeQuadratic="Can't restore unique quadratic invariant `1`.";
MakeUniqueQuadratic[FieldSpinParityName_]:=Module[{
	MultiTermSymmetry,
	VanishingInvariant,
	ReplacingExpression,
	ReplacingWith
	},

	If[!(MultiTermSymmetriesOf@FieldSpinParityName==={}),
		MultiTermSymmetry=First@(MultiTermSymmetriesOf@FieldSpinParityName);
		VanishingInvariant=MultiTermSymmetry*((Dagger@FieldSpinParityName)@@(Minus/@(IndicesOf[AIndex]@MultiTermSymmetry)));
		VanishingInvariant//=ToNewCanonical;
		VanishingInvariant//=ReplaceDummies;
		VanishingInvariant//=ToNewCanonical;
		Diagnostic@VanishingInvariant;
		PreferredInvariant=(FieldSpinParityName@@((IndicesOf[AIndex]@MultiTermSymmetry)))*((Dagger@FieldSpinParityName)@@(Minus/@(IndicesOf[AIndex]@MultiTermSymmetry)));
		PreferredInvariant//=ToNewCanonical;
		PreferredInvariant//=ReplaceDummies;
		PreferredInvariant//=ToNewCanonical;
		Diagnostic@PreferredInvariant;
		AllInvariants=AllContractions[ToIndexFree@(FieldSpinParityName*Dagger@FieldSpinParityName),Parallelization->False];
		AllInvariants=ToNewCanonical/@AllInvariants;
		Diagnostic@AllInvariants;
		AllOtherInvariants=AllInvariants~Complement~{PreferredInvariant};
		Diagnostic@AllOtherInvariants;
		(
			ReplacingExpression=#;
			Diagnostic@ReplacingExpression;
			ReplacingWith=ToNewCanonical@(-(VanishingInvariant-(VanishingInvariant~Coefficient~#)*#)/(VanishingInvariant~Coefficient~#));
			Diagnostic@ReplacingWith;

			AutomaticRules[FieldSpinParityName,
				MakeRule[{
						Evaluate@ReplacingExpression,
						Evaluate@ReplacingWith
						},
					MetricOn->All,
					ContractMetrics->True]
				];
		)&/@AllOtherInvariants;
	];
];
