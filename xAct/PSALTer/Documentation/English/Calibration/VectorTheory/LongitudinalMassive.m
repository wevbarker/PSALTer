(*=======================*)
(*  LongitudinalMassive  *)
(*=======================*)

Section@"Pure longitudinal massive";

Comment@{"Similarly, there is a healthy special case of",Cref@"SickProcaTheory",", which is distinct from",Cref@"ProcaTheory",", and which is just the massive case of",Cref@"LongitudinalMassless","."};
LinearisedLagrangian=xAct`PSALTer`VectorTheory`Coupling2*CD[-a]@xAct`PSALTer`VectorTheory`B[a]*CD[-b]@xAct`PSALTer`VectorTheory`B[b]+xAct`PSALTer`VectorTheory`Coupling3*xAct`PSALTer`VectorTheory`B[-a]*xAct`PSALTer`VectorTheory`B[a];
DisplayExpression@LinearisedLagrangian;
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"VectorTheory",
	TheoryName->"LongitudinalMassive",	
	Method->"Easy",
	MaxLaurentDepth->3
];
Comment@"The theory propagates a single, healthy massive scalar.";
