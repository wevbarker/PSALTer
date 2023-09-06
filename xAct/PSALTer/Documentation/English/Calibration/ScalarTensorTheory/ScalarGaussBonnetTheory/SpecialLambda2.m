(*==================*)
(*  SpecialLambda2  *)
(*==================*)

Subsection@"PECT parameter is 2";

Comment@{"Let's use a quadratic PECT transformation in",Cref@"QuoteGeneralCase","."};
LinearisedLagrangian=GeneralLinearisedLagrangian/.{Pw->2};
LinearisedLagrangian=LinearisedLagrangian/.ImposeGaussBonnet;
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
DisplayExpression@LinearisedLagrangian;
ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"ScalarTensorTheory",
	TheoryName->"SpecialLambda2",
	Method->"Easy",
	MaxLaurentDepth->3
];
Comment@{"Spectrum is healthy, seemingly similar to massless Einstein-Klein-Gordon in",Cref@"ScalarFierzPauliTheory","."};
