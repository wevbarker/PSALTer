(*=============*)
(*  NewFramed  *)
(*=============*)

NewFramed[InputExpr_]:=Framed[InputExpr,
			Background->$DetailColor,
			FrameStyle->Directive[$DetailColor,Thickness[4]],
			RoundingRadius->$FrameRoundingRadius];


