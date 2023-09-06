(*================*)
(*  ScalarTheory  *)
(*================*)

BeginPackage["xAct`PSALTer`ScalarTheory`",{"xAct`xTensor`","xAct`xPerm`","xAct`xCore`","xAct`xTras`","xAct`xCoba`","xAct`PSALTer`"}];

(*=================================================================*)
(*  Basic definitions of gauge fields and their conjugate sources  *)
(*=================================================================*)

xAct`PSALTer`ScalarTheory`Private`PhiSymb="\[CurlyPhi]";
DefTensor[Phi[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ScalarTheory`Private`PhiSymb],Dagger->Complex];

xAct`PSALTer`ScalarTheory`Private`ConjugateSourcePhiSymb="\[Rho]";
DefTensor[ConjugateSourcePhi[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ScalarTheory`Private`ConjugateSourcePhiSymb],Dagger->Complex];

(*==============*)
(*  Projectors  *)
(*==============*)

(*====================================*)
(*  Basic perpendicular and parallel  *)
(*====================================*)

(*not needed!*)

(*==================*)
(*  Decompositions  *)
(*==================*)

(*==============================*)
(*  Spin-parity or SO(3) parts  *)
(*==============================*)

(*======================*)
(*  Tensor definitions  *)
(*======================*)

DefSpinParityMode[Phi0p[],Spin->0,Parity->Even,
	FieldSymbol->xAct`PSALTer`ScalarTheory`Private`PhiSymb,
	SourceSymbol->xAct`PSALTer`ScalarTheory`Private`ConjugateSourcePhiSymb];

(*==============*)
(*  Expansions  *)
(*==============*)

xAct`PSALTer`ScalarTheory`Private`PhiSpinParityToPhi=Join[
	MakeRule[{Phi0p[],Phi[]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Phi0p[],Evaluate@Dagger[Phi[]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`ScalarTheory`Private`ConjugateSourcePhiSpinParityToConjugateSourcePhi=Join[
	MakeRule[{ConjugateSourcePhi0p[],ConjugateSourcePhi[]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourcePhi0p[],Evaluate@Dagger[ConjugateSourcePhi[]]},MetricOn->All,ContractMetrics->True]];

(*==================*)
(*  Decompositions  *)
(*==================*)

xAct`PSALTer`ScalarTheory`Private`PhiToPhiSpinParity=Join[
	MakeRule[{Phi[],Phi0p[]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Phi[],Evaluate@Dagger[Phi0p[]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`ScalarTheory`Private`ConjugateSourcePhiToConjugateSourcePhiSpinParity=Join[
	MakeRule[{ConjugateSourcePhi[],ConjugateSourcePhi0p[]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourcePhi[],Evaluate@Dagger[ConjugateSourcePhi0p[]]},MetricOn->All,ContractMetrics->True]];

(*==========================================================*)
(*  Basic definitions of the Lagrangian coupling constants  *)
(*==========================================================*)

xAct`PSALTer`ScalarTheory`Private`CouplingSymb="\[Alpha]";
DefLagrangianCoupling[Coupling1,
	CouplingSymbol->xAct`PSALTer`ScalarTheory`Private`CouplingSymb,CouplingIndex->1];
DefLagrangianCoupling[Coupling2,
	CouplingSymbol->xAct`PSALTer`ScalarTheory`Private`CouplingSymb,CouplingIndex->2];
DefLagrangianCoupling[Coupling3,
	CouplingSymbol->xAct`PSALTer`ScalarTheory`Private`CouplingSymb,CouplingIndex->3];

(*================================================*)
(*  Some infrastructure for linearising theories  *)
(*================================================*)

(*===================*)
(*  Private context  *)
(*===================*)

Begin["xAct`PSALTer`ScalarTheory`Private`"];

LagrangianCouplings={Coupling1,Coupling2,Coupling3};

FieldSpinParityTensorHeads=<|
		Phi-><|
			0-><|Even->{Phi0p},Odd->{}|>
		|>
|>;

SourceSpinParityTensorHeads=<|
		ConjugateSourcePhi-><|
			0-><|Even->{ConjugateSourcePhi0p},Odd->{}|>
		|>
|>;

SourceEngineeringDimensions=<|
		ConjugateSourcePhi->0
|>;

ExpandFields[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.xAct`PSALTer`ScalarTheory`Private`PhiSpinParityToPhi;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
Expr];

ExpandSources[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.xAct`PSALTer`ScalarTheory`Private`ConjugateSourcePhiSpinParityToConjugateSourcePhi;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
Expr];

DecomposeFields[InputExpr_]:=Module[{Expr=InputExpr},
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`ScalarTheory`Private`PhiToPhiSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
Expr];

End[];

EndPackage[];

DefClass[
	"ScalarTheory",
	xAct`PSALTer`ScalarTheory`Private`LagrangianCouplings,
	xAct`PSALTer`ScalarTheory`Private`FieldSpinParityTensorHeads,
	xAct`PSALTer`ScalarTheory`Private`SourceSpinParityTensorHeads,
	xAct`PSALTer`ScalarTheory`Private`SourceEngineeringDimensions,
	xAct`PSALTer`ScalarTheory`Private`ExpandFields,
	xAct`PSALTer`ScalarTheory`Private`DecomposeFields,
	xAct`PSALTer`ScalarTheory`Private`ExpandSources,
ExportClass->False];
