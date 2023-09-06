(*==================*)
(*  GeneralLambda3  *)
(*==================*)

Subsection@"PECT parameter is 2";

Comment@{"Let's use a quadratic PECT transformation in",Cref@"QuoteGeneralCase","."};
LinearisedLagrangian=GeneralLinearisedLagrangian/.{Pw->2};
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
DisplayExpression@LinearisedLagrangian;
ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"ScalarTensorTheory",
	TheoryName->"GeneralLambda2",
	Method->"Easy",
	MaxLaurentDepth->3
];
Comment@"Spectrum is unacceptable.";
