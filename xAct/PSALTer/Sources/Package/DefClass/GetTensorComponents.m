(*=======================*)
(*  GetTensorComponents  *)
(*=======================*)

GetTensorComponents[ClassName_?StringQ]:=Module[{
	Class,
	TensorsWhoseComponentsWeNeed,
	PrintVariable},

	Print[" ** DefClass: pre-computing tensor components..."];

	Class=Evaluate@Symbol@ClassName;

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


			(*Block[{xAct`xCoba`Private`storeact,xAct`xCoba`Private`addrule},*)
	Block[{Print},

		Unprotect@Print;
		Print[Expr_]:=NoPrint[Expr];
		(*
		xAct`xCoba`Private`storeact[flist_,rule_,tensor_,First]:=(If[$CVVerbose,NotebookDelete@PrintVariable;PrintVariable=PrintTemporary["Added dependent rule ",rule," for tensor ",tensor]];Append[flist,rule]);
		xAct`xCoba`Private`storeact[flist_,rule:Rule[_,Null|-Null],tensor_,Last]:=droprule[flist,rule,tensor];
		xAct`xCoba`Private`storeact[flist_,rule_,tensor_,Last]:=xAct`xCoba`Private`addrule[flist,rule,tensor];

		xAct`xCoba`Private`addrule[{rules1___,_[x1_,x1_],rules2___},rule:_[x1_,_],tensor_]:=(
		If[$CVVerbose,NotebookDelete@PrintVariable;PrintVariable=PrintTemporary["Added independent value ",rule," for tensor ",tensor]];
		{rules1,rule,rules2});

		xAct`xCoba`Private`addrule[{rules___},rule_,tensor_]:=(
		If[$CVVerbose,NotebookDelete@PrintVariable;PrintVariable=PrintTemporary["Added independent rule ",rule," for tensor ",tensor]];
		{rules,rule});
		*)
		(AllComponentValues@FreeToBasis[xAct`PSALTer`cartesian]@#;)&/@TensorsWhoseComponentsWeNeed;

		Protect@Print;
	];
];
