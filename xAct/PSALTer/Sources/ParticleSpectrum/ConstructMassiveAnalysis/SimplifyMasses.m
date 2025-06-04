(*==================*)
(*  SimplifyMasses  *)
(*==================*)

SimplifyMasses[InputRoot_,Couplings_,OptionsPattern[]]~Y~Module[{
	CouplingAssumptions,
	RootValue=InputRoot},

	CouplingAssumptions=(#~Element~Reals)&/@Couplings;
	RootValue=Assuming[CouplingAssumptions,Simplify@RootValue];
	RootValue//=FullSimplify;
RootValue];
