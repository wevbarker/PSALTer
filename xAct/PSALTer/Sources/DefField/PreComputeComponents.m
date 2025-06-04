(*========================*)
(*  PreComputeComponents  *)
(*========================*)

IncludeHeader@"AllocateTensorValues";
IncludeHeader@"AllIndexConfigurations";

$EpsComponentsComputed=False;
PreComputeComponents[FieldContext_]~Y~Module[{NewContextList={FieldContext}~Join~{
	"xAct`PSALTer`",
	"xAct`PSALTer`Private`",
	"xAct`xTensor`",
	"xAct`xTensor`Private`",
	"TangentM4`"},
	LoadContexts,
	NewContextFileList,
	ReducedIndexSources
	},

	ScalarSourceRulesValue={};

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
			LaunchKernels[$ProcessorCount];
			On[LaunchKernels::nodef];

			$LocalSummaryOfTheory=" ** Get...";
			LoadContexts=({NewContextFileList}~NewParallelSubmit~(Off@(RuleDelayed::rhs);Off@(General::shdw);Get/@NewContextFileList;On@(RuleDelayed::rhs);))~Table~{TheKernel,$KernelCount};
			LoadContexts//=MonitorParallel;	
			DeleteFile/@NewContextFileList;
			$KernelsLaunched=True;
		,
			360
		];
	];

	ReducedIndexSources=(#~Join~((Evaluate@Dagger@#)&/@#))&@(
				(FromIndexFree@ToIndexFree@#)&/@Flatten@Map[Values,Evaluate@((FieldAssociation@FieldContext)@SourceSpinParityTensorHeads),{0,2}]
		);	
	If[!$EpsComponentsComputed,
		ReducedIndexSources~AppendTo~(Eps[-a,-b,-c]);
		$EpsComponentsComputed=True;
	];
	ReducedIndexSources//=DeleteDuplicates;
	ReducedIndexSources//=AllIndexConfigurations/@#&;
	ReducedIndexSources//=Flatten;
	Diagnostic@ReducedIndexSources;
	TensorValueAllocation=(xAct`PSALTer`Private`NewParallelSubmit@(AllocateTensorValues[#,FieldContext]))&/@ReducedIndexSources;
	TensorValueAllocation//=MonitorParallel;
	CloseKernels[];

	$CVVerbose=False;
	$DefInfoQ=False;
	If[ListQ@Last@#,
		(*Print@First@#;
		Print@Last@#;*)
		AllComponentValues[First@#,Last@#];,
		ScalarSourceRulesValue~AppendTo~(First@#->Last@#);
	]&/@TensorValueAllocation;

	Diagnostic@ScalarSourceRulesValue;
	AppendToField[Context[],ScalarSourceRules,ScalarSourceRulesValue];
];
