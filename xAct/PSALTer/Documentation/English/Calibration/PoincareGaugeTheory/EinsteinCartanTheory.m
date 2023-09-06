(*========================*)
(*  EinsteinCartanTheory  *)
(*========================*)

Section@"Einstein-Cartan theory (ECT)";

Comment@"We would like to check the basic Einstein-Cartan theory.";
Off[Solve::svars];
CaseRules=(First/@(Solve[#,{kR1,kR2,kR3,kR4,kR5,kT1,kT2,kT3,kLambda}]&/@BasicCriticalCases))[[1]];
On[Solve::svars];
DisplayExpression[CollectTensors@ToCanonical[KNonlinearLagrangian/.CaseRules],
			EqnLabel->"EinsteinCartanTheory"];
LinearLagrangian=LineariseLagrangian[KNonlinearLagrangian/.CaseRules];
ParticleSpectrum[
	LinearLagrangian,
	ClassName->"PoincareGaugeTheory",
	TheoryName->"EinsteinCartanTheory",	
	Method->"Easy",
	MaxLaurentDepth->3
];
Comment@{"What we find are no propagating massive modes, but instead two degrees of freedom in the massive sector. The no-ghost conditions on these massless d.o.f restrict the sign in front of the Einstein-Hilbert term to be negative (which is what we expect for our conventions). Note that this results is essentially the same as",Cref@"FierzPauliTheory","."};
