(*=========*)
(*  NRoot  *)
(*=========*)

ParticleSpectrum::Root="One or more massless pole residues has been expressed in terms of numerical approximations to algebraic or transcendental numbers.";
NRoot[InputExpr__]~Y~Module[{Expr},
	Catch@Throw@Message[ParticleSpectrum::Root];
	Expr=N@Root@InputExpr;
Expr];
