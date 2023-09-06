(*==================*)
(*  SpecialLambda3  *)
(*==================*)

Subsection@"PECT parameter is 3";

Comment@{"Let's use a cubic PECT transformation in",Cref@"QuoteGeneralCase","."};
LinearisedLagrangian=GeneralLinearisedLagrangian/.{Pw->3};
LinearisedLagrangian=LinearisedLagrangian/.ImposeGaussBonnet;
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
DisplayExpression@LinearisedLagrangian;

ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"ScalarTensorTheory",
	TheoryName->"SpecialLambda3",
	Method->"Easy",
	MaxLaurentDepth->3
];
Comment@{"Spectrum is healthy, seemingly similar to massless Einstein-Klein-Gordon in",Cref@"ScalarFierzPauliTheory","."};
