(*================*)
(*  CallStackEnd  *)
(*================*)

$NumberOfCriticalPoints=50;
CallStackEnd[]:=Module[{Expr},
	If[$CallStackTrace,
		Close@First@$StackStream;
		Run@("sed -i 's/}/},/' \""<>$CallStackTraceFileName<>"\"");
		Run@("sed -i 's/^>> /\"{/' \""<>$CallStackTraceFileName<>"\"");
		Run@("sed -i 's/$/}\"/' \""<>$CallStackTraceFileName<>"\"");
		Run@("sed -i 's/\\$[0-9]*//g' \""<>$CallStackTraceFileName<>"\"");
		Expr=ReadList@$CallStackTraceFileName;
		Expr//=ToExpression/@#&;
		Expr//=(#~GroupBy~First)&;
		MapThread[(Expr@#1={(Last/@#2),Total@(Last/@#2)})&,
			{Keys@Expr,Values@Expr}];
		Expr//=(#~SortBy~Last)&;
		Expr//=Reverse;
		If[Length@Expr>$NumberOfCriticalPoints,
			Expr//=(#~Take~$NumberOfCriticalPoints)&];
		DataLength=Length@Expr;
		Expr//=Last/@#&;
		Expr=ListLogPlot[Values@Expr,
			Filling->Axis,
			ImageSize->Large,
			PlotStyle->Directive[PointSize[Large],Black],
			Background->White,
			PlotLabel->Style["Critical points in call stack trace (seconds)",
				FontColor->Black,FontSize->16],
			Ticks->{Transpose[{Range@DataLength,
				Column/@Transpose[{Range@DataLength,
					Rotate[ToString@Last@#,Pi/2]&/@(Keys@Expr)}]}],
			Automatic}
		];
		UsingFrontEnd@Export["call-stack-trace.pdf",Expr];
	];
	$CallStackTrace=False;
];
