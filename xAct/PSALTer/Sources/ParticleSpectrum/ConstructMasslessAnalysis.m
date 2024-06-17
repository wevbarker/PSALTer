(*=============================*)
(*  ConstructMasslessAnalysis  *)
(*=============================*)

IncludeHeader@"ConstructLightcone";
IncludeHeader@"ConvertLightcone";

Options@ConstructMasslessAnalysis={
	MaxLaurentDepth->1
	};

ConstructMasslessAnalysis[ClassName_?StringQ,
	ValuesOfSourceConstraints_,
	ValuesSaturatedPropagator_,
	OptionsPattern[]]:=Module[{},

	$LocalMasslessSpectrum=" ** ConstructMasslessAnalysis...";
	ConstructLightcone[ClassName,ValuesOfSourceConstraints];
	ConvertLightcone[ClassName,
		ValuesSaturatedPropagator,
		UnscaledNullSpace,
		MaxLaurentDepth->OptionValue@MaxLaurentDepth];
];
