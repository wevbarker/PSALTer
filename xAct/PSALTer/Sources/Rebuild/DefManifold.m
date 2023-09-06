(*===============*)
(*  DefManifold  *)
(*===============*)

DefManifold[M4,4,IndexRange[{a,z}]];

Quiet@DefMetric[-1,G[-a,-c],CD,{",","\[PartialD]"},PrintAs->"\[Eta]",FlatMetric->True,SymCovDQ->True];

xAct`PSALTer`Private`StandardIndices=ToExpression/@Alphabet[];
(*
xAct`PSALTer`Private`StandardIndicesSymb=ToString@ToExpression@("\\[Gothic"<>ToUpperCase@ToString@#<>"]")&/@Alphabet[];
*)
xAct`PSALTer`Private`StandardIndicesSymb=(ToString@#)&/@Evaluate@((#[[2]])&/@{
	{a,"\[Alpha]"},
	{b,"\[Beta]"},
	{c,"\[Chi]"},
	{d,"\[Delta]"},
	{e,"\[Epsilon]"},
	{f,"\[Phi]"},
	{g,"\[Gamma]"},
	{h,"\[Eta]"},
	{i,"\[Iota]"},
	{j,"\[Theta]"},
	{k,"\[Kappa]"},
	{l,"\[Lambda]"},
	{m,"\[Mu]"},
	{n,"\[Nu]"},
	{o,"\[Omicron]"},
	{p,"\[Pi]"},
	{q,"\[Omega]"},
	{r,"\[Rho]"},
	{s,"\[Sigma]"},
	{t,"\[Tau]"},
	{u,"\[Upsilon]"},
	{v,"\[Psi]"},
	{w,"\[Omega]"},
	{x,"\[Xi]"},
	{y,"\[CurlyPhi]"},
	{z,"\[Zeta]"}
});

(PrintAs@Evaluate@#1^=Evaluate@#2)&~MapThread~{xAct`PSALTer`Private`StandardIndices,xAct`PSALTer`Private`StandardIndicesSymb};
