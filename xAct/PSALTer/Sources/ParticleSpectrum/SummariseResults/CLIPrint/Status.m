(*==========*)
(*  Status  *)
(*==========*)

Status[InputExpr_]:=Module[{TextPending="\e[1;30;40m"<>"Pending..."<>"\e[0m",TextDone="\e[1;36;40m"<>"Done!"<>"\e[0m",OutputString},
	If[InputExpr==Null,
		OutputString=TextPending,
		If[StringQ@InputExpr,
			OutputString="\e[1;33;40m"<>InputExpr<>"\e[0m",
			OutputString=TextDone,
			OutputString=TextDone
		];,
		If[StringQ@InputExpr,
			OutputString="\e[1;33;40m"<>InputExpr<>"\e[0m",
			OutputString=TextDone,
			OutputString=TextDone
		];
	];
OutputString];
