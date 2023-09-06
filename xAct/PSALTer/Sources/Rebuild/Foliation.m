(*=============*)
(*  Foliation  *)
(*=============*)

xAct`PSALTer`Private`VSymb="\[ScriptN]";
DefTensor[V[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild@xAct`PSALTer`Private`VSymb];
AutomaticRules[V,MakeRule[{V[-a]V[a],1}]];

xAct`PSALTer`Private`EpsSymb="\!\(\*SuperscriptBox[\(\[Epsilon]\), \(\[DoubleVerticalBar]\)]\)";
DefTensor[Eps[-a,-b,-c],M4,Antisymmetric[{-a,-b,-c}],OrthogonalTo->{V[a],V[b],V[c]},PrintAs->xAct`PSALTer`Private`SymbolBuild@xAct`PSALTer`Private`EpsSymb];

xAct`PSALTer`Private`PSymb="\[ScriptK]";
DefConstantSymbol[Def,PrintAs->xAct`PSALTer`Private`PSymb];
DefConstantSymbol[xAct`PSALTer`Private`DefSquared,PrintAs->"\[ScriptX]"];

xAct`PSALTer`Private`SSymb="\[ScriptCapitalS]";
DefConstantSymbol[Action,PrintAs->xAct`PSALTer`Private`SSymb];

DefConstantSymbol[xAct`PSALTer`Private`TCoordinate,PrintAs->"\[ScriptT]"];
DefConstantSymbol[xAct`PSALTer`Private`XCoordinate,PrintAs->"\[ScriptX]"];
DefConstantSymbol[xAct`PSALTer`Private`YCoordinate,PrintAs->"\[ScriptY]"];
DefConstantSymbol[xAct`PSALTer`Private`ZCoordinate,PrintAs->"\[ScriptZ]"];

DefTensor[P[i],M4,PrintAs->xAct`PSALTer`Private`PSymb];
AutomaticRules[P,MakeRule[{CD[-a][P[-b]],0},MetricOn->All,ContractMetrics->True]];
xAct`PSALTer`Private`ToV=MakeRule[{P[-i],Def V[-i]},MetricOn->All,ContractMetrics->True];
xAct`PSALTer`Private`ToP=MakeRule[{V[-i],P[-i]/Def},MetricOn->All,ContractMetrics->True];
