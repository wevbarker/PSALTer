(*======================*)
(*  DecompositionTable  *)
(*======================*)

DecompositionTable[FieldTensors_,
	FieldTensorsSymmetries_,
	FieldTensorsExpanded_,
	SourceTensors_]:=Module[{FinalGrid},
	FinalGrid=(
		{{Text@"Fundamental field",Text@"Symmetries",Text@"Decomposition into SO(3) irrep(s)",Text@"Source"}}~Join~
		MapThread[{#1,#2,#3,#4}&,{Text/@FieldTensors,
					Text/@FieldTensorsSymmetries,
					Text/@FieldTensorsExpanded,
					Text/@SourceTensors}]
		);
FinalGrid];
