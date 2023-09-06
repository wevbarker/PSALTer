(*================*)
(*  VectorTheory  *)
(*================*)

BeginPackage["xAct`PSALTer`VectorTheory`",{"xAct`xTensor`","xAct`xPerm`","xAct`xCore`","xAct`xTras`","xAct`xCoba`","xAct`PSALTer`"}];

(*=================================================================*)
(*  Basic definitions of gauge fields and their conjugate sources  *)
(*=================================================================*)

xAct`PSALTer`VectorTheory`Private`BSymb="\[ScriptCapitalB]";
DefTensor[B[-d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`VectorTheory`Private`BSymb],Dagger->Complex];

xAct`PSALTer`VectorTheory`Private`ConjugateSourceBSymb="\[ScriptCapitalJ]";
DefTensor[ConjugateSourceB[-d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`VectorTheory`Private`ConjugateSourceBSymb],Dagger->Complex];

(*==============*)
(*  Projectors  *)
(*==============*)

(*====================================*)
(*  Basic perpendicular and parallel  *)
(*====================================*)

xAct`PSALTer`VectorTheory`Private`ProjPerpSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(^\)],\(\[UpTee]\)]\)";
DefTensor[ProjPerp[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`VectorTheory`Private`ProjPerpSymb]];
xAct`PSALTer`VectorTheory`Private`ProjParaSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(^\)],\(\[DoubleVerticalBar]\)]\)";
DefTensor[ProjPara[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`VectorTheory`Private`ProjParaSymb]];

xAct`PSALTer`VectorTheory`Private`ProjPerpParaToVG=Join[
	MakeRule[{ProjPerp[-a,b],Evaluate[V[-a]V[b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjPara[-a,b],Evaluate[G[-a,b]-V[-a]V[b]]},MetricOn->All,ContractMetrics->True]];

(*==================*)
(*  Decompositions  *)
(*==================*)

(*==============================*)
(*  Spin-parity or SO(3) parts  *)
(*==============================*)

(*======================*)
(*  Tensor definitions  *)
(*======================*)

DefSpinParityMode[B0p[],Spin->0,Parity->Even,
	FieldSymbol->xAct`PSALTer`VectorTheory`Private`BSymb,
	SourceSymbol->xAct`PSALTer`VectorTheory`Private`ConjugateSourceBSymb];

DefSpinParityMode[B1m[-a],Spin->1,Parity->Odd,
	FieldSymbol->xAct`PSALTer`VectorTheory`Private`BSymb,
	SourceSymbol->xAct`PSALTer`VectorTheory`Private`ConjugateSourceBSymb];

(*==============*)
(*  Expansions  *)
(*==============*)

xAct`PSALTer`VectorTheory`Private`BSpinParityToB=Join[
	MakeRule[{B0p[],Evaluate[V[a]B[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{B1m[-a],Evaluate[
		ProjPara[-a,b]B[-b]/.xAct`PSALTer`VectorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@B0p[],Evaluate@Dagger[V[a]B[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@B1m[-a],Evaluate@Dagger[
		ProjPara[-a,b]B[-b]/.xAct`PSALTer`VectorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`VectorTheory`Private`ConjugateSourceBSpinParityToConjugateSourceB=Join[
	MakeRule[{ConjugateSourceB0p[],Evaluate[V[a]ConjugateSourceB[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceB1m[-a],Evaluate[
		ProjPara[-a,b]ConjugateSourceB[-b]/.xAct`PSALTer`VectorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceB0p[],Evaluate@Dagger[V[a]ConjugateSourceB[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceB1m[-a],Evaluate@Dagger[
		ProjPara[-a,b]ConjugateSourceB[-b]/.xAct`PSALTer`VectorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

(*==================*)
(*  Decompositions  *)
(*==================*)

xAct`PSALTer`VectorTheory`Private`BToBSpinParity=Join[
	MakeRule[{B[-a],Evaluate[V[-a]B0p[]+B1m[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@B[-a],Evaluate@Dagger[V[-a]B0p[]+B1m[-a]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`VectorTheory`Private`ConjugateSourceBToConjugateSourceBSpinParity=Join[
	MakeRule[{ConjugateSourceB[-a],Evaluate[V[-a]ConjugateSourceB0p[]+ConjugateSourceB1m[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceB[-a],Evaluate@Dagger[V[-a]ConjugateSourceB0p[]+ConjugateSourceB1m[-a]]},MetricOn->All,ContractMetrics->True]];

(*==========================================================*)
(*  Basic definitions of the Lagrangian coupling constants  *)
(*==========================================================*)

xAct`PSALTer`VectorTheory`Private`CouplingSymb="\[Alpha]";
DefLagrangianCoupling[Coupling1,
	CouplingSymbol->xAct`PSALTer`VectorTheory`Private`CouplingSymb,CouplingIndex->1];
DefLagrangianCoupling[Coupling2,
	CouplingSymbol->xAct`PSALTer`VectorTheory`Private`CouplingSymb,CouplingIndex->2];
DefLagrangianCoupling[Coupling3,
	CouplingSymbol->xAct`PSALTer`VectorTheory`Private`CouplingSymb,CouplingIndex->3];

(*================================================*)
(*  Some infrastructure for linearising theories  *)
(*================================================*)

(*===================*)
(*  Private context  *)
(*===================*)

Begin["xAct`PSALTer`VectorTheory`Private`"];

LagrangianCouplings={Coupling1,Coupling2,Coupling3};

FieldSpinParityTensorHeads=<|
		B-><|
			0-><|Even->{B0p},Odd->{}|>,
			1-><|Even->{},Odd->{B1m}|>
		|>
|>;

SourceSpinParityTensorHeads=<|
		ConjugateSourceB-><|
			0-><|Even->{ConjugateSourceB0p},Odd->{}|>,
			1-><|Even->{},Odd->{ConjugateSourceB1m}|>
		|>
|>;

SourceEngineeringDimensions=<|
		ConjugateSourceB->0
|>;

ExpandFields[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.xAct`PSALTer`VectorTheory`Private`BSpinParityToB;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
Expr];

ExpandSources[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.xAct`PSALTer`VectorTheory`Private`ConjugateSourceBSpinParityToConjugateSourceB;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
Expr];

DecomposeFields[InputExpr_]:=Module[{Expr=InputExpr},
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`VectorTheory`Private`BToBSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
Expr];

End[];

EndPackage[];

DefClass[
	"VectorTheory",
	xAct`PSALTer`VectorTheory`Private`LagrangianCouplings,
	xAct`PSALTer`VectorTheory`Private`FieldSpinParityTensorHeads,
	xAct`PSALTer`VectorTheory`Private`SourceSpinParityTensorHeads,
	xAct`PSALTer`VectorTheory`Private`SourceEngineeringDimensions,
	xAct`PSALTer`VectorTheory`Private`ExpandFields,
	xAct`PSALTer`VectorTheory`Private`DecomposeFields,
	xAct`PSALTer`VectorTheory`Private`ExpandSources,
ExportClass->False];
