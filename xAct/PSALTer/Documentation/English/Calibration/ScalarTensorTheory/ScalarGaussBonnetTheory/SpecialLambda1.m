(*==================*)
(*  SpecialLambda1  *)
(*==================*)

Subsection@"PECT parameter is 1";

Comment@{"Let's use a linear PECT transformation in",Cref@"QuoteGeneralCase","."};
LinearisedLagrangian=GeneralLinearisedLagrangian/.{Pw->1};
LinearisedLagrangian=LinearisedLagrangian/.ImposeGaussBonnet;
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
DisplayExpression@LinearisedLagrangian;

ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"ScalarTensorTheory",
	TheoryName->"SpecialLambda1",
	Method->"Easy",
	MaxLaurentDepth->3
];
Comment@{"Spectrum is healthy, seemingly similar to massless Einstein-Klein-Gordon in",Cref@"ScalarFierzPauliTheory","."};
