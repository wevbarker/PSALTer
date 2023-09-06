(*======================*)
(*  ScalarTensorTheory  *)
(*======================*)

BeginPackage["xAct`PSALTer`ScalarTensorTheory`",{"xAct`xTensor`","xAct`xPerm`","xAct`xCore`","xAct`xTras`","xAct`xCoba`","xAct`PSALTer`"}];

(*=================================================================*)
(*  Basic definitions of gauge fields and their conjugate sources  *)
(*=================================================================*)

xAct`PSALTer`ScalarTensorTheory`Private`ScalarTensorPhiSymb="\[CurlyPhi]";
DefTensor[ScalarTensorPhi[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ScalarTensorTheory`Private`ScalarTensorPhiSymb],Dagger->Complex];

xAct`PSALTer`ScalarTensorTheory`Private`ScalarTensorLinearMetricSymb="\[ScriptH]";
DefTensor[ScalarTensorLinearMetric[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ScalarTensorTheory`Private`ScalarTensorLinearMetricSymb],Dagger->Complex];

xAct`PSALTer`ScalarTensorTheory`Private`ConjugateSourceScalarTensorPhiSymb="\[Rho]";
DefTensor[ConjugateSourceScalarTensorPhi[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ScalarTensorTheory`Private`ConjugateSourceScalarTensorPhiSymb],Dagger->Complex];

xAct`PSALTer`ScalarTensorTheory`Private`ScalarTensorStressEnergySymb="\[ScriptCapitalT]";
DefTensor[ScalarTensorStressEnergy[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ScalarTensorTheory`Private`ScalarTensorStressEnergySymb],Dagger->Complex];

(*==============*)
(*  Projectors  *)
(*==============*)

(*====================================*)
(*  Basic perpendicular and parallel  *)
(*====================================*)

xAct`PSALTer`ScalarTensorTheory`Private`ProjPerpSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(^\)],\(\[UpTee]\)]\)";
DefTensor[ProjPerp[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ScalarTensorTheory`Private`ProjPerpSymb]];
xAct`PSALTer`ScalarTensorTheory`Private`ProjParaSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(^\)],\(\[DoubleVerticalBar]\)]\)";
DefTensor[ProjPara[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ScalarTensorTheory`Private`ProjParaSymb]];

xAct`PSALTer`ScalarTensorTheory`Private`ProjPerpParaToVG=Join[
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

DefSpinParityMode[ScalarTensorPhi0p[],Spin->0,Parity->Even,
	FieldSymbol->xAct`PSALTer`ScalarTensorTheory`Private`ScalarTensorPhiSymb,
	SourceSymbol->xAct`PSALTer`ScalarTensorTheory`Private`ConjugateSourceScalarTensorPhiSymb];

xAct`PSALTer`ScalarTensorTheory`Private`ScalarTensorLinearMetricPerpSymb="\!\(\*SuperscriptBox[\(\[ScriptH]\),\(\[UpTee]\)]\)";
DefTensor[ScalarTensorLinearMetricPerp0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ScalarTensorTheory`Private`ScalarTensorLinearMetricPerpSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];

DefTensor[ScalarTensorLinearMetricPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ScalarTensorTheory`Private`ScalarTensorLinearMetricPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];

xAct`PSALTer`ScalarTensorTheory`Private`ScalarTensorLinearMetricParaSymb="\!\(\*SuperscriptBox[\(\[ScriptH]\),\(\[DoubleVerticalBar]\)]\)";

DefTensor[ScalarTensorLinearMetricPara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ScalarTensorTheory`Private`ScalarTensorLinearMetricParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];

DefTensor[ScalarTensorLinearMetricPara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ScalarTensorTheory`Private`ScalarTensorLinearMetricParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];


AutomaticRules[ScalarTensorLinearMetricPara2p,MakeRule[{Evaluate@Dagger@ScalarTensorLinearMetricPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[ScalarTensorLinearMetricPara2p,MakeRule[{ScalarTensorLinearMetricPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`ScalarTensorTheory`Private`ScalarTensorStressEnergyPerpSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalT]\),\(\[UpTee]\)]\)";
DefTensor[ScalarTensorStressEnergyPerp0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ScalarTensorTheory`Private`ScalarTensorStressEnergyPerpSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[ScalarTensorStressEnergyPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ScalarTensorTheory`Private`ScalarTensorStressEnergyPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
xAct`PSALTer`ScalarTensorTheory`Private`ScalarTensorStressEnergyParaSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalT]\),\(\[DoubleVerticalBar]\)]\)";
DefTensor[ScalarTensorStressEnergyPara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ScalarTensorTheory`Private`ScalarTensorStressEnergyParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[ScalarTensorStressEnergyPara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ScalarTensorTheory`Private`ScalarTensorStressEnergyParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];

AutomaticRules[ScalarTensorStressEnergyPara2p,MakeRule[{Evaluate@Dagger@ScalarTensorStressEnergyPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[ScalarTensorStressEnergyPara2p,MakeRule[{ScalarTensorStressEnergyPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

(*==============*)
(*  Expansions  *)
(*==============*)

xAct`PSALTer`ScalarTensorTheory`Private`ScalarTensorPhiSpinParityToScalarTensorPhi=Join[
	MakeRule[{ScalarTensorPhi0p[],ScalarTensorPhi[]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ScalarTensorPhi0p[],Evaluate@Dagger[ScalarTensorPhi[]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`ScalarTensorTheory`Private`ScalarTensorLinearMetricSpinParityToScalarTensorLinearMetric=Join[
	MakeRule[{ScalarTensorLinearMetricPerp0p[],Evaluate[
		ProjPerp[a,b]ScalarTensorLinearMetric[-a,-b]/.xAct`PSALTer`ScalarTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ScalarTensorLinearMetricPerp1m[-a],Evaluate[
		V[b]ProjPara[-a,c]ScalarTensorLinearMetric[-c,-b]/.xAct`PSALTer`ScalarTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ScalarTensorLinearMetricPara0p[],Evaluate[
		ProjPara[a,b]ScalarTensorLinearMetric[-a,-b]/.xAct`PSALTer`ScalarTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ScalarTensorLinearMetricPara2p[-a,-b],Evaluate[
		(ProjPara[-a,c]ProjPara[-b,d]-(1/3)*ProjPara[-a,-b]ProjPara[c,d])*ScalarTensorLinearMetric[-c,-d]/.xAct`PSALTer`ScalarTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ScalarTensorLinearMetricPerp0p[],Evaluate@Dagger[
		ProjPerp[a,b]ScalarTensorLinearMetric[-a,-b]/.xAct`PSALTer`ScalarTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ScalarTensorLinearMetricPerp1m[-a],Evaluate@Dagger[
		V[b]ProjPara[-a,c]ScalarTensorLinearMetric[-c,-b]/.xAct`PSALTer`ScalarTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ScalarTensorLinearMetricPara0p[],Evaluate@Dagger[
		ProjPara[a,b]ScalarTensorLinearMetric[-a,-b]/.xAct`PSALTer`ScalarTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ScalarTensorLinearMetricPara2p[-a,-b],Evaluate@Dagger[
		(ProjPara[-a,c]ProjPara[-b,d]-(1/3)*ProjPara[-a,-b]ProjPara[c,d])*ScalarTensorLinearMetric[-c,-d]/.xAct`PSALTer`ScalarTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`ScalarTensorTheory`Private`ConjugateSourceScalarTensorPhiSpinParityToConjugateSourceScalarTensorPhi=Join[
	MakeRule[{ConjugateSourceScalarTensorPhi0p[],ConjugateSourceScalarTensorPhi[]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceScalarTensorPhi0p[],Evaluate@Dagger[ConjugateSourceScalarTensorPhi[]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`ScalarTensorTheory`Private`ScalarTensorStressEnergySpinParityToScalarTensorStressEnergy=Join[
	MakeRule[{ScalarTensorStressEnergyPerp0p[],Evaluate[
		ProjPerp[a,b]ScalarTensorStressEnergy[-a,-b]/.xAct`PSALTer`ScalarTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ScalarTensorStressEnergyPerp1m[-a],Evaluate[
		V[b]ProjPara[-a,c]ScalarTensorStressEnergy[-c,-b]/.xAct`PSALTer`ScalarTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ScalarTensorStressEnergyPara0p[],Evaluate[
		ProjPara[a,b]ScalarTensorStressEnergy[-a,-b]/.xAct`PSALTer`ScalarTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ScalarTensorStressEnergyPara2p[-a,-b],Evaluate[
		(ProjPara[-a,c]ProjPara[-b,d]-(1/3)*ProjPara[-a,-b]ProjPara[c,d])*ScalarTensorStressEnergy[-c,-d]/.xAct`PSALTer`ScalarTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ScalarTensorStressEnergyPerp0p[],Evaluate@Dagger[
		ProjPerp[a,b]ScalarTensorStressEnergy[-a,-b]/.xAct`PSALTer`ScalarTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ScalarTensorStressEnergyPerp1m[-a],Evaluate@Dagger[
		V[b]ProjPara[-a,c]ScalarTensorStressEnergy[-c,-b]/.xAct`PSALTer`ScalarTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ScalarTensorStressEnergyPara0p[],Evaluate@Dagger[
		ProjPara[a,b]ScalarTensorStressEnergy[-a,-b]/.xAct`PSALTer`ScalarTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ScalarTensorStressEnergyPara2p[-a,-b],Evaluate@Dagger[
		(ProjPara[-a,c]ProjPara[-b,d]-(1/3)*ProjPara[-a,-b]ProjPara[c,d])*ScalarTensorStressEnergy[-c,-d]/.xAct`PSALTer`ScalarTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

(*==================*)
(*  Decompositions  *)
(*==================*)

xAct`PSALTer`ScalarTensorTheory`Private`ScalarTensorPhiToScalarTensorPhiSpinParity=Join[
	MakeRule[{ScalarTensorPhi[],ScalarTensorPhi0p[]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ScalarTensorPhi[],Evaluate@Dagger[ScalarTensorPhi0p[]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`ScalarTensorTheory`Private`ScalarTensorLinearMetricToScalarTensorLinearMetricSpinParity=Join[
	MakeRule[{ScalarTensorLinearMetric[-a,-b],Evaluate[
		(
			ScalarTensorLinearMetricPerp0p[]V[-a]V[-b]
			+ScalarTensorLinearMetricPerp1m[-a]V[-b]
			+ScalarTensorLinearMetricPerp1m[-b]V[-a]
			+(1/3)*ScalarTensorLinearMetricPara0p[]ProjPara[-a,-b]
			+ScalarTensorLinearMetricPara2p[-a,-b]
		)/.xAct`PSALTer`ScalarTensorTheory`Private`ProjPerpParaToVG//ToCanonical
	]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ScalarTensorLinearMetric[-a,-b],Evaluate@Dagger[
		(
			ScalarTensorLinearMetricPerp0p[]V[-a]V[-b]
			+ScalarTensorLinearMetricPerp1m[-a]V[-b]
			+ScalarTensorLinearMetricPerp1m[-b]V[-a]
			+(1/3)*ScalarTensorLinearMetricPara0p[]ProjPara[-a,-b]
			+ScalarTensorLinearMetricPara2p[-a,-b]
		)/.xAct`PSALTer`ScalarTensorTheory`Private`ProjPerpParaToVG//ToCanonical
	]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`ScalarTensorTheory`Private`ConjugateSourceScalarTensorPhiToConjugateSourceScalarTensorPhiSpinParity=Join[
	MakeRule[{ConjugateSourceScalarTensorPhi[],ConjugateSourceScalarTensorPhi0p[]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceScalarTensorPhi[],Evaluate@Dagger[ConjugateSourceScalarTensorPhi0p[]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`ScalarTensorTheory`Private`ScalarTensorStressEnergyToScalarTensorStressEnergySpinParity=Join[
	MakeRule[{ScalarTensorStressEnergy[-a,-b],Evaluate[
		(
			ScalarTensorStressEnergyPerp0p[]V[-a]V[-b]
			+ScalarTensorStressEnergyPerp1m[-a]V[-b]
			+ScalarTensorStressEnergyPerp1m[-b]V[-a]
			+(1/3)*ScalarTensorStressEnergyPara0p[]ProjPara[-a,-b]
			+ScalarTensorStressEnergyPara2p[-a,-b]
		)/.xAct`PSALTer`ScalarTensorTheory`Private`ProjPerpParaToVG//ToCanonical
	]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ScalarTensorStressEnergy[-a,-b],Evaluate@Dagger[
		(
			ScalarTensorStressEnergyPerp0p[]V[-a]V[-b]
			+ScalarTensorStressEnergyPerp1m[-a]V[-b]
			+ScalarTensorStressEnergyPerp1m[-b]V[-a]
			+(1/3)*ScalarTensorStressEnergyPara0p[]ProjPara[-a,-b]
			+ScalarTensorStressEnergyPara2p[-a,-b]
		)/.xAct`PSALTer`ScalarTensorTheory`Private`ProjPerpParaToVG//ToCanonical
	]},MetricOn->All,ContractMetrics->True]];

(*==========================================================*)
(*  Basic definitions of the Lagrangian coupling constants  *)
(*==========================================================*)

xAct`PSALTer`ScalarTensorTheory`Private`CouplingSymb="\[Alpha]";
DefLagrangianCoupling[Coupling1,
	CouplingSymbol->xAct`PSALTer`ScalarTensorTheory`Private`CouplingSymb,CouplingIndex->1];
DefLagrangianCoupling[Coupling2,
	CouplingSymbol->xAct`PSALTer`ScalarTensorTheory`Private`CouplingSymb,CouplingIndex->2];
DefLagrangianCoupling[Coupling3,
	CouplingSymbol->xAct`PSALTer`ScalarTensorTheory`Private`CouplingSymb,CouplingIndex->3];
DefLagrangianCoupling[Coupling4,
	CouplingSymbol->xAct`PSALTer`ScalarTensorTheory`Private`CouplingSymb,CouplingIndex->4];
DefLagrangianCoupling[Coupling5,
	CouplingSymbol->xAct`PSALTer`ScalarTensorTheory`Private`CouplingSymb,CouplingIndex->5];
DefLagrangianCoupling[Coupling6,
	CouplingSymbol->xAct`PSALTer`ScalarTensorTheory`Private`CouplingSymb,CouplingIndex->6];
DefLagrangianCoupling[Coupling7,
	CouplingSymbol->xAct`PSALTer`ScalarTensorTheory`Private`CouplingSymb,CouplingIndex->7];
DefLagrangianCoupling[Coupling8,
	CouplingSymbol->xAct`PSALTer`ScalarTensorTheory`Private`CouplingSymb,CouplingIndex->8];
DefLagrangianCoupling[Coupling9,
	CouplingSymbol->xAct`PSALTer`ScalarTensorTheory`Private`CouplingSymb,CouplingIndex->9];
DefLagrangianCoupling[Coupling10,
	CouplingSymbol->xAct`PSALTer`ScalarTensorTheory`Private`CouplingSymb,CouplingIndex->10];

(*================================================*)
(*  Some infrastructure for linearising theories  *)
(*================================================*)

(*===================*)
(*  Private context  *)
(*===================*)

Begin["xAct`PSALTer`ScalarTensorTheory`Private`"];

LagrangianCouplings={Coupling1,Coupling2,Coupling3};

FieldSpinParityTensorHeads=<|
		ScalarTensorPhi-><|
			0-><|Even->{ScalarTensorPhi0p},Odd->{}|>,
			1-><|Even->{},Odd->{}|>,
			2-><|Even->{},Odd->{}|>
		|>,
		ScalarTensorLinearMetric-><|
			0-><|Even->{ScalarTensorLinearMetricPerp0p,ScalarTensorLinearMetricPara0p},Odd->{}|>,
			1-><|Even->{},Odd->{ScalarTensorLinearMetricPerp1m}|>,
			2-><|Even->{ScalarTensorLinearMetricPara2p},Odd->{}|>
		|>
|>;

SourceSpinParityTensorHeads=<|
		ConjugateSourceScalarTensorPhi-><|
			0-><|Even->{ConjugateSourceScalarTensorPhi0p},Odd->{}|>,
			1-><|Even->{},Odd->{}|>,
			2-><|Even->{},Odd->{}|>
		|>,
		ScalarTensorStressEnergy-><|
			0-><|Even->{ScalarTensorStressEnergyPerp0p,ScalarTensorStressEnergyPara0p},Odd->{}|>,
			1-><|Even->{},Odd->{ScalarTensorStressEnergyPerp1m}|>,
			2-><|Even->{ScalarTensorStressEnergyPara2p},Odd->{}|>
		|>
|>;

SourceEngineeringDimensions=<|
		ConjugateSourceScalarTensorPhi->0,
		ScalarTensorStressEnergy->1
|>;

ExpandFields[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.xAct`PSALTer`ScalarTensorTheory`Private`ScalarTensorPhiSpinParityToScalarTensorPhi;
	Expr=Expr/.xAct`PSALTer`ScalarTensorTheory`Private`ScalarTensorLinearMetricSpinParityToScalarTensorLinearMetric;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
Expr];

ExpandSources[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.xAct`PSALTer`ScalarTensorTheory`Private`ConjugateSourceScalarTensorPhiSpinParityToConjugateSourceScalarTensorPhi;
	Expr=Expr/.xAct`PSALTer`ScalarTensorTheory`Private`ScalarTensorStressEnergySpinParityToScalarTensorStressEnergy;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
Expr];

DecomposeFields[InputExpr_]:=Module[{Expr=InputExpr},
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`ScalarTensorTheory`Private`ScalarTensorPhiToScalarTensorPhiSpinParity;
	Expr=Expr/.xAct`PSALTer`ScalarTensorTheory`Private`ScalarTensorLinearMetricToScalarTensorLinearMetricSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
Expr];

End[];

EndPackage[];

DefClass[
	"ScalarTensorTheory",
	xAct`PSALTer`ScalarTensorTheory`Private`LagrangianCouplings,
	xAct`PSALTer`ScalarTensorTheory`Private`FieldSpinParityTensorHeads,
	xAct`PSALTer`ScalarTensorTheory`Private`SourceSpinParityTensorHeads,
	xAct`PSALTer`ScalarTensorTheory`Private`SourceEngineeringDimensions,
	xAct`PSALTer`ScalarTensorTheory`Private`ExpandFields,
	xAct`PSALTer`ScalarTensorTheory`Private`DecomposeFields,
	xAct`PSALTer`ScalarTensorTheory`Private`ExpandSources,
ExportClass->False];
