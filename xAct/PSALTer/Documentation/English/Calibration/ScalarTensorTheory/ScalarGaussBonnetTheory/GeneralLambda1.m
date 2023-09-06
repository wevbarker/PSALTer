(*==================*)
(*  GeneralLambda1  *)
(*==================*)

Subsection@"PECT parameter is 1";

Comment@{"Let's use a linear PECT transformation in",Cref@"QuoteGeneralCase","."};
LinearisedLagrangian=GeneralLinearisedLagrangian/.{Pw->1};
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
DisplayExpression@LinearisedLagrangian;
ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"ScalarTensorTheory",
	TheoryName->"GeneralLambda1",
	Method->"Easy",
	MaxLaurentDepth->3
];
Comment@"Spectrum is unacceptable.";
