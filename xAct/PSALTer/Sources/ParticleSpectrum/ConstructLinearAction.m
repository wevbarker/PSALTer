(*=========================*)
(*  ConstructLinearAction  *)
(*=========================*)

ConstructLinearAction[ClassName_?StringQ,Expr_]:=Module[{
	Class,
	NewExpr,
	TheTensors,
	TensorList,
	SourceCoupling
	},

	$LocalSummaryOfTheory=" ** ConstructLinearAction...";
	
	Class=Evaluate@Symbol@ClassName;
	NewExpr=Expr/.(Class@FieldToFiducialField);
	TheTensors=Class@Tensors;
	Diagnostic@TheTensors;
	TensorList=(FromIndexFree@ToIndexFree@#)&/@(TheTensors);

	Diagnostic@TensorList;
	SourceCoupling=MapThread[((#1@@(-List@@#2))*#2)&,{Class@Sources,TensorList}];
	Diagnostic@SourceCoupling;
	SourceCoupling//=Total;
	Diagnostic@SourceCoupling;
	SourceCoupling//=ToNewCanonical;
	SourceCoupling//=Expand;
	Diagnostic@SourceCoupling;
	$LocalSummaryOfTheory={NewExpr,SourceCoupling};
	Diagnostic@$LocalSummaryOfTheory;
];
