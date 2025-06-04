(*===================*)
(*  StackSetDelayed  *)
(*===================*)

IncludeHeader@"NameOfFunction";
IncludeHeader@"StackStrip";

$DefinedFunctions={};
StackSetDelayed~SetAttributes~HoldAll;
(*Do **not** use ~Y~ here*)
(LHS_~StackSetDelayed~RHS_):=Module[{FunctionName=NameOfFunction@Unevaluated@LHS},
	$DefinedFunctions~AppendTo~FunctionName;
	LHS:=StackInhibit@Block[
		{EvaluatedOutputRHS,
		$StandardOutput=$Output,
		$Output},
			If[$CallStackTrace&&($KernelID==0),
				$Output=$StackStream;
				$CallStack=FunctionName;
				CLICallStack[];
				EvaluatedOutputRHS=EchoTiming[
					{$Output=$StandardOutput}~Block~RHS,
					StackStrip@(Stack[]~Append~FunctionName)
				];
			,
				$CallStack=FunctionName;
				CLICallStack[];
				EvaluatedOutputRHS={$Output=$StandardOutput}~Block~RHS;
			,
				$CallStack=FunctionName;
				CLICallStack[];
				EvaluatedOutputRHS={$Output=$StandardOutput}~Block~RHS;
			];
		EvaluatedOutputRHS];
];
Y=StackSetDelayed;
