(*=====================*)
(*  GeneralRelativity  *)
(*=====================*)

Section@"General relativity (GR)";

Comment@{"Using the coupling coefficients in",Cref@"CleanKarananas",", it is particularly easy to also look at GR, instead of Einstein-Cartan theory. The difference here is that the quadratic torsion coefficients are manually removed."};
Off[Solve::svars];
CaseRules=(First/@(Solve[#,{kR1,kR2,kR3,kR4,kR5,kT1,kT2,kT3,kLambda}]&/@BasicCriticalCases))[[2]];
On[Solve::svars];
DisplayExpression[CollectTensors@ToCanonical[KNonlinearLagrangian/.CaseRules],
			EqnLabel->"GeneralRelativity"];
LinearLagrangian=LineariseLagrangian[KNonlinearLagrangian/.CaseRules];
ParticleSpectrum[
	LinearLagrangian,
	ClassName->"PoincareGaugeTheory",
	TheoryName->"GeneralRelativity",	
	Method->"Easy",
	MaxLaurentDepth->3
];
Comment@{"The spectra of",Cref@{"EinsteinCartanTheory","GeneralRelativity"}," are identical, as expected."};
