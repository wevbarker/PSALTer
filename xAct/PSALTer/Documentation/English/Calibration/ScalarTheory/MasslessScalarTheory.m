(*========================*)
(*  MasslessScalarTheory  *)
(*========================*)

Section@"Massless scalar (shift-symmetric field)";

Comment@"A massless scalar field theory.";
LinearisedLagrangian=xAct`PSALTer`ScalarTheory`Coupling1*CD[-a]@xAct`PSALTer`ScalarTheory`Phi[]CD[a]@xAct`PSALTer`ScalarTheory`Phi[];
DisplayExpression[LinearisedLagrangian,EqnLabel->"MasslessScalarTheory"];
ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"ScalarTheory",
	TheoryName->"MasslessScalarTheory",
	Method->"Easy",
	MaxLaurentDepth->3
];
Comment@"There is one massless polarisation, supported by a no-ghost condition which bounds the kinetic part of the Hamiltonian from below.";
