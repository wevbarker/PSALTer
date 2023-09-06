(*==============================*)
(*  FourthSickFierzPauliTheory  *)
(*==============================*)

Section@"Sick Fierz-Pauli (fourth variation)";

Comment@{"We allow the first term in",Cref@"FierzPauliTheory"," to float."};
LinearisedLagrangian=xAct`PSALTer`TensorTheory`Coupling1*(
	-CD[a]@LinearMetric[-a,-b]*CD[b]@LinearMetric[c,-c]
	-(1/2)*CD[-c]@LinearMetric[a,b]*CD[c]@LinearMetric[-a,-b]
	+CD[-b]@LinearMetric[a,b]*CD[c]@LinearMetric[-a,-c]
)+xAct`PSALTer`TensorTheory`Coupling2*(1/2)*CD[-b]@LinearMetric[a,-a]*CD[b]@LinearMetric[c,-c];
DisplayExpression[LinearisedLagrangian,EqnLabel->"FourthSickFierzPauliTheory"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"TensorTheory",
	TheoryName->"FourthSickFierzPauliTheory",
	Method->"Easy",
	MaxLaurentDepth->3
];
Comment@{"As with",Cref@"ThirdSickFierzPauliTheory",", we have a partial gauge symmetry and an extra scalar mode."};
