(*====================*)
(*  ConvertLightcone  *)
(*====================*)

IncludeHeader@"Repartition";
IncludeHeader@"FullyExpandSources";
IncludeHeader@"FullyCanonicalise";
IncludeHeader@"ExpressInLightcone";
IncludeHeader@"ConstrainInLightcone";
IncludeHeader@"MakeSaturatedMatrix";
IncludeHeader@"MatrixToSymbolic";
IncludeHeader@"MatrixFromSymbolic";
IncludeHeader@"ExaminePoleOrder";

Options@ConvertLightcone={
	MaxLaurentDepth->1
	};

ConvertLightcone[ClassName_?StringQ,
		ValuesSaturatedPropagator_,
		ValuesUnscaledNullSpace_,
		OptionsPattern[]]:=Module[{	
	SaturatedPropagatorArray
	},
	$LocalMasslessSpectrum=" ** ConvertLightcone...";
	LightconePropagator=ValuesSaturatedPropagator;
	Diagnostic@LightconePropagator;

	$LocalMasslessSpectrum=" ** Repartition...";
	LightconePropagator//=Repartition[#,1]&;

	$LocalMasslessSpectrum=" ** FullyExpandSources...";
	LightconePropagator=Map[
		(xAct`PSALTer`Private`NewParallelSubmit@(FullyExpandSources[ClassName,#]))&,
		LightconePropagator];
	LightconePropagator=MonitorParallel@LightconePropagator;
	Diagnostic@LightconePropagator;

	$LocalMasslessSpectrum=" ** Repartition...";
	LightconePropagator//=Repartition[#,10,ExpandAll->False]&;

	$LocalMasslessSpectrum=" ** FullyCanonicalise...";
	LightconePropagator=Map[
		(xAct`PSALTer`Private`NewParallelSubmit@(FullyCanonicalise[#]))&,
		LightconePropagator];
	LightconePropagator=MonitorParallel@LightconePropagator;
	Diagnostic@LightconePropagator;

	$LocalMasslessSpectrum=" ** Repartition...";
	LightconePropagator//=Repartition[#,10,ExpandAll->False]&;

	$LocalMasslessSpectrum=" ** ExpressInLightcone...";
	LightconePropagator=Map[
		(xAct`PSALTer`Private`NewParallelSubmit@(ExpressInLightcone[ClassName,#]))&,
		LightconePropagator];
	LightconePropagator=MonitorParallel@LightconePropagator;
	Diagnostic@LightconePropagator;

	$LocalMasslessSpectrum=" ** Repartition...";
	LightconePropagator//=Repartition[#,200]&;

	$LocalMasslessSpectrum=" ** ConstrainInLightcone...";
	LightconePropagator=MapThread[
		(xAct`PSALTer`Private`NewParallelSubmit@(ConstrainInLightcone[#1,#2]))&,
		{LightconePropagator,
		Map[((SourceComponentsToFreeSourceVariables)&),LightconePropagator]}];
	LightconePropagator=MonitorParallel@LightconePropagator;
	Diagnostic@LightconePropagator;

	LightconePropagator//=Total;
	LightconePropagator//=Expand;

	$LocalMasslessSpectrum=" ** MakeSaturatedMatrix...";

	LightconePropagator//=MakeSaturatedMatrix[#,UnscaledNullSpace]&;
	Diagnostic@LightconePropagator;

	SecularSystemValue=<||>;
	{MasslessAnalysisValue,SecularEquationValue}=ExaminePoleOrder[LightconePropagator,1];
	QuarticAnalysisValue={};
	HexicAnalysisValue={};

	$LocalMasslessSpectrum={{},{},
		MasslessAnalysisValue,
		QuarticAnalysisValue,
		HexicAnalysisValue,
		{SecularEquationValue}};

	If[(OptionValue@MaxLaurentDepth)>1,
		QuarticAnalysisValue=First@ExaminePoleOrder[LightconePropagator,2];

		$LocalMasslessSpectrum={{},{},
			MasslessAnalysisValue,
			QuarticAnalysisValue,
			HexicAnalysisValue,
			{SecularEquationValue}};
	];

	If[(OptionValue@MaxLaurentDepth)>2,
		HexicAnalysisValue=First@ExaminePoleOrder[LightconePropagator,3];

		$LocalMasslessSpectrum={{},{},
			MasslessAnalysisValue,
			QuarticAnalysisValue,
			HexicAnalysisValue,
			{SecularEquationValue}};
	];
];
