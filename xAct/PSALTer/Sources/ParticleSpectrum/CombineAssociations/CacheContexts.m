(*=================*)
(*  CacheContexts  *)
(*=================*)

CacheContexts[]:=Module[{NewContextList=$AllFieldContexts~Join~{
	"xAct`PSALTer`",
	"xAct`PSALTer`Private`",
	"xAct`xTensor`",
	"xAct`xTensor`Private`",
	"TangentM4`"},
	LoadContexts,
	NewContextFileList},

	$LocalSummaryOfTheory=" ** DumpSave...";
	NewContextFileList=Module[{FileName=CreateFile[]},
			DumpSave[FileName,#];FileName]&/@NewContextList;

	Diagnostic@NewContextList;

	$KernelsLaunched=False;
	While[!$KernelsLaunched,
		TimeConstrained[
			$LocalSummaryOfTheory=" ** LaunchKernels...";
			CloseKernels[];
			Off[LaunchKernels::nodef];
			LaunchKernels[];	
			On[LaunchKernels::nodef];

			$LocalSummaryOfTheory=" ** Get...";
			LoadContexts=({NewContextFileList}~NewParallelSubmit~(Off@(RuleDelayed::rhs);Get/@NewContextFileList;On@(RuleDelayed::rhs);))~Table~{TheKernel,$KernelCount};
			LoadContexts//=MonitorParallel;	
			DeleteFile/@NewContextFileList;
			$KernelsLaunched=True;
		,
			360
		];
	];

];
