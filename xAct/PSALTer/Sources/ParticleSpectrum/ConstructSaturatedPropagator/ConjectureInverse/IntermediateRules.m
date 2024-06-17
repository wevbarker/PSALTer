(*=====================*)
(*  IntermediateRules  *)
(*=====================*)

IntermediateRules[FirstIntermediateSymbolsToCouplingConstants_,Couplings_]:=Module[{
	NewIndex,
	FirstIntermediateSymbols,
	FirstIntermediateSymbolsToSecondIntermediateSymbols,
	ReduceFirstIntermediateSymbols,
	SecondIntermediateSymbols,
	SecondIntermediateSymbolsToCouplingConstants,
	ReduceSecondIntermediateSymbols,
	TotalExpr
	},

	$LocalPropagator=" ** IntermediateRules...";
	
	NewIndex=1;
	FirstIntermediateSymbols=First/@FirstIntermediateSymbolsToCouplingConstants;	
	SecondIntermediateSymbolsToCouplingConstants={};
	FirstIntermediateSymbolsToSecondIntermediateSymbols={};
	Table[
		TotalExpr=0;
		Table[
			Module[{Expr},
				Expr=Coefficient[FirstIntermediateSymbol/.FirstIntermediateSymbolsToCouplingConstants,xAct`PSALTer`Def,j];
				If[!(Expr===0),
					SecondIntermediateSymbolsToCouplingConstants=SecondIntermediateSymbolsToCouplingConstants~Join~{Symbol["xAct`PSALTer`Private`l"<>ToString@NewIndex]->Expr};
					TotalExpr+=Symbol["xAct`PSALTer`Private`l"<>ToString@NewIndex]*xAct`PSALTer`Def^j;
					NewIndex+=1;
				];
			];,
		{j,0,8}];
		FirstIntermediateSymbolsToSecondIntermediateSymbols=FirstIntermediateSymbolsToSecondIntermediateSymbols~Join~{FirstIntermediateSymbol->TotalExpr};,
	{FirstIntermediateSymbol,FirstIntermediateSymbols}];

	ReduceFirstIntermediateSymbols=Eliminate[FirstIntermediateSymbolsToCouplingConstants/.{Rule->Equal},Couplings];
	ReduceFirstIntermediateSymbols=First@Quiet@Solve[ReduceFirstIntermediateSymbols,FirstIntermediateSymbols];

	SecondIntermediateSymbols=First/@SecondIntermediateSymbolsToCouplingConstants;
	ReduceSecondIntermediateSymbols=Eliminate[SecondIntermediateSymbolsToCouplingConstants/.{Rule->Equal},Couplings];
	ReduceSecondIntermediateSymbols=First@Quiet@Solve[ReduceSecondIntermediateSymbols,SecondIntermediateSymbols];

	FirstIntermediateSymbolsToSecondIntermediateSymbols=FirstIntermediateSymbolsToSecondIntermediateSymbols/.ReduceSecondIntermediateSymbols;

{ReduceFirstIntermediateSymbols,FirstIntermediateSymbolsToSecondIntermediateSymbols,SecondIntermediateSymbolsToCouplingConstants}];
