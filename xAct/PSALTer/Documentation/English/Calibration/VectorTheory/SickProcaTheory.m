(*===================*)
(*  SickProcaTheory  *)
(*===================*)

Section@"Sickly Proca field";

Comment@{"We extend our analysis of",Cref@"SickMaxwellTheory"," to the general massive case."};
LinearisedLagrangian=xAct`PSALTer`VectorTheory`Coupling1*CD[-a]@xAct`PSALTer`VectorTheory`B[-b]*CD[a]@xAct`PSALTer`VectorTheory`B[b]+xAct`PSALTer`VectorTheory`Coupling2*CD[-a]@xAct`PSALTer`VectorTheory`B[a]*CD[-b]@xAct`PSALTer`VectorTheory`B[b]+xAct`PSALTer`VectorTheory`Coupling3*xAct`PSALTer`VectorTheory`B[-a]*xAct`PSALTer`VectorTheory`B[a];
DisplayExpression[LinearisedLagrangian,EqnLabel->"SickProcaTheory"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"VectorTheory",
	TheoryName->"SickProcaTheory",	
	Method->"Easy",
	MaxLaurentDepth->3
];
Comment@"Once again, the theory is sick in the helicity-0 sector. In case the massive parity-odd vector is unitary, then the helicity-0 mode must either be a ghost or a tachyon.";
