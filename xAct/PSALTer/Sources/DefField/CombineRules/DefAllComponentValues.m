(*=========================*)
(*  DefAllComponentValues  *)
(*=========================*)

DefAllComponentValues[]:=Module[{
	Class,
	TensorsWhoseComponentsWeNeed},

	Class=FieldAssociation@Context[];
	TensorsWhoseComponentsWeNeed=Flatten@Map[Values,Evaluate@(Class@SourceSpinParityTensorHeads),{0,2}];
	TensorsWhoseComponentsWeNeed=(FromIndexFree@ToIndexFree@#)&/@TensorsWhoseComponentsWeNeed;
	TensorsWhoseComponentsWeNeed=DeleteCases[TensorsWhoseComponentsWeNeed,xTensor_[]];
	TensorsWhoseComponentsWeNeed=TensorsWhoseComponentsWeNeed~Join~(TensorsWhoseComponentsWeNeed/.{-SomeIndex_->SomeIndex});

	TensorsWhoseComponentsWeNeed=TensorsWhoseComponentsWeNeed~Join~
		(#~Join~((Evaluate@Dagger@#)&/@#))&@(
			(#~Join~(#/.{SomeIndex_?TangentM4`Q->-SomeIndex}))&@(
				DeleteCases[
					(FromIndexFree@ToIndexFree@#)&/@Class@Sources,
				xTensor_[]]
			)
		);

	Block[{Print},
		Unprotect@Print;
		Print[Expr_]:=NoPrint[Expr];
		(AllComponentValues@FreeToBasis[xAct`PSALTer`cartesian]@#;)&/@TensorsWhoseComponentsWeNeed;
		Protect@Print;
	];
];
