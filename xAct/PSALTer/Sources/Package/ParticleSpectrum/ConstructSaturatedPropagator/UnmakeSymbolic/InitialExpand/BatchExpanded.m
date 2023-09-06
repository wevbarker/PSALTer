(*=================*)
(*  BatchExpanded  *)
(*=================*)

BatchExpanded[InputExpr_,Prefix_,SymbolicRules_,MatrixElementFileName_]:=Module[{
	Expr,
	CouplingAssumptions,
	NumberOfSubTasks,
	NewFileNames,
	MatrixElementSubTaskFileName},

	{CouplingAssumptions,Expr}=InputExpr;
	Expr//=Expand;
	Expr=Expr/.{Plus->List};
	Expr//=List;
	Expr//=Flatten;
	Expr//=Partition[#,UpTo@Ceiling[(Length@#)/16]]&;
	Expr=Total/@Expr;
	Expr=Expand/@Expr;
	Expr={CouplingAssumptions,SymbolicRules,#}&/@Expr;
	NumberOfSubTasks=Length@Expr;

	Quiet@CreateDirectory[FileNameJoin@{NotebookDirectory[],"tmp"}];
	NewFileNames=Table[
		StringDrop[MatrixElementFileName,-3]<>Prefix<>ToString@SubTask<>".mx",
				{SubTask,NumberOfSubTasks}];
	Table[
		MatrixElementSubTask=Evaluate@Expr[[SubTask]];
		MatrixElementSubTaskFileName=Evaluate@NewFileNames[[SubTask]];
		DumpSave[MatrixElementSubTaskFileName,MatrixElementSubTask];
		MatrixElementSubTask=0;
		MatrixElementSubTaskFileName="";,
				{SubTask,NumberOfSubTasks}];
NewFileNames];
