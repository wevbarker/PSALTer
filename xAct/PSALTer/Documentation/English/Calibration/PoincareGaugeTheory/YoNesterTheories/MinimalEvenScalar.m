(*=====================*)
(*  MinimalEvenScalar  *)
(*=====================*)

Subsection@"Minimal even-parity scalar model";

Comment@{"We will study the minimal model set out in Eq. (4.1) of arXiv:9902032."};
NonlinearLagrangian=HSNonlinearLagrangian/.{Alp1->0,Alp2->0,Alp3->0,Alp4->0,Alp5->0,Bet2->-2*Bet1,Bet3->-Bet1/2};
DisplayExpression@CollectTensors@ToCanonical[NonlinearLagrangian];
LinearLagrangian=LineariseLagrangian[NonlinearLagrangian];
ParticleSpectrum[
	LinearLagrangian,
	ClassName->"PoincareGaugeTheory",
	TheoryName->"MinimalEvenScalar",	
	Method->"Hard",
	MaxLaurentDepth->3
];
Comment@"Thus we see that only the odd-parity scalar mode is moving with a mass, as claimed.";
