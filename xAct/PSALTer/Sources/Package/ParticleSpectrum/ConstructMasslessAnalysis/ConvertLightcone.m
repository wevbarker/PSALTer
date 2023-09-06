(*====================*)
(*  ConvertLightcone  *)
(*====================*)

BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConvertLightcone/ExpressInLightcone.m";

ConvertLightcone[ClassName_?StringQ,ValuesSaturatedPropagator_]:=Module[{	
	SaturatedPropagatorArray,
	},

	LocalMasslessSpectrum=" ** ConvertLightcone...";

	SaturatedPropagatorArray=(If[Head@#===Plus,List@@#,List@#])&/@(ValuesSaturatedPropagator);
	Diagnostic@SaturatedPropagatorArray;

	SaturatedPropagatorArray//=(#~PadRight~{Length@#,First@((Length/@#)~TakeLargest~1)})&;
	Diagnostic@SaturatedPropagatorArray;

	LightconePropagator=MapThread[
		(xAct`PSALTer`Private`PSALTerParallelSubmit@(ExpressInLightcone[ClassName,#1,#2]))&,
		{SaturatedPropagatorArray,
		Map[((SourceComponentsToFreeSourceVariables)&),SaturatedPropagatorArray,{2}]},2];
	LightconePropagator=MonitorParallel@LightconePropagator;
	Diagnostic@LightconePropagator;
];
