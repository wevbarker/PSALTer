(*============================*)
(*  ParameterisedNullVectorQ  *)
(*============================*)

ParameterisedNullVectorQ[NullVector_]:=Module[{
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
