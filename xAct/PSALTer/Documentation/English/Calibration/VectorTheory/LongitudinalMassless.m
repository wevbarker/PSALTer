(*========================*)
(*  LongitudinalMassless  *)
(*========================*)

Section@"Pure longitudinal massless";

Comment@{"There is another (more obscure) special case of",Cref@"SickMaxwellTheory"," distinct from",Cref@"MaxwellTheory",", which is not pathological."};
LinearisedLagrangian=xAct`PSALTer`VectorTheory`Coupling2*CD[-a]@xAct`PSALTer`VectorTheory`B[a]*CD[-b]@xAct`PSALTer`VectorTheory`B[b];
DisplayExpression[LinearisedLagrangian,EqnLabel->"LongitudinalMassless"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"VectorTheory",
	TheoryName->"LongitudinalMassless",	
	Method->"Easy",
	MaxLaurentDepth->3
];
Comment@"The spectrum is entirely empty.";
