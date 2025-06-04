(*===============*)
(*  LowestOrder  *)
(*===============*)

LowestOrder[InputExpr_]~Y~Module[{Expr},
	Do[
		If[!(0===SeriesCoefficient[InputExpr,{Parameter,0,TrialOrder}]),
			Expr=TrialOrder;
			Break[];
		];,{TrialOrder,0,$MaxSeriesTerms}];
Expr];
