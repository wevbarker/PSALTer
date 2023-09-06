(*====================*)
(*  FierzPauliTheory  *)
(*====================*)

Section@"Fierz-Pauli (linear gravity)";

Comment@"The natural theory to check will be the Fierz-Pauli theory.";
LinearisedLagrangian=xAct`PSALTer`TensorTheory`Coupling1*(
	(1/2)*CD[-b]@LinearMetric[a,-a]*CD[b]@LinearMetric[c,-c]
	-CD[a]@LinearMetric[-a,-b]*CD[b]@LinearMetric[c,-c]
	-(1/2)*CD[-c]@LinearMetric[a,b]*CD[c]@LinearMetric[-a,-b]
	+CD[-b]@LinearMetric[a,b]*CD[c]@LinearMetric[-a,-c]
);
DisplayExpression[LinearisedLagrangian,EqnLabel->"FierzPauliTheory"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"TensorTheory",
	TheoryName->"FierzPauliTheory",
	Method->"Easy",
	MaxLaurentDepth->3
];
Comment@{"The Fierz-Pauli theory in",Cref@"FierzPauliTheory"," propagates two massless polarisations, and the no-ghost condition is consistent with a positive Einstein or Newton-Cavendish constant, or a positive square Planck mass. The diffeomorphism invariance of the theory is manifest as a gauge symmetry, whose constraints on the source currents are commensurate with the conservation of the matter stress-energy tensor."};
