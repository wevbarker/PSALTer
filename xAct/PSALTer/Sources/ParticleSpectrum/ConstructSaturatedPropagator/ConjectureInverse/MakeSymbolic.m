(*================*)
(*  MakeSymbolic  *)
(*================*)

MakeSymbolic[InputMatrix_,CouplingAssumptions_]:=Module[{
	DimensionOfMatrix,
	SymbolicMatrix,
	SymbolicRules
	},

	$LocalPropagator=" ** MakeSymbolic...";

	DimensionOfMatrix=Length@InputMatrix;
	SymbolicMatrix=Table[0,{i,DimensionOfMatrix},{j,DimensionOfMatrix}];	
	SymbolicRules={};
	Diagnostic@CouplingAssumptions;
	ReplaceReal[i_,j_]:=Module[{RealPart,NewSymbol},	
		Assuming[CouplingAssumptions,RealPart=Simplify@Re@(Evaluate@InputMatrix[[i,j]])];
		NewSymbol=Symbol["xAct`PSALTer`Private`r"<>ToString@i<>ToString@j];
		If[PossibleZeroQ@RealPart,Null,
			SymbolicRules~AppendTo~(NewSymbol->RealPart);
			SymbolicMatrix[[i,j]]+=NewSymbol;
			If[i===j,Null,
				SymbolicMatrix[[j,i]]+=NewSymbol;
			];
		];
	];
	ReplaceImaginary[i_,j_]:=Module[{ImaginaryPart,NewSymbol},
		Assuming[CouplingAssumptions,ImaginaryPart=Simplify@Im@(Evaluate@InputMatrix[[i,j]])];
		NewSymbol=Symbol["xAct`PSALTer`Private`i"<>ToString@i<>ToString@j];
		If[PossibleZeroQ@ImaginaryPart,Null,
			SymbolicRules~AppendTo~(NewSymbol->ImaginaryPart);
			SymbolicMatrix[[i,j]]+=I*NewSymbol;
			If[i===j,Null,
				SymbolicMatrix[[j,i]]+=-I*NewSymbol;
			];
		];
	];	
	Table[
		(
			ReplaceReal[i,j];
			ReplaceImaginary[i,j];
		),
		{i,DimensionOfMatrix},{j,i,DimensionOfMatrix}];	
{SymbolicMatrix,SymbolicRules}];
