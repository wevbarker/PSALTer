(*==============================*)
(*  SecondSickFierzPauliTheory  *)
(*==============================*)

Subsection@"Sick Fierz-Pauli (second variation)";

Comment@{"We allow the third term in",Cref@"FierzPauliTheory"," to float."};
LinearisedLagrangian=xAct`PSALTer`TensorTheory`Coupling1*(
	(1/2)*CD[-b]@LinearMetric[a,-a]*CD[b]@LinearMetric[c,-c]
	-CD[a]@LinearMetric[-a,-b]*CD[b]@LinearMetric[c,-c]	
	+CD[-b]@LinearMetric[a,b]*CD[c]@LinearMetric[-a,-c]
)-xAct`PSALTer`TensorTheory`Coupling2*(1/2)*CD[-c]@LinearMetric[a,b]*CD[c]@LinearMetric[-a,-b];
DisplayExpression[LinearisedLagrangian,EqnLabel->"SecondSickFierzPauliTheory"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"TensorTheory",
	TheoryName->"SecondSickFierzPauliTheory",	
	Method->"Easy",
	MaxLaurentDepth->3
];
Comment@{"Again, as with",Cref@"FirstSickFierzPauliTheory",", this variation has no gauge symmetries, too many propagating species and no hope of unitarity."};
