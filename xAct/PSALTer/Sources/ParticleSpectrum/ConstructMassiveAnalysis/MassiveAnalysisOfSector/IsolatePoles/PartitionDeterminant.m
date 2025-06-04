(*========================*)
(*  PartitionDeterminant  *)
(*========================*)

IncludeHeader@"GaugeArtifactQ";

PartitionDeterminant[Poly_,RationalRoots_]~Y~Module[{Expr=Poly},
	Expr/=Times@@((DefSquared-#)&/@RationalRoots);
	Expr//=(#/.{DefSquared->Def^2})&;
	Expr//=FullSimplify;
	If[Head@Expr===Times,
		Expr//=List@@#&;
		Expr//=(#~DeleteCases~(_?SquareMassQ))&;
		Expr//=(#~DeleteCases~(_?GaugeArtifactQ))&;
		Expr//=Times@@#&;
		Expr//=FullSimplify;
	];
Expr];
