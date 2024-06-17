(*=================*)
(*  ReloadPackage  *)
(*=================*)

IncludeHeader@"ToNewCanonical";
IncludeHeader@"NewParallelSubmit";
IncludeHeader@"Colours";
IncludeHeader@"MonitorParallel";
IncludeHeader@"NewFramed";
IncludeHeader@"Vectorize";
IncludeHeader@"Diagnostic";
ReadAtRuntime@"DefGeometry";

ReloadPackage[]:=Module[{},
	If[$NotLoaded,
		DefGeometry[];
		Begin@"xAct`PSALTer`Private`";
			RereadSources[];
		End[];
		$NotLoaded=False;,Null,
		DefGeometry[];
		Begin@"xAct`PSALTer`Private`";
			RereadSources[];
		End[];
		$NotLoaded=False;
	];
];
