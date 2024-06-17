(*==========================*)
(*  CarefullyOrthogonalise  *)
(*==========================*)

CarefullyOrthogonalise[InputNullSpace_]:=Module[{
	Expr=InputNullSpace,
	ParameterisedNullVectors,
	NonParameterisedNullVectors
	},
	
	If[(ParameterisedNullVectorQ/@Expr)~MemberQ~True,
		$LocalPropagator=" ** SplitBy...";
		{ParameterisedNullVectors,NonParameterisedNullVectors}=Expr~SplitBy~ParameterisedNullVectorQ;
		$LocalPropagator=" ** Orthogonalize...";
		Assuming[xAct`PSALTer`Def>0,
			NonParameterisedNullVectors=FullSimplify@Orthogonalize@NonParameterisedNullVectors];
		Expr=ParameterisedNullVectors~Join~NonParameterisedNullVectors;
	,
		$LocalPropagator=" ** Orthogonalize...";
		Assuming[xAct`PSALTer`Def>0,
			Expr=FullSimplify@Orthogonalize@Expr];
	];
Expr];
