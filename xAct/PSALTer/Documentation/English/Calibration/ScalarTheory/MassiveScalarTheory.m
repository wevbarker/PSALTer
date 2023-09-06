(*=======================*)
(*  MassiveScalarTheory  *)
(*=======================*)

Section@"Massive scalar (Higgs field, pions)";

Comment@"A massive scalar field theory.";
LinearisedLagrangian=xAct`PSALTer`ScalarTheory`Coupling1*CD[-a]@xAct`PSALTer`ScalarTheory`Phi[]CD[a]@xAct`PSALTer`ScalarTheory`Phi[]-xAct`PSALTer`ScalarTheory`Coupling2*Phi[]*Phi[];
DisplayExpression@LinearisedLagrangian;
ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"ScalarTheory",
	TheoryName->"MassiveScalarTheory",
	Method->"Easy",
	MaxLaurentDepth->3
];
Comment@"We find that the massless eigenvalue has disappeared, but the propagator develops a massive pole whose no-ghost condition is equivalent. There is an additional no-tachyon condition on the Klein-Gordon mass.";
