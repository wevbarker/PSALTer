(*==================*)
(*  GeneralLambda3  *)
(*==================*)

Subsection@"PECT parameter is 3";

Comment@{"Let's use a cubic PECT transformation in",Cref@"QuoteGeneralCase","."};
LinearisedLagrangian=GeneralLinearisedLagrangian/.{Pw->3};
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
DisplayExpression@LinearisedLagrangian;
ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"ScalarTensorTheory",
	TheoryName->"GeneralLambda3",
	Method->"Easy",
	MaxLaurentDepth->3
];
Comment@"Spectrum is unacceptable.";
