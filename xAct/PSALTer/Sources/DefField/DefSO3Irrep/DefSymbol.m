(*=============*)
(*  DefSymbol  *)
(*=============*)

Options@DefSymbol={
	Spin->0,	
	Parity->Even,
	Duplicate->1};

DefSymbol[TensorSymbol_,OptionsPattern[]]:=Module[{
	ParitySymbols=<|Even->"+",Odd->"-"|>,
	ParitySymbol,
	SpinSymbol,
	IrrepSymbol,
	FullSymbol},

	ParitySymbol=ParitySymbols@(OptionValue@Parity);
	SpinSymbol=ToString@(OptionValue@Spin);
	FullSymbol="\!\(\*SubsuperscriptBox["<>TensorSymbol<>",SuperscriptBox[\("<>SpinSymbol<>"\), \("<>ParitySymbol<>"\)],\(#"<>ToString@OptionValue@Duplicate<>"\)]\)";
FullSymbol];
