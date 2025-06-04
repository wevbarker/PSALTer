(*=========================*)
(*  MakeUniquePartialDual  *)
(*=========================*)

MakeUniquePartialDual::MakePartialDual="Can't make unique partial dual of invariant `1`.";
MakeUniquePartialDual[FieldSpinParityName_]~Y~Module[{ReplacingExpression,ReplacingWith},	
	If[IsNegativeParitySpinTwo@FieldSpinParityName,
		ReplacingExpression=FieldSpinParityName[-xAct`PSALTer`a,-xAct`PSALTer`b,-xAct`PSALTer`c]*xAct`PSALTer`Eps[xAct`PSALTer`b,xAct`PSALTer`c,xAct`PSALTer`e];
		ReplacingWith=-(1/2)*FieldSpinParityName[-xAct`PSALTer`b,-xAct`PSALTer`c,-xAct`PSALTer`a]*xAct`PSALTer`Eps[xAct`PSALTer`b,xAct`PSALTer`c,xAct`PSALTer`e];
		AutomaticRules[FieldSpinParityName,
			MakeRule[{
					Evaluate[ReplacingExpression],
					Evaluate[ReplacingWith]
					},
				MetricOn->All,
				ContractMetrics->True]
			];
		ReplacingExpression=Evaluate@Dagger@FieldSpinParityName[-xAct`PSALTer`a,-xAct`PSALTer`b,-xAct`PSALTer`c]*xAct`PSALTer`Eps[xAct`PSALTer`b,xAct`PSALTer`c,xAct`PSALTer`e];
		ReplacingWith=-(1/2)*Dagger@FieldSpinParityName[-xAct`PSALTer`b,-xAct`PSALTer`c,-xAct`PSALTer`a]*xAct`PSALTer`Eps[xAct`PSALTer`b,xAct`PSALTer`c,xAct`PSALTer`e];
		AutomaticRules[Evaluate@Dagger@FieldSpinParityName,
			MakeRule[{
					Evaluate[ReplacingExpression],
					Evaluate[ReplacingWith]
					},
				MetricOn->All,
				ContractMetrics->True]
			];
	];
];
