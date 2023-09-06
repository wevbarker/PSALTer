(*==================*)
(*  SimplifyMasses  *)
(*==================*)

Options@SimplifyMasses={
	Method->"Careful"};
SimplifyMasses[InputRoot_,Couplings_,OptionsPattern[]]:=Module[{
	CouplingAssumptions,
	RootValue=InputRoot},

	CouplingAssumptions=(#~Element~Reals)&/@Couplings;
	RootValue=Assuming[CouplingAssumptions,Simplify@RootValue];

	Switch[OptionValue@Method,
		"Careful",
		(
		RootValue//=FullSimplify;
		),
		"Careless",
		(
		Null;
		)
	];
RootValue];
