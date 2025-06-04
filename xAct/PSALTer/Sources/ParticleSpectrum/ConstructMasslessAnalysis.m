(*=============================*)
(*  ConstructMasslessAnalysis  *)
(*=============================*)

IncludeHeader@"ConstructLightcone";
IncludeHeader@"ConvertLightcone";


Options@ConstructMasslessAnalysis={MasslessSpectrum->True,MaxLaurentDepth->1};

ConstructMasslessAnalysis[ClassName_?StringQ,
	ValuesOfSourceConstraints_,
	OptionsPattern[]]~Y~Module[{},

	$LocalMasslessSpectrum=" ** ConstructMasslessAnalysis...";
	If[OptionValue@MasslessSpectrum,
		ConstructLightcone[ClassName,
			ValuesOfSourceConstraints];
		ConvertLightcone[ClassName,
			UnscaledNullSpace,
			MaxLaurentDepth->OptionValue@MaxLaurentDepth];
	,
		MasslessAnalysisValue={};
		QuarticAnalysisValue={};
		HexicAnalysisValue={};
		$LocalMasslessSpectrum={{},{},
			MasslessAnalysisValue,
			QuarticAnalysisValue,
			HexicAnalysisValue,
			{SecularEquationValue}};
	];
];
