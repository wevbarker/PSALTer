(*==========*)
(*  Status  *)
(*==========*)

(*Do **not** use ~Y~ here*)
Status[InputExpr_]:=Module[{OutputString},
	OutputString="\e[1;34;40m"<>InputExpr<>"\e[0m";
OutputString];
