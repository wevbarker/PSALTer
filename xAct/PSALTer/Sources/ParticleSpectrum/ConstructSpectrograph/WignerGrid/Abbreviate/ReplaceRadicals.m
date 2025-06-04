(*===================*)
(*  ReplaceRadicals  *)
(*===================*)

IncludeHeader@"CarefulReplace";

ReplaceRadicals[InputExpr_,InputRules_]~Y~Module[{Expr=InputExpr},
	Expr//=FullSimplify;
	If[Head[Expr]===Times,
		Expr//=List@@#&;
		Expr//=(#~CarefulReplace~InputRules)&/@#&;
		Expr//=Times@@#&;
	,
		Expr//=(#/.InputRules)&;
	];
Expr];
