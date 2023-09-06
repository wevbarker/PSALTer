(*=================*)
(*  ErrorMessages  *)
(*=================*)

Title@"Testing the error messages";

Supercomment@"We will test the error messages.";

Comment@"Try passing a class that does not exist.";

Expr=HoldForm@ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"Supergravity",
	TheoryName->"MyVeryCoolTheory",	
	Method->"Careless",
	MaxLaurentDepth->3
];
DisplayExpression@Expr;
ReleaseHold@Expr;

Comment@"Try passing a theory name that is not a string.";

Expr=HoldForm@ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"PoincareGaugeTheory",
	TheoryName->NotStringTheory,
	Method->"Careless",
	MaxLaurentDepth->3
];
DisplayExpression@Expr;
ReleaseHold@Expr;

Comment@"Try passing a method that is not implemented.";

Expr=HoldForm@ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"PoincareGaugeTheory",
	TheoryName->"MyVeryCoolTheory",	
	Method->"InfiniteMonkeys",
	MaxLaurentDepth->3
];
DisplayExpression@Expr;
ReleaseHold@Expr;

Comment@"Try passing a maximum Laurent depth that is too great.";

Expr=HoldForm@ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"PoincareGaugeTheory",
	TheoryName->"MyVeryCoolTheory",	
	Method->"Careful",
	MaxLaurentDepth->4
];
DisplayExpression@Expr;
ReleaseHold@Expr;
