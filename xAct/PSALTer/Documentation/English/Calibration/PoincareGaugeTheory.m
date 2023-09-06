(*=======================*)
(*  PoincareGaugeTheory  *)
(*=======================*)

Title@"Poincaré gauge theory (PGT)";

Supercomment@"We will test the [PoincareGaugeTheory] module.";

Comment@"Here is the inverse translational gauge field, or tetrad.";
DefTensor[H[-a,c],M4,PrintAs->"\[ScriptH]"];
DisplayExpression[H[-a,c]];
Comment@"Here is the translational gauge field, or inverse tetrad.";
DefTensor[BField[a,-c],M4,PrintAs->"\[ScriptB]"];
DisplayExpression[BField[a,-c]];
HBFieldToGF=Join[
	MakeRule[{H[-i,-j],G[-i,-j]+F[-i,-j]},MetricOn->All,ContractMetrics->True],
	MakeRule[{BField[-i,-j],G[-i,-j]-F[-j,-i]+F[-i,-m]F[m,-j]},MetricOn->All,ContractMetrics->True]
];
AutomaticRules[H,MakeRule[{H[-a,i]BField[a,-j],G[i,-j]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[H,MakeRule[{H[-a,i]BField[c,-i],G[-a,c]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[H,MakeRule[{CD[-a][H[-j,n]],Evaluate[-H[-i,n]H[-j,m]CD[-a][BField[i,-m]]]},MetricOn->All,ContractMetrics->True]];

DefTensor[R[a, b, -d, -e], M4, {Antisymmetric[{a, b}], Antisymmetric[{-d, -e}]},PrintAs->"\[ScriptCapitalR]"]; 
DefTensor[T[a, -b, -c], M4, Antisymmetric[{-b, -c}],PrintAs->"\[ScriptCapitalT]"]; 
RTToHBFieldACDBFieldCDA=Join[	
	MakeRule[{R[a,b,-d,-e],H[-d,i]H[-e,j](CD[-i][A[a,b,-j]]-CD[-j][A[a,b,-i]]+A[a,-k,-i]A[k,b,-j]-A[a,-k,-j]A[k,b,-i])},MetricOn->All,ContractMetrics->True],
	MakeRule[{T[a,-b,-c],H[-b,i]H[-c,j](CD[-i][BField[a,-j]]-CD[-j][BField[a,-i]]+A[a,-k,-i]BField[k,-j]-A[a,-k,-j]BField[k,-i])},MetricOn->All,ContractMetrics->True]
];

Comment@"Here is the Riemann-Cartan tensor.";
Expr=R[a, b, -d, -e];
DisplayExpression[Expr];
Expr=Expr/.RTToHBFieldACDBFieldCDA;
Expr//=ToCanonical;
Expr//=ScreenDollarIndices;
DisplayExpression[Expr];

Comment@"Here is the torsion tensor.";
Expr=T[a, -b, -c];
DisplayExpression[Expr];
Expr=Expr/.RTToHBFieldACDBFieldCDA;
Expr//=ToCanonical;
Expr//=ScreenDollarIndices;
DisplayExpression[Expr];

Comment@"Now we set up the general Lagrangian. In the first instance we will do this with some coupling constants which are proportional to those used by Hayashi and Shirafuji in Prog. Theor. Phys. 64 (1980) 2222, and identical to those used in arXiv:2205.13534 and (up to re-labelling) arXiv:gr-qc/9902032.";

Get@FileNameJoin@{NotebookDirectory[],"Calibration","PoincareGaugeTheory",
					"LagrangianHayashiShirafujiCouplings.m"};
Get@FileNameJoin@{NotebookDirectory[],"Calibration","PoincareGaugeTheory",
					"LagrangianKarananasCouplings.m"};
Get@FileNameJoin@{NotebookDirectory[],"Calibration","PoincareGaugeTheory",
					"Linearise.m"};

BasicCriticalCases={
	kR1==kR2==kR3==kR4==kR5==kLambda/4+kT1/3+kT2/12==-kLambda/2-kT1/3+kT2/6==-kLambda-kT1/3+2*kT3/3==0,
	kR1==kR2==kR3==kR4==kR5==kT1==kT2==kT3==0
};

Get@FileNameJoin@{NotebookDirectory[],"Calibration","PoincareGaugeTheory",
					"GeneralPGT.m"};
Get@FileNameJoin@{NotebookDirectory[],"Calibration","PoincareGaugeTheory",
					"EinsteinCartanTheory.m"};
Get@FileNameJoin@{NotebookDirectory[],"Calibration","PoincareGaugeTheory",
					"GeneralRelativity.m"};
Get@FileNameJoin@{NotebookDirectory[],"Calibration","PoincareGaugeTheory",
					"MelichevPercacciTheory.m"};
Get@FileNameJoin@{NotebookDirectory[],"Calibration","PoincareGaugeTheory",
					"YoNesterTheories.m"};
Get@FileNameJoin@{NotebookDirectory[],"Calibration","PoincareGaugeTheory",
					"AnnalaRasanenTheory.m"};
Get@FileNameJoin@{NotebookDirectory[],"Calibration","PoincareGaugeTheory",
					"LinHobsonLasenbyTheories.m"};
