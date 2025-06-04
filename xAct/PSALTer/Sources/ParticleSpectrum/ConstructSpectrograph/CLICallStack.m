(*================*)
(*  CLICallStack  *)
(*================*)

IncludeHeader@"Status";

(*Do **not** use ~Y~ here*)
CLICallStack[]:=Module[{},
	If[$CLI,
		Run@("echo -e \""<>Status@StringReplace[ToString@$CallStack,"`"->"\`"]<>"\"");
	];
];
