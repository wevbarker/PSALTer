(*===============*)
(*  ProcaTheory  *)
(*===============*)

Section@"Proca field (electroweak bosons)";

Comment@{"Having investigated the massless theory in",Cref@"MaxwellTheory"," we keep the same kinetic term but now add a mass term. This is the Proca theory."};
LinearisedLagrangian=xAct`PSALTer`VectorTheory`Coupling1*(CD[-a]@xAct`PSALTer`VectorTheory`B[-b]-CD[-b]@xAct`PSALTer`VectorTheory`B[-a])*(CD[a]@xAct`PSALTer`VectorTheory`B[b]-CD[b]@xAct`PSALTer`VectorTheory`B[a])+xAct`PSALTer`VectorTheory`Coupling3*xAct`PSALTer`VectorTheory`B[-a]*xAct`PSALTer`VectorTheory`B[a];
DisplayExpression[LinearisedLagrangian,EqnLabel->"ProcaTheory"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"VectorTheory",
	TheoryName->"ProcaTheory",	
	Method->"Easy",
	MaxLaurentDepth->3
];
Comment@"If you write out the Proca equation of motion and take the divergence, you see that the presence of the mass term restricts the vector to be divergence-free, which is another way of saying that the helicity-0 mode vanishes on-shell. This is not a gauge condition (evidenced by the fact that the Lagrangian operator matrices are non-singular), but it does mean that in common with Maxwell's theory, we have the parity-odd vector mode. What is this mode doing? The theory is now massive, and so there is a massive pole in the propagator. There are now two unitarity conditions: the original no-ghost condition and a new no-tachyon condition which protects the Proca mass from becoming imaginary.";
