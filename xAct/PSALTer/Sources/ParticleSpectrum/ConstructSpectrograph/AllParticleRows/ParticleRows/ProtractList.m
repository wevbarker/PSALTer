(*================*)
(*  ProtractList  *)
(*================*)

ProtractList[InputList_]~Y~Module[{Expr={}},
	Diagnostic@InputList;
	Table[
		If[InputList[[2*i-1]]===InputList[[2*i]],
			Expr~AppendTo~{};
			Expr~AppendTo~{};
			Expr~AppendTo~InputList[[2*i-1]];
			,
			Expr~AppendTo~InputList[[2*i-1]];
			Expr~AppendTo~InputList[[2*i]];
			Expr~AppendTo~{};
		];,
	{i,Length@InputList/2}];	
	Diagnostic@Expr;
Expr];
