(*=========================*)
(*  ConstructWaveOperator  *)
(*=========================*)

IncludeHeader@"FourierLagrangian";
IncludeHeader@"ConstructOperator";

ConstructWaveOperator[ClassName_?StringQ,Expr_]:=Module[{
	Couplings,
	Class,
	TheTensors
	},

	$LocalWaveOperator=" ** ConstructWaveOperator...";	
	Class=Evaluate@Symbol@ClassName;
	TheTensors=Class@Tensors;
	Couplings=Class@LagrangianCouplings;
	DecomposeFieldsdLagrangian=FourierLagrangian[ClassName,Expr,TheTensors];
	Diagnostic@DecomposeFieldsdLagrangian;
	ConstructOperator[ClassName,DecomposeFieldsdLagrangian,Couplings];
];
