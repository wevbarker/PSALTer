(*==============*)
(*  GeneralPGT  *)
(*==============*)

Section@"Most general PGT";

Comment@{"We want to study the most general PGT. We will do this using the general coupling coefficients defined in",Cref@"CleanHayashiShirafuji","."};
DisplayExpression@CollectTensors@ToCanonical[HSNonlinearLagrangian];
LinearLagrangian=LineariseLagrangian[HSNonlinearLagrangian];
ParticleSpectrum[
	LinearLagrangian,
	ClassName->"PoincareGaugeTheory",
	TheoryName->"GeneralPGT",	
	Method->"Hard",
	MaxLaurentDepth->3
];
Comment@"These results should be compared with the Hayashi and Shirafuji papers, in particular Eqs. (4.11) in Prog. Theor. Phys. 64 (1980) 2222.";
