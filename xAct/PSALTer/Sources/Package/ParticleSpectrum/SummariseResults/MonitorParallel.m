(*===================*)
(*  MonitorParallel  *)
(*===================*)

MonitorParallel[ParallelisedArray_]:=Module[{
	PrintVariable,
	ParallelisedArrayValue},
	If[$MonitorParallel,
		PrintVariable=PrintTemporary@Column[{
			MakeLabel@"Parallel computation",
			ReMagnify@ParallelGrid@ParallelisedArray},
			Spacings->{2,2},
			Frame->True,
			Background->PanelColor,
			Alignment->{Left,Center}];
	];
	ParallelisedArrayValue=WaitAll@ParallelisedArray;
	If[$MonitorParallel,
		NotebookDelete@PrintVariable;
	];
ParallelisedArrayValue];
