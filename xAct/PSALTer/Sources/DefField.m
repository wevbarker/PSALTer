(*============*)
(*  DefField  *)
(*============*)

IncludeHeader@"AppendToField";
IncludeHeader@"DefFiducialField";
IncludeHeader@"DefSO3Irrep";
IncludeHeader@"CombineRules";
IncludeHeader@"SummariseField";
ReadAtRuntime@"RegisterFieldRank0";
ReadAtRuntime@"RegisterFieldRank1";
ReadAtRuntime@"RegisterFieldRank2";
ReadAtRuntime@"RegisterFieldRank2Antisymmetric";
ReadAtRuntime@"RegisterFieldRank2Symmetric";
ReadAtRuntime@"RegisterFieldRank3";
ReadAtRuntime@"RegisterFieldRank3Antisymmetric12";
ReadAtRuntime@"RegisterFieldRank3Antisymmetric13";
ReadAtRuntime@"RegisterFieldRank3Antisymmetric23";
ReadAtRuntime@"RegisterFieldRank3TotallyAntisymmetric";
ReadAtRuntime@"RegisterFieldRank3Symmetric12";
ReadAtRuntime@"RegisterFieldRank3Symmetric13";
ReadAtRuntime@"RegisterFieldRank3Symmetric23";
ReadAtRuntime@"RegisterFieldRank3TotallySymmetric";

Off[Set::write];
Off[SetDelayed::write];

Options@DefFieldActual={PrintAs->"\[Zeta]",PrintSourceAs->"\[ScriptJ]"};

DefField::UnstudiedKinetics="The SO(3) decomposition of tensors with indices `1` and symmetry `2` has not yet been implemented.";
DefFieldActual[InputField_[Inds___],Opts___?OptionQ]:=Catch@DefFieldActual[InputField[Inds],GenSet[],Opts];
DefFieldActual[InputField_[Inds___],SymmExpr_,OptionsPattern[]]:=Catch@Module[{
	Rank=Length@{Inds},
	Type=Head@SymmExpr,
	Pair,
	FieldContext="xAct`PSALTer`"<>ToString@InputField<>"`"
	},

	If[Type==GenSet,Pair={},
		Pair=First/@(First/@(Position[{Inds},#]&/@(Identity@@SymmExpr))),
		Pair=First/@(First/@(Position[{Inds},#]&/@(Identity@@SymmExpr)))];
	DefTensor[InputField@Inds,
		M4,SymmExpr,PrintAs->OptionValue@PrintAs];
	DefTensor[(ToExpression@("Source"<>ToString@InputField))@Inds,
		M4,SymmExpr,PrintAs->OptionValue@PrintSourceAs];
	PrintAsValue=OptionValue@PrintAs;
	PrintSourceAsValue=OptionValue@PrintSourceAs;

	Begin[FieldContext];
	Which[
		(Rank===0),
		RegisterFieldRank0[],
		(Rank===1),
		RegisterFieldRank1[],
		(Rank===2)&&(Type===GenSet),
		RegisterFieldRank2[],
		(Rank===2)&&(Type===Antisymmetric),
		RegisterFieldRank2Antisymmetric[],
		(Rank===2)&&(Type===Symmetric),
		RegisterFieldRank2Symmetric[],
		(Rank===3)&&(Type===GenSet),
		RegisterFieldRank3[],
		(Rank===3)&&(Type===Antisymmetric)&&((Pair==={1,2})||(Pair==={2,1})),
		RegisterFieldRank3Antisymmetric12[],
		(Rank===3)&&(Type===Antisymmetric)&&((Pair==={1,3})||(Pair==={3,1})),
		RegisterFieldRank3Antisymmetric13[],
		(Rank===3)&&(Type===Antisymmetric)&&((Pair==={2,3})||(Pair==={3,2})),
		RegisterFieldRank3Antisymmetric23[],
		(Rank===3)&&(Type===Antisymmetric)&&((Pair==={1,2,3})||(Pair==={1,3,2})||(Pair==={2,1,3})||(Pair==={3,1,2})||(Pair==={2,3,1})||(Pair==={3,2,1})),
		RegisterFieldRank3TotallyAntisymmetric[],
		(Rank===3)&&(Type===Symmetric)&&((Pair==={1,2})||(Pair==={2,1})),
		RegisterFieldRank3Symmetric12[],
		(Rank===3)&&(Type===Symmetric)&&((Pair==={1,3})||(Pair==={3,1})),
		RegisterFieldRank3Symmetric13[],
		(Rank===3)&&(Type===Symmetric)&&((Pair==={2,3})||(Pair==={3,2})),
		RegisterFieldRank3Symmetric23[],
		(Rank===3)&&(Type===Symmetric)&&((Pair==={1,2,3})||(Pair==={1,3,2})||(Pair==={2,1,3})||(Pair==={3,1,2})||(Pair==={2,3,1})||(Pair==={3,2,1})),
		RegisterFieldRank3TotallySymmetric[],
		True,
		Throw@Message[DefField::UnstudiedKinetics,{Inds},SymmExpr]
	];
	SummariseField[];
	End[];
];
On[Set::write];
On[SetDelayed::write];

Unprotect@DefField;
Options@DefField={PrintAs->"\[Zeta]",PrintSourceAs->"\[ScriptJ]"};
DefField[InputField_[Inds___],Opts___?OptionQ]:=DefField[InputField[Inds],GenSet[],Opts];
DefField[InputField_[Inds___],SymmExpr_,Opts:OptionsPattern[]]:=If[False,
	DefTensor[InputField[Inds],M4,SymmExpr,PrintAs->OptionValue@PrintAs],
	DefFieldActual[InputField[Inds],SymmExpr,Opts]
];
Protect@DefField;
