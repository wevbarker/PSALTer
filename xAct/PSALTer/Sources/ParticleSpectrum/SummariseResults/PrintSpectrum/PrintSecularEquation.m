(*========================*)
(*  PrintSecularEquation  *)
(*========================*)

PrintSecularEquation[InputExpr_]:=Module[{FinalGrid},
	FinalGrid=NewFramed@Grid[
		{{Text@"Secular equation"},{InputExpr==0}},
			Dividers->Center,
			Alignment->Left,
			Background->$DetailColor];
FinalGrid];
