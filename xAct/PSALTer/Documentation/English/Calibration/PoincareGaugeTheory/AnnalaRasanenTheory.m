(*=================*)
(*  AnnalaRasanen  *)
(*=================*)

Section@"Annala-Räsänen column 4 rows 1 and 2";

Comment@{"We will target a fairly ambitious configuration, with the aim of covering all the zero non-metricity Palatini results in arXiv:2212.09820. Recycling some coupling symbols for ease (i.e. as with",Cref@"MelichevPercacci"," these won't have the same interpretation as those in",Cref@"CleanHayashiShirafuji","), we think this is the following nonlinear Lagrangian."};
NonlinearLagrangian=-(1/2)*Alp0*R[a,b,-a,-b]+R[a,c,b,-c]*(Alp1*R[-a,d,-b,-d]+Alp2*R[-b,d,-a,-d])+Alp3*R[a,b,-a,-b]*R[c,d,-c,-d];
DisplayExpression[CollectTensors@ToCanonical[NonlinearLagrangian],EqnLabel->"Carlo"];
LinearLagrangian=LineariseLagrangian[NonlinearLagrangian];
ParticleSpectrum[
	LinearLagrangian,
	ClassName->"PoincareGaugeTheory",
	TheoryName->"AnnalaRasanenColumn4",	
	Method->"Hard",
	MaxLaurentDepth->3
];
Comment@"The conclusion is that even this quite general configuration propagates nothing apart from the graviton of Einstein.";
