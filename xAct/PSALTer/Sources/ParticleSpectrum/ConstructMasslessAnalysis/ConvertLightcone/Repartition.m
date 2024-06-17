(*===============*)
(*  Repartition  *)
(*===============*)

Options@Repartition={
	ExpandAll->True
	};

Repartition[InputExpr_List,PartitionLength_Integer,OptionsPattern[]]:=Module[{
	Expr=InputExpr},

	Expr//=Flatten;
	Expr//=Total;
	If[OptionValue@ExpandAll,Expr//=Expand];
	Expr=(If[Head@#===Plus,List@@#,List@#])&@(Expr);
	Expr//=Flatten;
	Expr//=RandomSample;
	Expr//=Partition[#,UpTo@PartitionLength]&;
	Expr//=(Total/@#)&;	
Expr];
