(*=================*)
(*  PrintSpectrum  *)
(*=================*)

ConfigureMaTeX["pdfLaTeX" -> "/usr/bin/lualatex", "Ghostscript" -> "/usr/bin/gs"];
SetOptions[MaTeX, "Preamble" -> {"\\usepackage{tikz}\\usepackage{tikz-feynman}"}];



Options@PrintParticle={
	LaurentDepth->1
	};

PrintParticle[MassivePoleResidue_,SquareMass_,Spin_,Parity_,Polarisations_,OptionsPattern[]]:=Module[{TempGraphics},

	SpinStyles=<|0->"scalar",1->"photon",2->"Tensor",3->"Spin3"|>;
	SpinStyle=Evaluate@SpinStyles@Spin;
	ParityColours=<|Even->"red",Odd->"blue"|>;	
	ParityColour=Evaluate@ParityColours@Parity;
	ToParity=<|Even->"+",Odd->"-"|>;

	TikzSet="\\tikzset{
			Tensor/.style={decorate, decoration={snake, amplitude=.8mm, segment length=1.5mm, pre length=.5mm, post length=.5mm}, double},
			Spin3/.style={decorate, decoration={zigzag, amplitude=.8mm, segment length=1.5mm, pre length=.5mm, post length=.5mm}, double}
			}";
	OpenDiagram="
			\\tikzfeynmanset{every vertex/.style={large}}
			\\feynmandiagram[medium,horizontal=a to b]{
			i1[particle=\(?\),gray!50] --[thick,gray!50] a [crossed dot, thick,gray!50],

			i2[particle=\(?\),gray!50] --[thick,gray!50] a,
			a ";
	If[SquareMass===0,

	Switch[OptionValue@LaurentDepth,
		1,	
		(
		CloseDiagram=" b[crossed dot, thick,gray!50],
				a --[draw=none, momentum={\\tiny{\(k^{\mu}=(p,0,0,p)\)}}] b,
				b --[thick,gray!50] f1[particle=\(?\),gray!50],
				b --[thick,gray!50] f2[particle=\(?\),gray!50],
				b --[thick,gray!50] f3[particle=\(?\),gray!50]};";	
		TempGraphics=Column[{
			Labeled[MaTeX[TikzSet<>OpenDiagram<>"--[thick]"<>CloseDiagram,Magnification->1.3],"Massless particle"],
			Grid[
			{
				{Text@"Pole residue: ",Text@ShowIfSmall@(MassivePoleResidue>0)},
				{Text@"Polarisations: ",Text@ShowIfSmall@(Polarisations)}
			},
			Frame->All,Alignment->Left,Background->DetailColor]
		},Alignment->Center];
		),
		2,
		(
		CloseDiagram=" b[crossed dot, thick,gray!50],
				b --[ghost, thick, half left, looseness=1.3, momentum={[arrow shorten=0.3]\\tiny{\(k^{\mu}=(\\mathcal{E},0,0,p)\)}}] a,
				b --[thick,gray!50] f1[particle=\(?\),gray!50],
				b --[thick,gray!50] f2[particle=\(?\),gray!50],
				b --[thick,gray!50] f3[particle=\(?\),gray!50]};";	
		TempGraphics=Column[{
			Labeled[MaTeX[TikzSet<>OpenDiagram<>"--[thick, half left, looseness=1.3,momentum={[arrow shorten=0.3]\\tiny{\(k^{\mu}=(p,0,0,p)\)}}]"<>CloseDiagram,Magnification->1.3],"Quartic pole"],
			Grid[
			{
				{Text@"Pole residue: ",Text@ShowIfSmall@(0<MassivePoleResidue>0)},
				{Text@"Polarisations: ",Text@ShowIfSmall@(Polarisations)}
			},
			Frame->All,Alignment->Left,Background->DetailColor]
		},Alignment->Center];
		),
		3,
		(
		CloseDiagram=" b[crossed dot, thick,gray!50],
				b --[ghost, thick, half left, looseness=1.8, momentum={[arrow shorten=0.3]\\tiny{\(k^{\mu}=(\\mathcal{E},0,0,p)\)}}] a,
				b --[ghost, thick, half left, looseness=0.9,momentum'={[arrow shorten=0.35]}] a,
				a --[thick, half left, looseness=0.9,momentum'={[arrow shorten=0.35]}] b,
				b --[thick,gray!50] f1[particle=\(?\),gray!50],
				b --[thick,gray!50] f2[particle=\(?\),gray!50],
				b --[thick,gray!50] f3[particle=\(?\),gray!50]};";	
		TempGraphics=Column[{
			Labeled[MaTeX[TikzSet<>OpenDiagram<>"--[thick, half left, looseness=1.8,momentum={[arrow shorten=0.3]\\tiny{\(k^{\mu}=(p,0,0,p)\)}}]"<>CloseDiagram,Magnification->1.3],"Hexic pole"],
			Grid[
			{
				{Text@"Pole residue: ",Text@ShowIfSmall@(0<MassivePoleResidue>0)},
				{Text@"Polarisations: ",Text@ShowIfSmall@(Polarisations)}
			},
			Frame->All,Alignment->Left,Background->DetailColor]
		},Alignment->Center];
		)
	];

	,

	CloseDiagram=" b[crossed dot, thick,gray!50],
			a --[draw=none,"<>ParityColour<>",  momentum'={[arrow style="<>ParityColour<>"]\\tiny{\(k^{\mu}=(\\mathcal{E},0,0,p)\)}}] b,
			a --[draw=none,"<>ParityColour<>", half left, looseness=0.3,  edge label = {\\scriptsize{\(J^{P}="<>ToString@Spin<>"^{"<>ToString@Evaluate@ToParity@Parity<>"}\)}\\vspace{1cm}}] b,
			b --[thick,gray!50] f1[particle=\(?\),gray!50],
			b --[thick,gray!50] f2[particle=\(?\),gray!50],
			b --[thick,gray!50] f3[particle=\(?\),gray!50]};";	
	TempGraphics=Column[{
		Labeled[MaTeX[TikzSet<>OpenDiagram<>"--["<>ParityColour<>", "<>SpinStyle<>", thick]"<>CloseDiagram,Magnification->1.3],"Massive particle"],
		Grid[
		{
			{Text@"Pole residue: ",Text@ShowIfSmall@(MassivePoleResidue>0)},
			{Text@"Square mass: ",Text@ShowIfSmall@(SquareMass>0)},
			{Text@"Spin: ",Text@(Spin)},
			{Text@"Parity: ",Text@(Parity)}
		},
		Frame->All,Alignment->Left,Background->DetailColor]
	},Alignment->Center];

	];

TempGraphics];

PrintMassiveSpectrum[SquareMasses_,MassivePropagatorResidues_]:=Print@Column@(Flatten[MapThread[If[!(PossibleZeroQ@#1),
			PrintParticle[#1,#2,#4,#3,2*#4+1],
			0
	]&,
	PadRight[#,{Length@#,Max@(Length/@#)}]&/@{
		MassivePropagatorResidues,
		SquareMasses,
		MapThread[ConstantArray[#1,Length@#2]&,
				{{Even,Odd,Even,Odd,Even,Odd,Even,Odd}~Take~Length@SquareMasses,
				SquareMasses},1],
		MapThread[ConstantArray[#1,Length@#2]&,
				{{0,0,1,1,2,2,3,3}~Take~Length@SquareMasses,
				SquareMasses},1]
	},2],{1,2}]~DeleteCases~0);

StripFactors[MasslessEigenvalue_]:=Module[{Expr,
	MasslessEigenvalueNumerator=Numerator@Normal@MasslessEigenvalue,
	MasslessEigenvalueDenominator=Denominator@Normal@MasslessEigenvalue},
	MasslessEigenvalueNumerator/=(2*3*5*7*11)^10;
	MasslessEigenvalueNumerator//=Simplify;
	MasslessEigenvalueNumerator//=Numerator;
	MasslessEigenvalueDenominator/=(2*3*5*7*11)^10;
	MasslessEigenvalueDenominator//=Simplify;
	MasslessEigenvalueDenominator//=Numerator;
	Expr=MasslessEigenvalueNumerator/MasslessEigenvalueDenominator;
	Expr//=FullSimplify;
Expr];

PrintMasslessSpectrum[MasslessEigenvalues_]:=Print@Column@(PrintParticle[First@#,0,0,0,Length@#]&/@Gather@(StripFactors/@MasslessEigenvalues));

PrintSpectrum[
		SquareMasses_,
		MassivePropagatorResidues_,
		MasslessEigenvalues_,
		QuarticAnalysisValue_,
		HexicAnalysisValue_]:=Module[{ContentList},

	ContentList=(
		(MapThread[If[!(#1==={}),
					PrintParticle[First@#1,First@#2,#4,#3,2*#4+1],
					0
			]&,{
				MassivePropagatorResidues,
				SquareMasses,
				{Even,Odd,Even,Odd,Even,Odd,Even,Odd}~Take~Length@SquareMasses,
				{0,0,1,1,2,2,3,3}~Take~Length@SquareMasses
			}]~DeleteCases~0)
		)~Join~(
		Join[
			(PrintParticle[First@#,0,0,0,Length@#,LaurentDepth->1]&/@Gather@(StripFactors/@MasslessEigenvalues)),
			(PrintParticle[First@#,0,0,0,Length@#,LaurentDepth->2]&/@Gather@(StripFactors/@QuarticAnalysisValue)),
			(PrintParticle[First@#,0,0,0,Length@#,LaurentDepth->3]&/@Gather@(StripFactors/@HexicAnalysisValue))
		]
	);

	If[!(ContentList=={}),ContentList//=Column;];
ContentList];
