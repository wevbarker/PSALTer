(*==========================*)
(*  PrintSourceConstraints  *)
(*==========================*)

PrintSourceConstraints[SpinParitySourceConstraints_,
	CovariantSourceConstraints_,
	Multiplicities_]:=Module[{FinalGrid},
FinalGrid=Grid[
	(
	{{Text@"Spin-parity form",Text@"Covariant form",Text@"Multiplicities"}}~Join~
	MapThread[{#1,#2,#3}&,{SpinParitySourceConstraints,
				CovariantSourceConstraints,
				Multiplicities}]
	)~Join~
	{{Text@"Total expected gauge generators:",SpanFromLeft,Total@Multiplicities}},
Frame->All,Alignment->Left,Background->DetailColor];

FinalGrid];
