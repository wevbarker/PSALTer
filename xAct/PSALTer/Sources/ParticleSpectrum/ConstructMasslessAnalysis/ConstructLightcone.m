(*======================*)
(*  ConstructLightcone  *)
(*======================*)

IncludeHeader@"MakeConstraintComponentList";
IncludeHeader@"ConstraintComponentToLightcone";
IncludeHeader@"AllIndependentComponents";
IncludeHeader@"RescaleNullVector";
IncludeHeader@"MakeFreeSourceVariables";

ConstructLightcone[ClassName_?StringQ,ValuesOfSourceConstraints_]:=Module[{	
	SourceComponents,
	RescaledNullSpace
	},
	
	$LocalMasslessSpectrum=" ** ConstructLightcone...";

	ConstraintComponentList=MakeConstraintComponentList[ClassName,ValuesOfSourceConstraints];
	Diagnostic@ConstraintComponentList;
	ConstraintComponentList=xAct`xCoba`SeparateBasis[AIndex][#]&/@ConstraintComponentList;
	Diagnostic@ConstraintComponentList;
	ConstraintComponentList=(xAct`PSALTer`Private`NewParallelSubmit@(ConstraintComponentToLightcone[ClassName,#]))&/@ConstraintComponentList;
	ConstraintComponentList=MonitorParallel@ConstraintComponentList;
	Diagnostic@ConstraintComponentList;
	ConstraintComponentList=DeleteCases[ConstraintComponentList,True];
	Diagnostic@ConstraintComponentList;
	SourceComponents=AllIndependentComponents[ClassName];
	Diagnostic@SourceComponents;
	If[ConstraintComponentList==={},	
		UnscaledNullSpace=IdentityMatrix@Length@SourceComponents,
		UnscaledNullSpace=NullSpace@Last@(ConstraintComponentList~CoefficientArrays~SourceComponents);
	];
	Diagnostic@UnscaledNullSpace;
	RescaledNullSpace=RescaleNullVector[ClassName,SourceComponents,#]&/@UnscaledNullSpace;
	Diagnostic@RescaledNullSpace;
	SourceComponentsToFreeSourceVariables=MakeFreeSourceVariables[RescaledNullSpace,SourceComponents];
	Diagnostic@SourceComponentsToFreeSourceVariables;
];
