(*==========================*)
(*  DefFreeSourceVariables  *)
(*==========================*)

DefFreeSourceVariables[Num_]:=Module[{},
	
	$LocalMasslessSpectrum=" ** DefFreeSourceVariables...";
	Begin["xAct`PSALTer`Private`"];
		Quiet@DefConstantSymbol[
			Symbol["X"<>ToString@#],
			PrintAs->"\!\(\*SubscriptBox[\(\[ScriptCapitalX]\), \("
				<>ColorString[ToString@#,RGBColor[1.,0.,1.]]<>"\)]\)",
			Dagger->Complex
		]&/@Table[i,{i,Num}];
	End[];
];
