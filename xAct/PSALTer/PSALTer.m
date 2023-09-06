(*===========*)
(*  PSALTer  *)
(*===========*)
(*------------------------------*)
(*  Change version number here  *)
(*------------------------------*)

(*
xAct`PSALTer`$Version={"0.0.0",{2022,11,4}};
*)
xAct`PSALTer`$Version={"0.0.0-developer",DateList@FileDate@$InputFileName~Drop~(-3)};

If[Unevaluated[xAct`xCore`Private`$LastPackage]===xAct`xCore`Private`$LastPackage,xAct`xCore`Private`$LastPackage="xAct`PSALTer`"];

(* here is an error-killing line, I can't quite remember why we needed it! *)
Off@(Solve::fulldim);

(*=================*)
(*  xAct`PSALTer`  *)
(*=================*)

BeginPackage["xAct`PSALTer`",{"xAct`xTensor`","xAct`SymManipulator`","xAct`xPerm`","xAct`xCore`","xAct`xTras`","xAct`xCoba`","MaTeX`"}];

ParallelNeeds["xAct`PSALTer`"];

(*========================================================================*)
(*  The output can be long, we prefer to scroll automatically to the end  *)
(*========================================================================*)

SetOptions[$FrontEndSession,EvaluationCompletionAction->"ScrollToOutput"];

Print[xAct`xCore`Private`bars];
Print["Package xAct`PSALTer` version ",$Version[[1]],", ",$Version[[2]]];
Print["CopyRight \[Copyright] 2022, Will E. V. Barker, under the General Public License."];

(*-------------------------------------------------------------------*)
(*  Modify the path to accommodate notebook and install directories  *)
(*-------------------------------------------------------------------*)

Quiet@If[NotebookDirectory[]==$Failed,$WorkingDirectory=Directory[];,$WorkingDirectory=NotebookDirectory[];,$WorkingDirectory=NotebookDirectory[];];
$Path~AppendTo~$WorkingDirectory;
$PSALTerInstallDirectory=Select[FileNameJoin[{#,"xAct/PSALTer"}]&/@$Path,DirectoryQ][[1]];

$DiagnosticMode=False;
$MonitorParallel=False;
$ExportPDF=False;

(*--------------*)
(*  Disclaimer  *)
(*--------------*)

If[xAct`xCore`Private`$LastPackage==="xAct`PSALTer`",
Unset[xAct`xCore`Private`$LastPackage];
Print[xAct`xCore`Private`bars];
Print["These packages come with ABSOLUTELY NO WARRANTY; for details type Disclaimer[]. This is free software, and you are welcome to redistribute it under certain conditions. See the General Public License for details."];
Print[xAct`xCore`Private`bars]];

(*--------------------------------------------------------------*)
(*  Declaration of provided functions and symbols for PSALTer   *)
(*--------------------------------------------------------------*)

ParticleSpectrum::usage="ParticleSpectrum[TheoryName,Expr,Tensor1,Tensor2,...,Options] performs the whole propagator analysis on a scalar Lagrangian Expr, which is quadratic in the given perturbed fields whose xTensor heads are Tensor1 and Tensor2 into its Fourier form. 
Both Expr and at least one field must be provided. Do not include indices in the fields, just list the xTensor heads (i.e. the tensor names). If these names do not correspond to gauge field perturbations that are already known to PSALTer, an error will be thrown. The string TheoryName must not contain spaces, it will be converted to a symbol set to an association which contains the results of the analysis, and (if the option Export->True is passed) it will be used to construct the file \"TheoryName.thr.mx\".";
ViewParticleSpectrum::usage="ViewParticleSpectrum[TheoryName] displays the results of the analysis.";
ClassName::usage="ClassName is a mandatory option for ParticleSpectrum which identifies the theory class to which the linearised Lagrangian belongs. The option must be passed as the (string) name of a defined theory class.";
TheoryName::usage="TheoryName is a mandatory option for ParticleSpectrum which associates a name with the linearised Lagrangian. The option must be passed as a (string) name of the new theory.";
MaxLaurentDepth::usage="MaxLaurentDepth is an option for ParticleSpectrum which sets the maximum positive integer n for which the 1/k^(2n) null pole residues are requested. The default is 1, from which the massless spectrum can be obtained. Setting higher n naturally leads to longer runtimes, but also allows potential (pathological) higher-order/non-simple propagator poles to be identified, down to the requested depth.";
DefClass::usage="DefClass[FieldSpinParityTensorHeads,SourceSpinParityTensorHeads] defines a class of models.";
ExportClass::usage="ExportClass is an option for DefClass.";
ImportClass::usage="ImportClass is an option for DefClass.";
DefSpinParityMode::usage="DefSpinParityMode[FieldSpinParityName[Inds],SymmExpr] defines a reduced-index spin parity mdoe.";
MultiTermSymmetries::usage="MultiTermSymmetries is an option for DefSpinParityMode.";
Spin::usage="Spin is an option for DefSpinParityMode.";
Parity::usage="Parity is an option for DefSpinParityMode.";
FieldSymbol::usage="FieldSpinParitySymbol is an option for DefSpinParityMode.";
SourceSymbol::usage="FieldSpinParitySymbol is an option for DefSpinParityMode.";
DefLagrangianCoupling::usage="DefLagrangianCoupling[] defines a lagrangian coupling.";
CouplingSymbol::usage="CouplingSymbol is an option for DefLagrangianCoupling.";
CouplingIndex::usage="CouplingIndex is an option for DefLagrangianCoupling.";

G::usage="G[-a,-b] is the Minkowski spacetime metric in rectilinear Cartesian coordinates, with the `West Coast' signature (1,-1,-1,-1).";
V::usage="V[-a] is a unit timelike vector V[-a]V[a]=1, which is assumed to be proportional to the momentum P[-a], and which functions as the four-velocity of an observer in whose rest frame all massive particles in the spectrum are also taken to be at rest.";
P::usage="P[-a] is the timelike momentum used in the massive particle analysis, which approaches the null cone in the limit of the massless analysis.";
Def::usage="Def is the constant symbol which represents the positive square root of the norm of the timelike momentum.";
En::usage="En is the constant symbol which represents the energy, i.e. the time component of the timelike momentum.";
Mo::usage="Mo is the constant symbol which represents the relativistic momentum, i.e. the z-component of the timelike momentum.";

Even::usage="Even is an association key which refers to even-parity spin states.";
Odd::usage="Odd is an association key which refers to odd-parity spin states.";
MomentumSpaceLagrangian::usage="MomentumSpaceLagrangian is an association key which refers to the quadratically expanded Lagrangian in momentum space.";
SourceConstraints::usage="SourceConstraints is an association key which refers to the gauge constraints on the source currents.";
BMatrices::usage="BMatrices is an association key which refers to the b-matrices.";
InverseBMatrices::usage="InverseBMatrices is an association key which refers to the inverses of the b-matrices.";
SourceConstraintComponents::usage="SourceConstraintComponents is an association key which refers to the list of components of source constraints.";
SquareMasses::usage="SquareMasses is an association key which refers to the list of square masses.";
MasslessEigenvalues::usage="MasslessEigenvalues is an association key which refers to the list of source current eignevalues in the residue of the massless pole.";

$DiagnosticMode::usage="$DiagnosticMode is a boolean variable in the context xAct`PSALTer` which controls whether internal variables are displayed during a computation. Default is False.";

(*=========================*)
(*  xAct`PSALTer`Private`  *)
(*=========================*)

Begin["xAct`PSALTer`Private`"];

BuildPackage[FileName_String]:=Get[FileNameJoin@{$PSALTerInstallDirectory,"Sources","Package",FileName}];
BuildRebuild[FileName_String]:=Get[FileNameJoin@{$PSALTerInstallDirectory,"Sources","Rebuild",FileName}];

(*-------------------------*)
(*  Registry of functions  *)
(*-------------------------*)

BuildPSALTerPackage[]:=BuildPackage/@{
	"BuildPSALTer.m",
	"ParticleSpectrum.m",
	"ViewParticleSpectrum.m",
	"DefSpinParityMode.m",
	"DefLagrangianCoupling.m",
	"DefClass.m",
	"SymbolBuild.m",
	"ToNewCanonical.m",
	"Diagnostic.m"
};

BuildPSALTerPackage[];

ContextList={	
	"xAct`PSALTer`",
	"xAct`PSALTer`Private`",
	"xAct`PSALTer`ScalarTheory`",
	"xAct`PSALTer`ScalarTheory`Private`",
	"xAct`PSALTer`VectorTheory`",
	"xAct`PSALTer`VectorTheory`Private`",
	"xAct`PSALTer`TensorTheory`",
	"xAct`PSALTer`TensorTheory`Private`",
	"xAct`PSALTer`ScalarTensorTheory`",
	"xAct`PSALTer`ScalarTensorTheory`Private`",
	"xAct`PSALTer`PoincareGaugeTheory`",
	"xAct`PSALTer`PoincareGaugeTheory`Private`",
	"xAct`xTensor`",
	"xAct`xTensor`Private`",
	"TangentM4`",
	"xAct`PSALTer`"
};

Begin["xAct`PSALTer`"];
	xAct`PSALTer`Private`BuildPSALTer[xAct`PSALTer`Private`Recompile->False];
End[];

End[];
EndPackage[];
