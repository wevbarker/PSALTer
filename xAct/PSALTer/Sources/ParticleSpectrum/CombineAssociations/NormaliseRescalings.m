(*=======================*)
(*  NormaliseRescalings  *)
(*=======================*)

NormaliseRescalings[TheoryContext_]:=Module[{
	Class,
	Expr,
	SystemOfEquations,
	SolutionsToEquations,
	OriginalTerms,
	InvariantMatrixValue
	},

	Class=FieldAssociation@TheoryContext;
	InvariantMatrixValue=Class@InvariantMatrix;	
	Expr=Total@((Tr@InvariantMatrixValue[Spin])~Table~{Spin,Class@Spins});
	Diagnostic@Expr;
	OriginalTerms=((Evaluate@Dagger@FromIndexFree@ToIndexFree@#)*((FromIndexFree@ToIndexFree@#)/.{SomeIndex_?TangentM4`Q->-SomeIndex}))&/@Class@Tensors;
	Diagnostic@OriginalTerms;
	Expr-=Total@OriginalTerms;
	Diagnostic@Expr;
	Expr=Expr/.Class@SpinParityRescalingRules;
	Diagnostic@Expr;
	Expr=Expr/.{(RescalingSymbol_?ConstantSymbolQ)^2->RescalingSymbol};
	Diagnostic@Expr;
	Expr//=Class@ExpandFields;
	Diagnostic@Expr;
	SystemOfEquations=Expr==0//ToConstantSymbolEquations;
	Diagnostic@SystemOfEquations;
	SolutionsToEquations=Solve@SystemOfEquations;
	RescalingSolutionsValue=SolutionsToEquations[[1]];
	Diagnostic@RescalingSolutionsValue;
	RescalingSolutionsValue=RescalingSolutionsValue/.{(RescalingSymbol_?ConstantSymbolQ->NumericSolution_?NumericQ)->(RescalingSymbol->Evaluate@Sqrt@NumericSolution)};
	Diagnostic@RescalingSolutionsValue;
	AppendToField[TheoryContext,RescalingSolutions,RescalingSolutionsValue];
];
