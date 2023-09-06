(*=====================*)
(*  DefSpinParityMode  *)
(*=====================*)

BuildPackage@"DefSpinParityMode/MakeAutomaticallyTraceless.m";
BuildPackage@"DefSpinParityMode/MakeAutomaticallyNotAntisymmetric.m";
BuildPackage@"DefSpinParityMode/MakeUniqueQuadratic.m";

Options@DefSpinParityMode={
	MultiTermSymmetries->{},
	Spin->0,	
	Parity->Even,
	FieldSymbol->"\[Zeta]",
	SourceSymbol->"\[ScriptJ]"
};

DefSpinParityMode[FieldSpinParityName_[Inds___],Opts___?OptionQ]:=DefSpinParityMode[FieldSpinParityName[Inds],GenSet[],Opts];

DefSpinParityMode[FieldSpinParityName_[Inds___],SymmExpr_,OptionsPattern[]]:=Module[{
	Symb,
	FieldSymbolValue,
	SourceSymbolValue,
	SpinValue,
	ParityValue,
	SourceSpinParityName},

	MultiTermSymmetriesOf@FieldSpinParityName^=OptionValue@MultiTermSymmetries;

	FieldSymbolValue=OptionValue@FieldSymbol;
	SourceSymbolValue=OptionValue@SourceSymbol;
	SpinValue=OptionValue@Spin;
	ParityValue=OptionValue@Parity;
	Symb=SymbolBuild[FieldSymbolValue,
			(SpinParityPreffices@(SpinValue))@(ParityValue)
			];
	
	DefTensor[
		FieldSpinParityName[Inds],
		xAct`PSALTer`M4,
		SymmExpr,
		PrintAs->Symb,
		OrthogonalTo->((V@Minus@#)&/@(List@Inds)),
		Dagger->Complex];
	
	MakeAutomaticallyTraceless@FieldSpinParityName;	
	MakeAutomaticallyNotAntisymmetric@FieldSpinParityName;
	MakeUniqueQuadratic@FieldSpinParityName;

	SourceSpinParityName=ToExpression@("ConjugateSource"<>(ToString@FieldSpinParityName));
	MultiTermSymmetriesOf@SourceSpinParityName^=((OptionValue@MultiTermSymmetries)/.{FieldSpinParityName->SourceSpinParityName});

	Symb=SymbolBuild[SourceSymbolValue,
			(SpinParityPreffices@(SpinValue))@(ParityValue)
			];

	DefTensor[
		SourceSpinParityName[Inds],
		xAct`PSALTer`M4,
		SymmExpr,
		PrintAs->Symb,
		OrthogonalTo->(V@Minus@#)&/@(List@Inds),
		Dagger->Complex];
		
	MakeAutomaticallyTraceless@SourceSpinParityName;
	MakeAutomaticallyNotAntisymmetric@SourceSpinParityName;
	MakeUniqueQuadratic@SourceSpinParityName;
];
