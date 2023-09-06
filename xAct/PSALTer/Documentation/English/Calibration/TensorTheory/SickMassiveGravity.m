(*======================*)
(*  SickMassiveGravity  *)
(*======================*)

Section@"Sick massive gravity";

Comment@{"We now break the `Fierz-Pauli tuning' in",Cref@"MassiveGravity","."};
LinearisedLagrangian=xAct`PSALTer`TensorTheory`Coupling1*(
	(1/2)*CD[-b]@LinearMetric[a,-a]*CD[b]@LinearMetric[c,-c]
	-CD[a]@LinearMetric[-a,-b]*CD[b]@LinearMetric[c,-c]
	-(1/2)*CD[-c]@LinearMetric[a,b]*CD[c]@LinearMetric[-a,-b]
	+CD[-b]@LinearMetric[a,b]*CD[c]@LinearMetric[-a,-c]
)+xAct`PSALTer`TensorTheory`Coupling2*LinearMetric[-a,-b]*LinearMetric[a,b]-xAct`PSALTer`TensorTheory`Coupling3*LinearMetric[a,-a]*LinearMetric[b,-b];
DisplayExpression[LinearisedLagrangian,EqnLabel->"SickMassiveGravity"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"TensorTheory",
	TheoryName->"SickMassiveGravity",	
	Method->"Easy",
	MaxLaurentDepth->3
];
Comment@"The consequence is seen in the positive-parity scalar sector, which develops a massive pole. This is the Boulware-Deser ghost, which always spoils the unitarity of the theory.";
