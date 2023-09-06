(*==================*)
(*  GenerateAnsatz  *)
(*==================*)

BuildPackage@"DefClass/CatalogueInvariant.m";

GenerateAnsatz[ClassName_?StringQ]:=Catch@Module[{
	Class,
	EvenEven,
	EvenEvenMask,
	EvenEvenAntiMask,
	EvenOdd,
	EvenOddMask,
	EvenOddAntiMask,
	OddEven,
	OddEvenMask,
	OddEvenAntiMask,
	OddOdd,
	OddOddMask,
	OddOddAntiMask,
	SpinParityConstantSymbols,
	SpinParityRescalingSymbols,
	SpinParityRescalingRulesValue,
	FieldSpinParityTensorHeadsValue,
	InverseRescalingMatrixValue,
	RescalingMatrixValue,
	InvariantMatrixValue,
	MaskMatrixValue,
	AntiMaskMatrixValue
	},

	Class=Evaluate@Symbol@ClassName;
	FieldSpinParityTensorHeadsValue=Class@FieldSpinParityTensorHeads;

	RescalingMatrixValue=<||>;
	InverseRescalingMatrixValue=<||>;
	InvariantMatrixValue=<||>;
	MaskMatrixValue=<||>;
	AntiMaskMatrixValue=<||>;

	Block[{Print},
	Unprotect@Print;
	Print[Expr_]:=NoPrint[Expr];
	SpinParityConstantSymbols=Map[(DefConstantSymbol[ToExpression@((ToString@#)<>"ConstantSymbol"),Dagger->Complex];ToExpression@((ToString@#)<>"ConstantSymbol"))&,FieldSpinParityTensorHeadsValue,{4}];

	SpinParityRescalingSymbols=Map[(DefConstantSymbol[ToExpression@((ToString@#)<>"RescalingSymbol"),Dagger->Complex];ToExpression@((ToString@#)<>"RescalingSymbol"))&,FieldSpinParityTensorHeadsValue,{4}];

	Protect@Print;
	];

	SpinParityRescalingRulesValue=Flatten@MapThread[
			{#1[AnyIndices___]->#2*#1[AnyIndices]}&,
			{
				(#~Join~(Dagger/@#))&@Flatten@Map[Values,FieldSpinParityTensorHeadsValue,{0,2}],
				(#~Join~#)&@Flatten@Map[Values,SpinParityRescalingSymbols,{0,2}]
			}
		];

	UpdateClassAssociation[ClassName,SpinParityRescalingRules,SpinParityRescalingRulesValue];

	UpdateClassAssociation[ClassName,InvariantToConstantRules,{}];

	(

	EvenEven=Outer[CatalogueInvariant[
			ClassName,
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

	EvenEvenMask=Outer[(0)&,	
	Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors},	
	Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors}];
	EvenEvenMask//=DeleteCases[#,{}]&;

	EvenEvenAntiMask=Outer[(1)&,	
	Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors},	
	Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors}];
	EvenEvenAntiMask//=DeleteCases[#,{}]&;

	EvenOdd=Outer[CatalogueInvariant[
			ClassName,
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

	EvenOddMask=Outer[(1)&,	
	Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors},	
	Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors}];
	EvenOddMask//=DeleteCases[#,{}]&;

	EvenOddAntiMask=Outer[(0)&,	
	Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors},	
	Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors}];
	EvenOddAntiMask//=DeleteCases[#,{}]&;

	OddEven=Outer[CatalogueInvariant[
			ClassName,
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

	OddEvenMask=Outer[(1)&,	
	Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors},	
	Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors}];
	OddEvenMask//=DeleteCases[#,{}]&;

	OddEvenAntiMask=Outer[(0)&,	
	Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors},	
	Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors}];
	OddEvenAntiMask//=DeleteCases[#,{}]&;

	OddOdd=Outer[CatalogueInvariant[
			ClassName,
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

			MaskMatrixValue[Spin]=Flatten@DeleteCases[{EvenEvenAntiMask,EvenOddAntiMask,OddEvenAntiMask,OddOddAntiMask},{}];
			Diagnostic@MatrixForm@MaskMatrixValue[Spin];

			AntiMaskMatrixValue[Spin]=<||>;
			AntiMaskMatrixValue[Spin][Even]=Flatten@DeleteCases[{EvenEvenAntiMask,EvenOddAntiMask,OddEvenAntiMask,OddOddMask},{}];
			AntiMaskMatrixValue[Spin][Odd]=Flatten@DeleteCases[{EvenEvenMask,EvenOddAntiMask,OddEvenAntiMask,OddOddAntiMask},{}];
			Diagnostic@MatrixForm@AntiMaskMatrixValue[Spin];
		,
			InvariantMatrixValue[Spin]=First@ArrayFlatten@DeleteCases[{EvenEven,EvenOdd,OddEven,OddOdd},{}];
			Diagnostic@MatrixForm@InvariantMatrixValue[Spin];

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

		MaskMatrixValue[Spin]=ArrayFlatten@{{EvenEvenAntiMask,EvenOddAntiMask},{OddEvenAntiMask,OddOddAntiMask}};
		Diagnostic@MatrixForm@MaskMatrixValue[Spin];

		AntiMaskMatrixValue[Spin]=<||>;
		AntiMaskMatrixValue[Spin][Even]=ArrayFlatten@{{EvenEvenAntiMask,EvenOddAntiMask},{OddEvenAntiMask,OddOddMask}};
		AntiMaskMatrixValue[Spin][Odd]=ArrayFlatten@{{EvenEvenMask,EvenOddAntiMask},{OddEvenAntiMask,OddOddAntiMask}};
		Diagnostic@MatrixForm@AntiMaskMatrixValue[Spin];
	];


	RescalingMatrixValue[Spin]=TensorProduct[#,#]&@Flatten@Join[
		SpinParityRescalingSymbols[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors},
		SpinParityRescalingSymbols[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors}
	];

	InverseRescalingMatrixValue[Spin]=TensorProduct[1/#,1/#]&@Flatten@Join[
		SpinParityRescalingSymbols[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors},
		SpinParityRescalingSymbols[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors}
	];

	)~Table~{Spin,Class@Spins};

	UpdateClassAssociation[ClassName,InvariantMatrix,InvariantMatrixValue];
	UpdateClassAssociation[ClassName,MaskMatrix,MaskMatrixValue];
	UpdateClassAssociation[ClassName,AntiMaskMatrix,AntiMaskMatrixValue];
	UpdateClassAssociation[ClassName,RescalingMatrix,RescalingMatrixValue];
	UpdateClassAssociation[ClassName,InverseRescalingMatrix,InverseRescalingMatrixValue];
];
