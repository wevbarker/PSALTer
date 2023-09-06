(*=================*)
(*  ValidateModes  *)
(*=================*)

BuildPackage@"DefClass/ValidateModes/ValidateTraceless.m";
BuildPackage@"DefClass/ValidateModes/ValidateSpatial.m";
BuildPackage@"DefClass/ValidateModes/ValidateInverseField.m";
BuildPackage@"DefClass/ValidateModes/ValidateSymmetryField.m";
BuildPackage@"DefClass/ValidateModes/ValidateInverseMode.m";
BuildPackage@"DefClass/ValidateModes/ValidateSymmetryMode.m";

ValidateModes[ClassName_?StringQ]:=Catch@Module[{
	Class,
	FieldSpinParityTensorHeadsValue,
	ListOfModes
	},

	Class=Evaluate@Symbol@ClassName;

	DecomposeAndExpandFields[InputExpr_]:=Catch@Module[{
		Fundamental=InputExpr,
		Decomposed,
		Expanded
		},

		Print[" ** DefClass: validating the fundamental field "<>(ToString@InputExpr)<>"..."];
		Fundamental//=ToIndexFree;
		Fundamental//=FromIndexFree;
		Decomposed=Fundamental//(Class@DecomposeFields);
		Expanded=Decomposed//(Class@ExpandFields);

		ValidateInverseField[InputExpr,Expanded,Fundamental];
		ValidateSymmetryField[InputExpr,Decomposed,Fundamental];
	];

	ExpandAndDecomposeFields[InputExpr_]:=Catch@Module[{
		Reduced=InputExpr,
		Decomposed,
		Expanded
		},

		Print[" ** DefClass: validating the reduced-index mode "<>(ToString@InputExpr)<>"..."];
		Reduced//=ToIndexFree;
		Reduced//=FromIndexFree;
		Expanded=Reduced//(Class@ExpandFields);
		Decomposed=Expanded//(Class@DecomposeFields);

		ValidateSpatial[InputExpr,Expanded];
		ValidateTraceless[InputExpr,Expanded];
		ValidateInverseMode[InputExpr,Decomposed,Reduced];
		ValidateSymmetryMode[InputExpr,Expanded,Reduced];
	];

	FieldSpinParityTensorHeadsValue=Class@FieldSpinParityTensorHeads;
	ListOfModes=Flatten/@(Values/@(Values/@FieldSpinParityTensorHeadsValue));

	Off[General::stop];

	(
		DecomposeAndExpandFields@Tensor;
		ExpandAndDecomposeFields/@(ListOfModes@Tensor);
	)~Table~{Tensor,Class@Tensors};

	On[General::stop];
(*
	SourceSpinParityTensorHeadsValue=Class@SourceSpinParityTensorHeads;
	ListOfModes=Flatten/@(Values/@(Values/@SourceSpinParityTensorHeadsValue));

	(
		DecomposeAndExpandFields@Source;
		ExpandAndDecomposeFields/@(ListOfModes@Source);
	)~Table~{Source,Class@Sources};
*)
];
