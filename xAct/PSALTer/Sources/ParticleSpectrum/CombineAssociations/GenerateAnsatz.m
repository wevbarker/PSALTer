(*==================*)
(*  GenerateAnsatz  *) 
(*==================*)

IncludeHeader@"CatalogueInvariant";

GenerateAnsatz[TheoryContext_]~Y~Catch@Module[{
	Class,
	EvenEven,
	SourceEvenEven,
	EvenEvenMask,
	EvenEvenAntiMask,
	EvenOdd,
	SourceEvenOdd,
	EvenOddMask,
	EvenOddAntiMask,
	OddEven,
	SourceOddEven,
	OddEvenMask,
	OddEvenAntiMask,
	OddOdd,
	SourceOddOdd,
	OddOddMask,
	OddOddAntiMask,
	SpinParityConstantSymbols,
	SpinParityRescalingSymbols,
	SpinParityRescalingRulesValue,
	FieldSpinParityTensorHeadsValue,
	SourceSpinParityTensorHeadsValue,
	InverseRescalingMatrixValue,
	RescalingMatrixValue,
	InvariantMatrixValue,
	SourceInvariantMatrixValue,
	MaskMatrixValue,
	MixedMaskMatrixValue,
	QFactor,
	AntiMaskMatrixValue
	},

	Class=FieldAssociation@TheoryContext;
	FieldSpinParityTensorHeadsValue=Class@FieldSpinParityTensorHeads;
	SourceSpinParityTensorHeadsValue=Class@SourceSpinParityTensorHeads;

	QFactor=<|0->I/Sqrt[6],1->I/Sqrt[2],2->I/Sqrt[2],3->0|>;

	RescalingMatrixValue=<||>;
	InverseRescalingMatrixValue=<||>;
	InvariantMatrixValue=<||>;
	SourceInvariantMatrixValue=<||>;
	MaskMatrixValue=<||>;
	MixedMaskMatrixValue=<||>;
	AntiMaskMatrixValue=<||>;

	Block[{Print},
	Unprotect@Print;
	Print[Expr_]~Y~NoPrint[Expr];
	Off[ValidateSymbol::used];
	SpinParityConstantSymbols=Map[(DefConstantSymbol[ToExpression@((ToString@#)<>"ConstantSymbol"),Dagger->Complex];ToExpression@((ToString@#)<>"ConstantSymbol"))&,FieldSpinParityTensorHeadsValue,{4}];
	On[ValidateSymbol::used];

	Off[ValidateSymbol::used];
	SpinParityRescalingSymbols=Map[(DefConstantSymbol[ToExpression@((ToString@#)<>"RescalingSymbol"),Dagger->Complex];ToExpression@((ToString@#)<>"RescalingSymbol"))&,FieldSpinParityTensorHeadsValue,{4}];
	On[ValidateSymbol::used];

	Protect@Print;
	];

	SpinParityRescalingRulesValue=Flatten@MapThread[
			{#1[AnyIndices___]->#2*#1[AnyIndices]}&,
			{
				(#~Join~(Dagger/@#))&@Flatten@Map[Values,FieldSpinParityTensorHeadsValue,{0,2}],
				(#~Join~#)&@Flatten@Map[Values,SpinParityRescalingSymbols,{0,2}]
			}
		];

	AppendToField[TheoryContext,SpinParityRescalingRules,SpinParityRescalingRulesValue];
	AppendToField[TheoryContext,InvariantToConstantRules,{}];

	(

	EvenEven=Outer[CatalogueInvariant[
			TheoryContext,
			Dagger@(#1[[1]]),
			Dagger@(#1[[2]]),
			#2[[1]],
			#2[[2]],Mixed->False]&,
	{#1,#2}&~MapThread~{
		Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors},
		Join@@SpinParityConstantSymbols[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors}
	},
	{#1,#2}&~MapThread~{
		Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors},
		Join@@SpinParityConstantSymbols[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors}
	},
	1];
	EvenEven//=DeleteCases[#,{}]&;
	Diagnostic@EvenEven;

	SourceEvenEven=Outer[CatalogueInvariant[
			TheoryContext,
			Dagger@(#1[[1]]),
			Dagger@(#1[[2]]),
			#2[[1]],
			#2[[2]],Mixed->False]&,
	{#1,#2}&~MapThread~{
		Join@@SourceSpinParityTensorHeadsValue[Source][Spin][Even]~Table~{Source,Class@Sources},
		Join@@SpinParityConstantSymbols[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors}
	},
	{#1,#2}&~MapThread~{
		Join@@SourceSpinParityTensorHeadsValue[Source][Spin][Even]~Table~{Source,Class@Sources},
		Join@@SpinParityConstantSymbols[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors}
	},
	1];
	SourceEvenEven//=DeleteCases[#,{}]&;
	Diagnostic@SourceEvenEven;

	EvenEvenMask=Outer[(0)&,	
	Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors},	
	Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors}];
	EvenEvenMask//=DeleteCases[#,{}]&;

	EvenEvenAntiMask=Outer[(1)&,	
	Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors},	
	Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors}];
	EvenEvenAntiMask//=DeleteCases[#,{}]&;

	EvenOdd=Outer[CatalogueInvariant[
			TheoryContext,
			Dagger@(#1[[1]]),
			Dagger@(#1[[2]]),
			#2[[1]],
			#2[[2]],Mixed->True]&,
	{#1,#2}&~MapThread~{
		Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors},
		Join@@SpinParityConstantSymbols[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors}
	},
	{#1,#2}&~MapThread~{
		Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors},
		Join@@SpinParityConstantSymbols[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors}
	},
	1];
	EvenOdd//=DeleteCases[#,{}]&;
	Diagnostic@EvenOdd;

	SourceEvenOdd=Outer[CatalogueInvariant[
			TheoryContext,
			Dagger@(#1[[1]]),
			Dagger@(#1[[2]]),
			#2[[1]],
			#2[[2]],Mixed->True]&,
	{#1,#2}&~MapThread~{
		Join@@SourceSpinParityTensorHeadsValue[Source][Spin][Even]~Table~{Source,Class@Sources},
		Join@@SpinParityConstantSymbols[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors}
	},
	{#1,#2}&~MapThread~{
		Join@@SourceSpinParityTensorHeadsValue[Source][Spin][Odd]~Table~{Source,Class@Sources},
		Join@@SpinParityConstantSymbols[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors}
	},
	1];
	SourceEvenOdd//=DeleteCases[#,{}]&;
	Diagnostic@SourceEvenOdd;

	EvenOddMask=Outer[(1)&,	
	Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors},	
	Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors}];
	EvenOddMask//=DeleteCases[#,{}]&;

	EvenOddAntiMask=Outer[(0)&,	
	Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors},	
	Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors}];
	EvenOddAntiMask//=DeleteCases[#,{}]&;

	OddEven=Outer[CatalogueInvariant[
			TheoryContext,
			Dagger@(#1[[1]]),
			Dagger@(#1[[2]]),
			#2[[1]],
			#2[[2]],Mixed->True]&,
	{#1,#2}&~MapThread~{
		Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors},
		Join@@SpinParityConstantSymbols[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors}
	},
	{#1,#2}&~MapThread~{
		Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors},
		Join@@SpinParityConstantSymbols[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors}
	},
	1];
	OddEven//=DeleteCases[#,{}]&;
	Diagnostic@OddEven;

	SourceOddEven=Outer[CatalogueInvariant[
			TheoryContext,
			Dagger@(#1[[1]]),
			Dagger@(#1[[2]]),
			#2[[1]],
			#2[[2]],Mixed->True]&,
	{#1,#2}&~MapThread~{
		Join@@SourceSpinParityTensorHeadsValue[Source][Spin][Odd]~Table~{Source,Class@Sources},
		Join@@SpinParityConstantSymbols[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors}
	},
	{#1,#2}&~MapThread~{
		Join@@SourceSpinParityTensorHeadsValue[Source][Spin][Even]~Table~{Source,Class@Sources},
		Join@@SpinParityConstantSymbols[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors}
	},
	1];
	SourceOddEven//=DeleteCases[#,{}]&;
	Diagnostic@SourceOddEven;

	OddEvenMask=Outer[(1)&,	
	Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors},	
	Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors}];
	OddEvenMask//=DeleteCases[#,{}]&;

	OddEvenAntiMask=Outer[(0)&,	
	Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors},	
	Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors}];
	OddEvenAntiMask//=DeleteCases[#,{}]&;

	OddOdd=Outer[CatalogueInvariant[
			TheoryContext,
			Dagger@(#1[[1]]),
			Dagger@(#1[[2]]),
			#2[[1]],
			#2[[2]],Mixed->False]&,
	{#1,#2}&~MapThread~{
		Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors},
		Join@@SpinParityConstantSymbols[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors}
	},
	{#1,#2}&~MapThread~{
		Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors},
		Join@@SpinParityConstantSymbols[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors}
	},
	1];
	OddOdd//=DeleteCases[#,{}]&;
	Diagnostic@OddOdd;

	SourceOddOdd=Outer[CatalogueInvariant[
			TheoryContext,
			Dagger@(#1[[1]]),
			Dagger@(#1[[2]]),
			#2[[1]],
			#2[[2]],Mixed->False]&,
	{#1,#2}&~MapThread~{
		Join@@SourceSpinParityTensorHeadsValue[Source][Spin][Odd]~Table~{Source,Class@Sources},
		Join@@SpinParityConstantSymbols[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors}
	},
	{#1,#2}&~MapThread~{
		Join@@SourceSpinParityTensorHeadsValue[Source][Spin][Odd]~Table~{Source,Class@Sources},
		Join@@SpinParityConstantSymbols[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors}
	},
	1];
	SourceOddOdd//=DeleteCases[#,{}]&;
	Diagnostic@SourceOddOdd;

	OddOddMask=Outer[(0)&,	
	Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors},	
	Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors}];
	OddOddMask//=DeleteCases[#,{}]&;

	OddOddAntiMask=Outer[(1)&,	
	Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors},	
	Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors}];
	OddOddAntiMask//=DeleteCases[#,{}]&;
	
	If[Length@DeleteCases[{EvenEven,EvenOdd,OddEven,OddOdd},{}]===1,
		If[Dimensions@DeleteCases[{EvenEven,EvenOdd,OddEven,OddOdd},{}]==={1,1,1},
			InvariantMatrixValue[Spin]=ArrayFlatten@DeleteCases[{EvenEven,EvenOdd,OddEven,OddOdd},{}];
			Diagnostic@MatrixForm@InvariantMatrixValue[Spin];
			SourceInvariantMatrixValue[Spin]=ArrayFlatten@DeleteCases[{SourceEvenEven,SourceEvenOdd,SourceOddEven,SourceOddOdd},{}];
			Diagnostic@MatrixForm@SourceInvariantMatrixValue[Spin];

			MaskMatrixValue[Spin]=Flatten@DeleteCases[{EvenEvenAntiMask,EvenOddAntiMask,OddEvenAntiMask,OddOddAntiMask},{}];
			Diagnostic@MatrixForm@MaskMatrixValue[Spin];

			AntiMaskMatrixValue[Spin]=<||>;
			AntiMaskMatrixValue[Spin][Even]=Flatten@DeleteCases[{EvenEvenAntiMask,EvenOddAntiMask,OddEvenAntiMask,OddOddMask},{}];
			AntiMaskMatrixValue[Spin][Odd]=Flatten@DeleteCases[{EvenEvenMask,EvenOddAntiMask,OddEvenAntiMask,OddOddAntiMask},{}];
			Diagnostic@MatrixForm@AntiMaskMatrixValue[Spin];
		,
			InvariantMatrixValue[Spin]=First@ArrayFlatten@DeleteCases[{EvenEven,EvenOdd,OddEven,OddOdd},{}];
			Diagnostic@MatrixForm@InvariantMatrixValue[Spin];
			SourceInvariantMatrixValue[Spin]=First@ArrayFlatten@DeleteCases[{SourceEvenEven,SourceEvenOdd,SourceOddEven,SourceOddOdd},{}];
			Diagnostic@MatrixForm@SourceInvariantMatrixValue[Spin];

			MaskMatrixValue[Spin]=First@DeleteCases[{EvenEvenAntiMask,EvenOddAntiMask,OddEvenAntiMask,OddOddAntiMask},{}];
			Diagnostic@MatrixForm@MaskMatrixValue[Spin];

			AntiMaskMatrixValue[Spin]=<||>;
			AntiMaskMatrixValue[Spin][Even]=First@DeleteCases[{EvenEvenAntiMask,EvenOddAntiMask,OddEvenAntiMask,OddOddMask},{}];
			AntiMaskMatrixValue[Spin][Odd]=First@DeleteCases[{EvenEvenMask,EvenOddAntiMask,OddEvenAntiMask,OddOddAntiMask},{}];
			Diagnostic@MatrixForm@AntiMaskMatrixValue[Spin];
		];

		,
	
		InvariantMatrixValue[Spin]=ArrayFlatten@{{EvenEven,EvenOdd},{OddEven,OddOdd}};
		Diagnostic@MatrixForm@InvariantMatrixValue[Spin];
		SourceInvariantMatrixValue[Spin]=ArrayFlatten@{{SourceEvenEven,SourceEvenOdd},{SourceOddEven,SourceOddOdd}};
		Diagnostic@MatrixForm@SourceInvariantMatrixValue[Spin];

		MaskMatrixValue[Spin]=ArrayFlatten@{{EvenEvenAntiMask,EvenOddAntiMask},{OddEvenAntiMask,OddOddAntiMask}};
		Diagnostic@MatrixForm@MaskMatrixValue[Spin];

		AntiMaskMatrixValue[Spin]=<||>;
		AntiMaskMatrixValue[Spin][Even]=ArrayFlatten@{{EvenEvenAntiMask,EvenOddAntiMask},{OddEvenAntiMask,OddOddMask}};
		AntiMaskMatrixValue[Spin][Odd]=ArrayFlatten@{{EvenEvenMask,EvenOddAntiMask},{OddEvenAntiMask,OddOddAntiMask}};
		Diagnostic@MatrixForm@AntiMaskMatrixValue[Spin];
	];

	MixedMaskMatrixValue[Spin]=MaskMatrixValue[Spin]/.{1->1,0->QFactor@Spin};


	RescalingMatrixValue[Spin]=TensorProduct[#,#]&@Flatten@Join[
		SpinParityRescalingSymbols[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors},
		SpinParityRescalingSymbols[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors}
	];

	RescalingMatrixValue[Spin]=MapThread[(#1*#2)&,{RescalingMatrixValue[Spin],MixedMaskMatrixValue[Spin]}];

	InverseRescalingMatrixValue[Spin]=TensorProduct[1/#,1/#]&@Flatten@Join[
		SpinParityRescalingSymbols[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors},
		SpinParityRescalingSymbols[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors}
	];

	InverseRescalingMatrixValue[Spin]=MapThread[(#1/#2)&,{InverseRescalingMatrixValue[Spin],MixedMaskMatrixValue[Spin]}];

	)~Table~{Spin,Class@Spins};

	AppendToField[TheoryContext,InvariantMatrix,InvariantMatrixValue];
	AppendToField[TheoryContext,SourceInvariantMatrix,SourceInvariantMatrixValue];
	AppendToField[TheoryContext,MaskMatrix,MaskMatrixValue];
	AppendToField[TheoryContext,AntiMaskMatrix,AntiMaskMatrixValue];
	AppendToField[TheoryContext,RescalingMatrix,RescalingMatrixValue];
	AppendToField[TheoryContext,InverseRescalingMatrix,InverseRescalingMatrixValue];
];
