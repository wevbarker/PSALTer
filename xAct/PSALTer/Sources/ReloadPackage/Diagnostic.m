(*==============*)
(*  Diagnostic  *)
(*==============*)

Diagnostic~SetAttributes~HoldAll;
Diagnostic[Var_]:=Module[{VarName=ToString@Unevaluated@Var},
	If[$DiagnosticMode,
		Print@(" ** xAct`PSALTer`Private`Diagnostic: the value of the variable "<>VarName<>" will now be printed.");
		Print@Var;	
	];	
];
