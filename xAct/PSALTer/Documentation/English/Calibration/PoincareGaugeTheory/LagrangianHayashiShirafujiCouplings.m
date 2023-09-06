(*=======================================*)
(*  LagrangianHayashiShirafujiCouplings  *)
(*=======================================*)

PpRSymb="\!\(\*SubscriptBox[OverscriptBox[\(\[ScriptCapitalP]\), \(^\)], \(\[ScriptCapitalR]\)]\)";
DefTensor[PR1[-a,-b,-c,-d,e,f,g,h],M4,PrintAs->PpRSymb<>"1"];
DefTensor[PR2[-a,-b,-c,-d,e,f,g,h],M4,PrintAs->PpRSymb<>"2"];
DefTensor[PR3[-i,-k,-l,-m,a,b,c,d],M4,PrintAs->PpRSymb<>"3"];
DefTensor[PR4[-i,-k,-l,-m,a,b,c,d],M4,PrintAs->PpRSymb<>"4"];
DefTensor[PR5[-i,-k,-l,-m,a,b,c,d],M4,PrintAs->PpRSymb<>"5"];
DefTensor[PR6[-i,-k,-l,-m,a,b,c,d],M4,PrintAs->PpRSymb<>"6"];
AutomaticRules[PR1,MakeRule[{CD[-x][PR1[-a,-b,-c,-d,e,f,g,h]],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[PR2,MakeRule[{CD[-x][PR2[-a,-b,-c,-d,e,f,g,h]],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[PR3,MakeRule[{CD[-x][PR3[-a,-b,-c,-d,e,f,g,h]],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[PR4,MakeRule[{CD[-x][PR4[-a,-b,-c,-d,e,f,g,h]],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[PR5,MakeRule[{CD[-x][PR5[-a,-b,-c,-d,e,f,g,h]],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[PR6,MakeRule[{CD[-x][PR6[-a,-b,-c,-d,e,f,g,h]],0},MetricOn->All,ContractMetrics->True]];
PWSymb="\!\(\*SubscriptBox[\(\[ScriptCapitalP]\), \(\[ScriptCapitalW]\)]\)";
DefTensor[PW[-i,-k,-l,-m,a,b,c,d],M4,PrintAs->PWSymb];
PpTSymb="\!\(\*SubscriptBox[OverscriptBox[\(\[ScriptCapitalP]\), \(^\)], \(\[ScriptCapitalT]\)]\)";
DefTensor[PT1[-a,-b,-c,e,f,g],M4,PrintAs->PpTSymb<>"1"];
DefTensor[PT2[-a,-b,-c,e,f,g],M4,PrintAs->PpTSymb<>"2"];
DefTensor[PT3[-a,-b,-c,e,f,g],M4,PrintAs->PpTSymb<>"3"];
AutomaticRules[PT1,MakeRule[{CD[-x][PT1[-a,-b,-c,e,f,g]],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[PT2,MakeRule[{CD[-x][PT2[-a,-b,-c,e,f,g]],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[PT3,MakeRule[{CD[-x][PT3[-a,-b,-c,e,f,g]],0},MetricOn->All,ContractMetrics->True]];

PWActivate=MakeRule[{PW[-i,-k,-l,-m,a,b,c,d],G[a,-i]G[b,-k]G[c,-l]G[d,-m]+(1/2)(G[b,d]G[a,-i]G[c,-m]G[-k,-l]-G[b,d]G[a,-i]G[c,-l]G[-k,-m]+G[b,d]G[a,-k]G[c,-l]G[-i,-m]-G[b,d]G[a,-k]G[c,-m]G[-i,-l])+(1/6)G[a,c]G[b,d](G[-i,-l]G[-k,-m]-G[-i,-m]G[-k,-l])},MetricOn->All,ContractMetrics->True];

PR1Definition=Antisymmetrize[Antisymmetrize[Antisymmetrize[Antisymmetrize[(2/3)G[s,-i]G[r,-n](2G[p,-j]G[q,-m]+G[p,-m]G[q,-j])(1/2)(Symmetrize[PW[-s,-p,-q,-r,a,b,c,d]+PW[-s,-r,-q,-p,a,b,c,d],{-s,-q}]),{-i,-j}],{-m,-n}],{a,b}],{c,d}]/.PWActivate//ToCanonical;
PR1Activate=MakeRule[{PR1[-i,-j,-m,-n,a,b,c,d],Evaluate[PR1Definition]},MetricOn->All,ContractMetrics->True];

PR2Definition=Antisymmetrize[Antisymmetrize[Antisymmetrize[Antisymmetrize[(1/2)(PW[-i,-j,-m,-n,a,b,c,d]-PW[-m,-n,-i,-j,a,b,c,d]),{-i,-j}],{-m,-n}],{a,b}],{c,d}]/.PWActivate//ToCanonical;
PR2Activate=MakeRule[{PR2[-i,-j,-m,-n,a,b,c,d],Evaluate[PR2Definition]},MetricOn->All,ContractMetrics->True];

PR3Definition=Antisymmetrize[Antisymmetrize[Antisymmetrize[Antisymmetrize[(-1/4)(1/6)epsilonG[-i,-j,-m,-n]epsilonG[a,b,c,d],{-i,-j}],{-m,-n}],{a,b}],{c,d}]//ToCanonical;
PR3Activate=MakeRule[{PR3[-i,-j,-m,-n,a,b,c,d],Evaluate[PR3Definition]},MetricOn->All,ContractMetrics->True];

PR4Definition=Antisymmetrize[Antisymmetrize[Antisymmetrize[Antisymmetrize[(1/2)(G[-i,-m]G[x,-j]G[y,-n]+G[-j,-n]G[x,-i]G[y,-m]-G[-j,-m]G[x,-i]G[y,-n]-G[-i,-n]G[x,-j]G[y,-m])(Symmetrize[G[-x,a]G[-y,c]G[b,d],{-x,-y}]-(1/4)G[-x,-y]G[b,d]G[a,c]),{-i,-j}],{-m,-n}],{a,b}],{c,d}]//ToCanonical;
PR4Activate=MakeRule[{PR4[-i,-j,-m,-n,a,b,c,d],Evaluate[PR4Definition]},MetricOn->All,ContractMetrics->True];

PR5Definition=Antisymmetrize[Antisymmetrize[Antisymmetrize[Antisymmetrize[(1/2)(G[-i,-m]G[x,-j]G[y,-n]+G[-j,-n]G[x,-i]G[y,-m]-G[-j,-m]G[x,-i]G[y,-n]-G[-i,-n]G[x,-j]G[y,-m])Antisymmetrize[G[-x,a]G[-y,c]G[b,d],{-x,-y}],{-i,-j}],{-m,-n}],{a,b}],{c,d}]//ToCanonical;
PR5Activate=MakeRule[{PR5[-i,-j,-m,-n,a,b,c,d],Evaluate[PR5Definition]},MetricOn->All,ContractMetrics->True];

PR6Definition=Antisymmetrize[Antisymmetrize[Antisymmetrize[Antisymmetrize[-(1/6)G[b,d]G[a,c](G[-i,-j]G[-m,-n]-G[-i,-m]G[-j,-n]),{-i,-j}],{-m,-n}],{a,b}],{c,d}]//ToCanonical;
PR6Activate=MakeRule[{PR6[-i,-j,-m,-n,a,b,c,d],Evaluate[PR6Definition]},MetricOn->All,ContractMetrics->True];

PT1Definition=Antisymmetrize[Antisymmetrize[(4/3)(Symmetrize[G[-i,a]G[-j,b]G[-k,c]+(1/3)G[-k,-i]G[a,b]G[c,-j],{-i,-j}]-(1/3)G[-i,-j]G[a,b]G[c,-k]),{-j,-k}],{b,c}]//ToCanonical;
PT1Activate=MakeRule[{PT1[-i,-j,-k,a,b,c],Evaluate[PT1Definition]},MetricOn->All,ContractMetrics->True];

PT2Definition=Antisymmetrize[Antisymmetrize[(2/3)G[-i,-j]G[a,b]G[c,-k],{-j,-k}],{b,c}]//ToCanonical;
PT2Activate=MakeRule[{PT2[-i,-j,-k,a,b,c],Evaluate[PT2Definition]},MetricOn->All,ContractMetrics->True];

PT3Definition=Antisymmetrize[Antisymmetrize[(1/6)epsilonG[-i,-j,-k,-m]epsilonG[m,a,b,c],{-j,-k}],{b,c}]//ToCanonical;
PT3Activate=MakeRule[{PT3[-i,-j,-k,a,b,c],Evaluate[PT3Definition]},MetricOn->All,ContractMetrics->True];

PActivate=Join[PWActivate,PR1Activate,PR2Activate,PR3Activate,PR4Activate,PR5Activate,PR6Activate,PT1Activate,PT2Activate,PT3Activate];

NonlinearLagrangian=(
	T[i,g,h](
		Bet1 PT1[-i,-g,-h,a,c,d]+
		Bet2 PT2[-i,-g,-h,a,c,d]+
		Bet3 PT3[-i,-g,-h,a,c,d]
	)T[-a,-c,-d]
	+R[i,j,g,h](
		Alp1 PR1[-i,-j,-g,-h,a,b,c,d]+
		Alp2 PR2[-i,-j,-g,-h,a,b,c,d]+
		Alp3 PR3[-i,-j,-g,-h,a,b,c,d]+
		Alp4 PR4[-i,-j,-g,-h,a,b,c,d]+
		Alp5 PR5[-i,-j,-g,-h,a,b,c,d]+
		Alp6 PR6[-i,-j,-g,-h,a,b,c,d]
	)R[-a,-b,-c,-d]
	-(1/2)Alp0 G[a,c]G[b,d]R[-a,-b,-c,-d]
);

DisplayExpression[NonlinearLagrangian,EqnLabel->"WithProjectors"];

Comment@{"In",Cref@"WithProjectors"," we are using projectors to extract the Lorentz irreducible representations of the fields. Next we will expand these."};

NonlinearLagrangian=NonlinearLagrangian/.PActivate;
NonlinearLagrangian//=ToCanonical;
NonlinearLagrangian//=ContractMetric;
NonlinearLagrangian//=ScreenDollarIndices;
NonlinearLagrangian//=CollectTensors;

DisplayExpression[NonlinearLagrangian,EqnLabel->"CleanHayashiShirafuji"];
HSNonlinearLagrangian=NonlinearLagrangian;
