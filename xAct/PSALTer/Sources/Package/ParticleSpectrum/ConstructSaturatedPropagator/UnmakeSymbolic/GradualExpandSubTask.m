(*========================*)
(*  GradualExpandSubTask  *)
(*========================*)

BuildPackage@"ParticleSpectrum/ConstructSaturatedPropagator/UnmakeSymbolic/GradualExpandSubTask/GradualExpand.m";

GradualExpandSubTask[MatrixElementSubTaskFileName_]:=Module[{
		ReduceFirstIntermediateSymbols,
		FirstIntermediateSymbolsToSecondIntermediateSymbols,
		SecondIntermediateSymbolsToCouplingConstants,
		SymbolicRules,
		CouplingAssumptions,
		SubTaskExpr		
	},

	Get@MatrixElementSubTaskFileName;
	{CouplingAssumptions,SymbolicRules,SubTaskExpr}=ToExpression@"xAct`PSALTer`Private`MatrixElementSubTask";
	
	{ReduceFirstIntermediateSymbols,FirstIntermediateSymbolsToSecondIntermediateSymbols,SecondIntermediateSymbolsToCouplingConstants}=SymbolicRules;

	SubTaskExpr=GradualExpand[CouplingAssumptions,
				SubTaskExpr,
				ReduceFirstIntermediateSymbols];
	SubTaskExpr=GradualExpand[CouplingAssumptions,
				SubTaskExpr,
				FirstIntermediateSymbolsToSecondIntermediateSymbols];
	SubTaskExpr=GradualExpand[CouplingAssumptions,
				SubTaskExpr,
				SecondIntermediateSymbolsToCouplingConstants];
	MatrixElementSubTask={CouplingAssumptions,SubTaskExpr};
	DumpSave[MatrixElementSubTaskFileName,MatrixElementSubTask];
];
