(*============================*)
(*  ParameterisedNullVectorQ  *)
(*============================*)

ParameterisedNullVectorQ[NullVector_]~Y~Module[{
	VariablesPresent,
	Finding},

	VariablesPresent=Join@@(Variables/@NullVector);
	VariablesPresent//=DeleteDuplicates;
	If[(VariablesPresent=={xAct`PSALTer`Def})||(VariablesPresent=={}),
		Finding=False;,
		Finding=True;,
		Finding=True;
	];
Finding];
