(*===============*)
(*  TimedReduce  *)
(*===============*)

TimedReduce[CouplingAssumptions_,Couplings_,PositiveSystem_]~Y~Module[{Expr,Result},
	TimeConstrained[
		Off@PrintAsCharacter::argx;
		Result=Assuming[CouplingAssumptions,Reduce[PositiveSystem,Couplings,Reals]];
		On@PrintAsCharacter::argx;
		If[Result===False,
			Expr=Text@"(Demonstrably impossible)";
		,
			If[ListQ@Result,
				Expr=Result;
			,
				Expr={Result};
			];
		];
	,
		$UnitarityTime
	,
		Expr=Null;
		(*Expr=Text@("(Timeout after "<>ToString@$UnitarityTime<>" seconds)");*)
	];
Expr];
