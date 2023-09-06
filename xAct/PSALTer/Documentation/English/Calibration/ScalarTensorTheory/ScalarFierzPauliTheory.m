(*==========================*)
(*  ScalarFierzPauliTheory  *)
(*==========================*)

Section@"Einstein-Klein-Gordon theory";

Comment@{"We check the Fierz-Pauli theory in",Cref@"FierzPauliTheory"," accompanied by (but not coupled to) the massless scalar in",Cref@"MasslessScalarTheory","."};
LinearisedLagrangian=xAct`PSALTer`ScalarTensorTheory`Coupling1*(
	(1/2)*CD[-b]@ScalarTensorLinearMetric[a,-a]*CD[b]@ScalarTensorLinearMetric[c,-c]
	-CD[a]@ScalarTensorLinearMetric[-a,-b]*CD[b]@ScalarTensorLinearMetric[c,-c]
	-(1/2)*CD[-c]@ScalarTensorLinearMetric[a,b]*CD[c]@ScalarTensorLinearMetric[-a,-b]
	+CD[-b]@ScalarTensorLinearMetric[a,b]*CD[c]@ScalarTensorLinearMetric[-a,-c]
)+xAct`PSALTer`ScalarTensorTheory`Coupling2*CD[-a]@ScalarTensorPhi[]*CD[a]@ScalarTensorPhi[];
DisplayExpression[LinearisedLagrangian,EqnLabel->"ScalarFierzPauliTheory"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"ScalarTensorTheory",
	TheoryName->"ScalarFierzPauliTheory",
	Method->"Easy",
	MaxLaurentDepth->3
];
Comment@"We obtain the graviton and a massless scalar.";
