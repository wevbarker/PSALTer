(*========================*)
(*  AllocateTensorValues  *)
(*========================*)

(*IncludeHeader@"AllocateTensorValues";*)
ApplyAllTensorValues[InputExpr_,FieldContext_]~Y~Module[{Expr=InputExpr,Class},
	Class=FieldAssociation@FieldContext;
	Expr=Expr/.xAct`xCoba`TensorValues[P];
	Expr=Expr/.xAct`xCoba`TensorValues[G];
	Expr=Expr/.xAct`xCoba`TensorValues[epsilonG];
	(Expr=Expr/.xAct`xCoba`TensorValues[#])&/@(Class@Sources);
	(Expr=Expr/.xAct`xCoba`TensorValues[#])&/@(Dagger/@(Class@Sources));
Expr];

AllocateTensorValues[InputExpr_,FieldContext_]~Y~Module[{Expr=InputExpr,ExprInBases,Class},
	Class=FieldAssociation@FieldContext;
	ExprInBases=Expr//FreeToBasis[cartesian];
	Expr=Expr/.FromEps;
	Expr=Expr/.ToP;
	Expr//=Class@ExpandSources;
	Expr//=Expand;
	Expr//=FullyCanonicalise;
	Expr//=xAct`xCoba`SeparateBasis[cartesian];
	Expr//=xAct`xCoba`ContractBasis;
	Expr//=xAct`xCoba`TraceBasisDummy;
	Expr//=ApplyAllTensorValues[#,FieldContext]&;
	Expr//=FreeToBasis[cartesian];
	Expr//=ComponentArray;
	Expr//=Map[ApplyAllTensorValues[#,FieldContext]&,#,{ArrayDepth@#}]&;
	Diagnostic@Expr;
{ExprInBases,Expr}];
