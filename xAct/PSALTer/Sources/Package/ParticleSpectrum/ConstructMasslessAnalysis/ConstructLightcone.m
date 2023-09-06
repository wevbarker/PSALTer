(*======================*)
(*  ConstructLightcone  *)
(*======================*)

BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConstructLightcone/MakeConstraintComponentList.m";
BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConstructLightcone/ConstraintComponentToLightcone.m";
BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConstructLightcone/AllIndependentComponents.m";
BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConstructLightcone/RescaleNullVector.m";
BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConstructLightcone/MakeFreeSourceVariables.m";

ConstructLightcone[ClassName_?StringQ,ValuesOfSourceConstraints_]:=Module[{	
	SourceComponents,
	RescaledNullSpace
	},
	
	LocalMasslessSpectrum=" ** ConstructLightcone...";

	ConstraintComponentList=MakeConstraintComponentList[ClassName,ValuesOfSourceConstraints];
	Diagnostic@ConstraintComponentList;
	ConstraintComponentList=xAct`xCoba`SeparateBasis[AIndex][#]&/@ConstraintComponentList;
	Diagnostic@ConstraintComponentList;

	ConstraintComponentList=(xAct`PSALTer`Private`PSALTerParallelSubmit@(ConstraintComponentToLightcone[ClassName,#]))&/@ConstraintComponentList;
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
