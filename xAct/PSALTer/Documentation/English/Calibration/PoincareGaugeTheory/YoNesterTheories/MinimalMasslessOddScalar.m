(*============================*)
(*  MinimalMasslessOddScalar  *)
(*============================*)

Subsection@"Minimal massless odd-parity scalar model";

Comment@{"We will study the minimal model set out between Eqs. (4.47) and (4.48) of arXiv:9902032."};
NonlinearLagrangian=HSNonlinearLagrangian/.{Alp0->4*Bet1,Alp1->0,Alp2->0,Alp4->0,Alp5->0,Alp6->0,Bet2->-2*Bet1,Bet3->-Bet1/2};
DisplayExpression@CollectTensors@ToCanonical[NonlinearLagrangian];
LinearLagrangian=LineariseLagrangian[NonlinearLagrangian];
ParticleSpectrum[
	LinearLagrangian,
	ClassName->"PoincareGaugeTheory",
	TheoryName->"MinimalMasslessOddScalar",	
	Method->"Hard",
	MaxLaurentDepth->3
];
Comment@"Thus we see that only the Einstein graviton is moving, with no extra species whatever. This might seem strange, since we have taken the massless limit of the pseudoscalar mode, but the fact that the spectrum empties discontinuously in this scenario is already predicted in the Hamiltonian analysis, see the second paragraph on page 20 of arXiv:9902032.";
