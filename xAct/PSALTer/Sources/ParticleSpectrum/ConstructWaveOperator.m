(*=========================*)
(*  ConstructWaveOperator  *)
(*=========================*)

IncludeHeader@"FourierLagrangian";
IncludeHeader@"ConstructOperator";

ConstructWaveOperator[ClassName_?StringQ,Expr_,OmittedSectors_]~Y~Module[{
	Couplings,
	Class,
	TheTensors
	},

	$LocalWaveOperator=" ** ConstructWaveOperator...";	
	Class=Evaluate@Symbol@ClassName;
	TheTensors=Class@Tensors;
	Couplings=Class@LagrangianCouplings;
	DecomposeFieldsdLagrangian=FourierLagrangian[ClassName,Expr,TheTensors,OmittedSectors];
	Diagnostic@DecomposeFieldsdLagrangian;
	ConstructOperator[ClassName,DecomposeFieldsdLagrangian,Couplings,OmittedSectors];
];
