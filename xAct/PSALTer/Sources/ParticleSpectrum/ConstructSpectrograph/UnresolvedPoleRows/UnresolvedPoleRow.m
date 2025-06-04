(*=====================*)
(*  UnresolvedPoleRow  *)
(*=====================*)

UnresolvedPoleRow[
	UnresolvedPole_,
	Spin_,
	Parity_]:=Module[{
		Expr,
		ParityString=Switch[Parity,1,"Even",-1,"Odd",0,"None"]},
	Expr={Switch[ResourceFunction["PolynomialDegree"][#1,Def]/2,
			2,
			GetDiagram@("FeynmanDiagramSpin"<>(ToString@Spin)<>"Parity"<>ParityString<>"UnresolvedDouble.pdf"),
			3,
			GetDiagram@("FeynmanDiagramSpin"<>(ToString@Spin)<>"Parity"<>ParityString<>"UnresolvedTriple.pdf"),
			4,
			GetDiagram@("FeynmanDiagramSpin"<>(ToString@Spin)<>"Parity"<>ParityString<>"UnresolvedQuadruple.pdf"),
			5,
			GetDiagram@("FeynmanDiagramSpin"<>(ToString@Spin)<>"Parity"<>ParityString<>"UnresolvedQuintuple.pdf")
		],
		(2*Spin+1)*ResourceFunction["PolynomialDegree"][#1,Def]/2,
		Text@ShowIfSmall@#1,
		SpanFromLeft}&/@UnresolvedPole;
Expr];
