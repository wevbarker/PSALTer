(*===============*)
(*  SymbolBuild  *)
(*===============*)

(*===========================*)
(*  Spin and Lorentz labels  *)
(*===========================*)

CouplingIndexSuffices=<|
	None->"\!\(\*UnderscriptBox[\(.\), \(.\)]\)",
	0->"\!\(\*UnderscriptBox[\(.\), \(0\)]\)",
	1->"\!\(\*UnderscriptBox[\(.\), \(1\)]\)",
	2->"\!\(\*UnderscriptBox[\(.\), \(2\)]\)",
	3->"\!\(\*UnderscriptBox[\(.\), \(3\)]\)",
	4->"\!\(\*UnderscriptBox[\(.\), \(4\)]\)",
	5->"\!\(\*UnderscriptBox[\(.\), \(5\)]\)",
	6->"\!\(\*UnderscriptBox[\(.\), \(6\)]\)",
	7->"\!\(\*UnderscriptBox[\(.\), \(7\)]\)",
	8->"\!\(\*UnderscriptBox[\(.\), \(8\)]\)",
	9->"\!\(\*UnderscriptBox[\(.\), \(9\)]\)",
	10->"\!\(\*UnderscriptBox[\(.\), \(10\)]\)",
	11->"\!\(\*UnderscriptBox[\(.\), \(11\)]\)",
	12->"\!\(\*UnderscriptBox[\(.\), \(12\)]\)",
	13->"\!\(\*UnderscriptBox[\(.\), \(13\)]\)",
	14->"\!\(\*UnderscriptBox[\(.\), \(14\)]\)",
	15->"\!\(\*UnderscriptBox[\(.\), \(15\)]\)",
	16->"\!\(\*UnderscriptBox[\(.\), \(16\)]\)"
|>;

SpinParityPreffices=<|
	0-><|
		Even->"\!\(\*OverscriptBox[\(.\), SuperscriptBox[\(0\), \(+\)]]\)",
		Odd->"\!\(\*OverscriptBox[\(.\), SuperscriptBox[\(0\), \(-\)]]\)"
	|>,
	1-><|
		Even->"\!\(\*OverscriptBox[\(.\), SuperscriptBox[\(1\), \(+\)]]\)",
		Odd->"\!\(\*OverscriptBox[\(.\), SuperscriptBox[\(1\), \(-\)]]\)"
	|>,
	2-><|
		Even->"\!\(\*OverscriptBox[\(.\), SuperscriptBox[\(2\), \(+\)]]\)",
		Odd->"\!\(\*OverscriptBox[\(.\), SuperscriptBox[\(2\), \(-\)]]\)"
	|>,
	3-><|
		Even->"\!\(\*OverscriptBox[\(.\), SuperscriptBox[\(3\), \(+\)]]\)",
		Odd->"\!\(\*OverscriptBox[\(.\), SuperscriptBox[\(3\), \(-\)]]\)"
	|>,
	4-><|
		Even->"\!\(\*OverscriptBox[\(.\), SuperscriptBox[\(4\), \(+\)]]\)",
		Odd->"\!\(\*OverscriptBox[\(.\), SuperscriptBox[\(4\), \(-\)]]\)"
	|>,
	5-><|
		Even->"\!\(\*OverscriptBox[\(.\), SuperscriptBox[\(5\), \(+\)]]\)",
		Odd->"\!\(\*OverscriptBox[\(.\), SuperscriptBox[\(5\), \(-\)]]\)"
	|>
|>;

Spin0p="\!\(\*OverscriptBox[\(.\), SuperscriptBox[\(0\), \(+\)]]\)";
Spin0m="\!\(\*OverscriptBox[\(.\), SuperscriptBox[\(0\), \(-\)]]\)";
Spin1p="\!\(\*OverscriptBox[\(.\), SuperscriptBox[\(1\), \(+\)]]\)";
Spin1m="\!\(\*OverscriptBox[\(.\), SuperscriptBox[\(1\), \(-\)]]\)";
Spin2p="\!\(\*OverscriptBox[\(.\), SuperscriptBox[\(2\), \(+\)]]\)";
Spin2m="\!\(\*OverscriptBox[\(.\), SuperscriptBox[\(2\), \(-\)]]\)";
Spin3p="\!\(\*OverscriptBox[\(.\), SuperscriptBox[\(3\), \(+\)]]\)";
Spin3m="\!\(\*OverscriptBox[\(.\), SuperscriptBox[\(3\), \(-\)]]\)";
SO0="\!\(\*OverscriptBox[\(.\), \(0\)]\)";
SO1="\!\(\*OverscriptBox[\(.\), \(1\)]\)";
SO2="\!\(\*OverscriptBox[\(.\), \(2\)]\)";
SO3="\!\(\*OverscriptBox[\(.\), \(3\)]\)";
SO4="\!\(\*OverscriptBox[\(.\), \(4\)]\)";
SO5="\!\(\*OverscriptBox[\(.\), \(5\)]\)";
SO6="\!\(\*OverscriptBox[\(.\), \(6\)]\)";
GB="\!\(\*OverscriptBox[\(.\), \(GB\)]\)";

dSpin0p="\!\(\*UnderscriptBox[\(.\), SuperscriptBox[\(0\), \(+\)]]\)";
dSpin0m="\!\(\*UnderscriptBox[\(.\), SuperscriptBox[\(0\), \(-\)]]\)";
dSpin1p="\!\(\*UnderscriptBox[\(.\), SuperscriptBox[\(1\), \(+\)]]\)";
dSpin1m="\!\(\*UnderscriptBox[\(.\), SuperscriptBox[\(1\), \(-\)]]\)";
dSpin2p="\!\(\*UnderscriptBox[\(.\), SuperscriptBox[\(2\), \(+\)]]\)";
dSpin2m="\!\(\*UnderscriptBox[\(.\), SuperscriptBox[\(2\), \(-\)]]\)";
dSpin3p="\!\(\*UnderscriptBox[\(.\), SuperscriptBox[\(3\), \(+\)]]\)";
dSpin3m="\!\(\*UnderscriptBox[\(.\), SuperscriptBox[\(3\), \(-\)]]\)";
dSOX="\!\(\*UnderscriptBox[\(.\), \(.\)]\)";
dSO0="\!\(\*UnderscriptBox[\(.\), \(0\)]\)";
dSO1="\!\(\*UnderscriptBox[\(.\), \(1\)]\)";
dSO2="\!\(\*UnderscriptBox[\(.\), \(2\)]\)";
dSO3="\!\(\*UnderscriptBox[\(.\), \(3\)]\)";
dSO4="\!\(\*UnderscriptBox[\(.\), \(4\)]\)";
dSO5="\!\(\*UnderscriptBox[\(.\), \(5\)]\)";
dSO6="\!\(\*UnderscriptBox[\(.\), \(6\)]\)";
dGB="\!\(\*UnderscriptBox[\(.\), \(GB\)]\)";

(*===================*)
(*  Colour settings  *)
(*===================*)

$CouplingColour=RGBColor[0,0,0];
$TensorColour=RGBColor[0,0,0];
$IrrepColour=RGBColor[0,0,0];

Options[SymbolBuild]={IsConstantSymbol->False};
SymbolBuild[TensorSymbol_,IrrepSymbol:_?StringQ:"",OptionsPattern[]]:=Module[{FullSymbol},
	If[PossibleZeroQ@StringLength@IrrepSymbol,
		FullSymbol=ColorString[TensorSymbol,$TensorColour];,
		If[OptionValue@IsConstantSymbol,
			FullSymbol=ColorString[TensorSymbol,$CouplingColour]~StringJoin~ColorString[IrrepSymbol,$IrrepColour];,
			FullSymbol=ColorString[IrrepSymbol,$IrrepColour]~StringJoin~ColorString[TensorSymbol,$TensorColour];
		];
	];
FullSymbol];
