(*===============*)
(*  ExtractPart  *)
(*===============*)

ExtractPart[InputMatrix_,InputDenominator_,OrderInteger_]:=Module[{
	NSeriesMapped,
	Expr,
	PerturbationRules,
	PerturbationParameter,
	AllCouplings
	},

	AllCouplings=Variables@InputDenominator;
	PerturbationRules=(#->PerturbationParameter*#)&/@AllCouplings;
	If[OrderInteger==Infinity,
		MyNSeriesMapped[InputExpr_]:=InputExpr;
	,
		MyNSeriesMapped[InputExpr_]:=Normal@Series[InputExpr/.PerturbationRules,
			{PerturbationParameter,0,OrderInteger}]/.{PerturbationParameter->1};
	];
	Expr=Map[MyNSeriesMapped,InputMatrix,{2}];

	Expr//=Eigenvalues;
	Expr//=DeleteCases[#,0,Infinity]&;
	Expr/=InputDenominator;
Expr];
