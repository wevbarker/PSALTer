(*===========*)
(*  PSALTer  *)
(*===========*)

(*===========*)
(*  Version  *)
(*===========*)

xAct`PSALTer`Private`$Version={"2.0.2",{2026,1,3}};
If[Unevaluated[xAct`xCore`Private`$LastPackage]===xAct`xCore`Private`$LastPackage,xAct`xCore`Private`$LastPackage="xAct`PSALTer`"];
Off@(Solve::fulldim);
Off@(General::shdw);

(*This became necessary since Wolfram 14.1*)
Unprotect@Print;
Print[Expr___]:=Null/;!($KernelID==0);
Protect@Print;
Unprotect@Message;
Message[Expr___]:=Null/;!($KernelID==0);
Protect@Message;

(*=================*)
(*  xAct`PSALTer`  *)
(*=================*)

BeginPackage["xAct`PSALTer`",{"xAct`xTensor`","xAct`SymManipulator`","xAct`xPerm`","xAct`xCore`","xAct`xTras`","xAct`xCoba`"}];
ParallelNeeds["xAct`PSALTer`"];
Print[xAct`xCore`Private`bars];
Print["Package xAct`PSALTer` version ",xAct`PSALTer`Private`$Version[[1]],", ",xAct`PSALTer`Private`$Version[[2]]];
Print["CopyRight \[Copyright] 2022, Will Barker, Giorgos Karananas, Carlo Marzo, Claire Rigouzzo and Haochen Tu, under the General Public License."];

(*====================*)
(*  Package settings  *)
(*====================*)

$DefInfoQ=False;
Unprotect@AutomaticRules;
Options[AutomaticRules]={Verbose->False};
Protect@AutomaticRules;

(*====================*)
(*  Global variables  *)
(*====================*)

If[$FrontEnd==Null,
	xAct`PSALTer`Private`$CLI=True,
	xAct`PSALTer`Private`$CLI=False,
	xAct`PSALTer`Private`$CLI=False];
Quiet@If[xAct`PSALTer`Private`$CLI,
	xAct`PSALTer`Private`$WorkingDirectory=Directory[],
	SetOptions[$FrontEndSession,EvaluationCompletionAction->"ScrollToOutput"];
	If[NotebookDirectory[]==$Failed,
		xAct`PSALTer`Private`$WorkingDirectory=Directory[],
		xAct`PSALTer`Private`$WorkingDirectory=NotebookDirectory[],
		xAct`PSALTer`Private`$WorkingDirectory=NotebookDirectory[]]];
$Path~AppendTo~xAct`PSALTer`Private`$WorkingDirectory;
xAct`PSALTer`Private`$InstallDirectory=Select[FileNameJoin[{#,"xAct/PSALTer"}]&/@$Path,DirectoryQ][[1]];
If[xAct`PSALTer`Private`$CLI,	
	Print@Import@FileNameJoin@{xAct`PSALTer`Private`$InstallDirectory,
				"Logos","ASCIILogo.txt"},
	Print@Magnify[Import@FileNameJoin@{xAct`PSALTer`Private`$InstallDirectory,
				"Logos","GitLabLogo.png"},0.3]];

(*==============*)
(*  Disclaimer  *)
(*==============*)

If[xAct`xCore`Private`$LastPackage==="xAct`PSALTer`",
Unset[xAct`xCore`Private`$LastPackage];
Print[xAct`xCore`Private`bars];
Print["These packages come with ABSOLUTELY NO WARRANTY; for details type Disclaimer[]. This is free software, and you are welcome to redistribute it under certain conditions. See the General Public License for details."];
Print[xAct`xCore`Private`bars]];

(*========================================*)
(*  Declaration of functions and options  *)
(*========================================*)

DefField::usage="DefField[F[Inds],SymmExpr,Options] defines a tensorial field F with indices Inds and index symmetries given by SymmExpr. Options are PrintAs and PrintSourceAs.";
PrintSourceAs::usage="PrintSourceAs is an option for DefField which acts as the PrintAs option for the conjugate source.";
ParticleSpectrum::usage="ParticleSpectrum[L,Options] performs the whole propagator analysis on a scalar Lagrangian density L, which is quadratic in the perturbed fields and their derivatives, and linear in the couplings. Options are TheoryName, Method and MaxLaurentDepth.";
TheoryName::usage="TheoryName is a mandatory option for ParticleSpectrum which associates a name with the linearised Lagrangian density. The option must be passed as a (string) name for the new theory.";
MaxLaurentDepth::usage="MaxLaurentDepth is an option for ParticleSpectrum which sets the maximum positive integer n for which the 1/k^(2n) null pole residues are requested. The default is 1, from which the massless spectrum can be obtained. Setting higher n naturally leads to longer wallclock times, but also allows potential (pathological) higher-order/non-simple propagator poles to be identified, down to the requested depth.";
Neglect::usage="Neglect is an option for ParticleSpectrum which specifies the spins and parities which should be neglected in the analysis. The default is {}.";
MasslessSpectrum::usage="MasslessSpectrum is an option for ParticleSpectrum which specifies whether the analysis should be performed only so far as to obtain the massive particle spectrum, or extended also to the massless spectrum. The default is True.";
Portrait::usage="Portrait is an value for the option AspectRatio which specifies that the output should be in portrait mode.";
Landscape::usage="Landscape is an value for the option AspectRatio which specifies that the output should be in landscape mode.";
ShowPropagator::usage="ShowPropagator is an option for ParticleSpectrum which specifies whether the saturated propagator should be displayed in the output. The default is True.";

(*===================================*)
(*  Declaration of association keys  *)
(*===================================*)

WaveOperator::usage="WaveOperator is the association key for the wave operator.";
PseudoDeterminant::usage="PseudoDeterminants is the association key for the pseudo determinants.";

(*===========================*)
(*  Declaration of geometry  *)
(*===========================*)

M4::usage="M4 is the flat, four-dimensional Lorentzian spacetime manifold.";
G::usage="G[-a,-b] is the Minkowski spacetime metric in rectilinear Cartesian coordinates on M4, with the West Coast signature (1,-1,-1,-1).";
CD::usage="CD[-a] is the partial derivative in rectilinear Cartesian coordinates on M4.";
V::usage="V[-a] is a unit timelike vector V[-a]V[a]=1, which is assumed to be proportional to the momentum P[-a], and which functions as the four-velocity of an observer in whose rest frame all massive particles in the spectrum are also taken to be at rest.";
P::usage="P[-a] is the timelike momentum used in the massive particle analysis, which approaches the null cone in the limit of the massless analysis.";
Def::usage="Def is the constant symbol which represents the positive square root of the norm of the timelike momentum.";
En::usage="En is the constant symbol which represents the energy, i.e. the time component of the timelike momentum.";
Mo::usage="Mo is the constant symbol which represents the relativistic momentum, i.e. the z-component of the timelike momentum.";

(*===================================*)
(*  Declaration of global variables  *)
(*===================================*)

(*$ReadOnly::usage="$ReadOnly is a boolean variable which controls whether the analysis is actually performed or simply read in from a binary file. Default is False.";*)

(*=========================*)
(*  xAct`PSALTer`Private`  *)
(*=========================*)

Begin["xAct`PSALTer`Private`"];
$DiagnosticMode=False;
$MonitorParallel=False;
$Disabled=False;
$MatricesOnly=False;
$ReadOnly=False;
$NoExport=False;
$MaxDeterminantSize=10;
$SystemTesting=False;
$InkscapePath="inkscape";
$NumericalSampleRange=500;
$MinimalExamples=10;
$NullResidueReductionMinimalExamples=5;
$MaxSeriesTerms=20;
$UnitarityTime=20;
$SomeHighPower=10;
$AspectRatio=Landscape;
$ShowPropagator=True;
$NoSourceConstraints=False;
$NoParticles=False;
$NoUnitarityConditions=False;
$MaxCoefficientLength=1;
$AbbreviationConstants=500;
$MaxAbbreviationRoot=100;
$SimplifyIfSmallLength=100;
IncludeHeader[FunctionName_]:=Module[{PathName},
	PathName=$InputFileName~StringDrop~(-2);
	PathName=FileNameJoin@{PathName,FunctionName<>".m"};
	PathName//=Get;
];
ReadAtRuntime[FunctionName_]:=Module[{PathName,FunctionSymbol=Symbol@FunctionName},
	PathName=$InputFileName~StringDrop~(-2);
	PathName=FileNameJoin@{PathName,FunctionName<>".m"};
	FunctionSymbol[]:=PathName//Get;
];
RereadSources[]:=(Off@Syntax::stresc;(Get@FileNameJoin@{$InstallDirectory,"Sources",#})&/@{
	"ReloadPackage.m",
	"DefField.m",
	"ParticleSpectrum.m"
};On@Syntax::stresc;);
RereadSources[];
Begin["xAct`PSALTer`"];
	xAct`PSALTer`Private`ReloadPackage[];
	Quiet@If[$FrontEnd==Null,
		xAct`PSALTer`Private`$CLI=True,
		xAct`PSALTer`Private`$CLI=False,
		xAct`PSALTer`Private`$CLI=False];
	$DefInfoQ=False;
End[];
End[];
EndPackage[];
