(*============================*)
(*  PrintUnitarityConditions  *)
(*============================*)

PrintUnitarityConditions[InputExpr_]:=Grid[
					{{Text@"Unitarity conditions"},{If[ListQ@InputExpr,
						Map[Text,First@InputExpr],
						InputExpr]}},
						ItemStyle->{LineIndent->0},	
						Dividers->Center,
						Alignment->Left];
