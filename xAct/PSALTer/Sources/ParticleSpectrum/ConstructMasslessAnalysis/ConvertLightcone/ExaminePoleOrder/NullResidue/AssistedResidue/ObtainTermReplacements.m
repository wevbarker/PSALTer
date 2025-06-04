(*==========================*)
(*  ObtainTermReplacements  *)
(*==========================*)

ObtainTermReplacements[SeriesCoefficients_,
		ExprNumerator_,
		ExprDenominator_]~Y~Module[{TermReplacements},
	
		(*TermReplacements=MapThread[(#1->SeriesCoefficient[#2,{Parameter,0,#3}])&,*)
	TermReplacements=MapThread[(#1->Coefficient[#2,Parameter,#3])&,
			{SeriesCoefficients,
			If["a"===(ToString@#~StringTake~1),
				ExprNumerator,ExprDenominator]&/@SeriesCoefficients,
			(ToExpression@(ToString@#~StringDrop~1))&/@SeriesCoefficients}];
TermReplacements];
