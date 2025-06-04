(*========================*)
(*  SourceConstraintRows  *)
(*========================*)

SourceConstraintRows[]~Y~{};
SourceConstraintRows[
	SpinParitySourceConstraints_,
	CovariantSourceConstraints_,
	Multiplicities_]~Y~Module[{Expr},
	Expr=Join[
		{{Text@"Source constraint(s)",Text@"# constraint(s)",Text@"Covariant form",SpanFromLeft}},
		MapThread[{#1,#3,#2,SpanFromLeft}&,
			{Text/@SpinParitySourceConstraints,
			Text/@CovariantSourceConstraints,
			Text/@Multiplicities}],
		{{Text@"Total # constraint(s):",Text/@(Total@Multiplicities),Text@"",SpanFromLeft}}
	];
Expr];
