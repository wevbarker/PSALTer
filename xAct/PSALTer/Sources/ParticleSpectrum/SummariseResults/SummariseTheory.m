(*===================*)
(*  SummariseTheory  *)
(*===================*)

SummariseTheory[Theory_?StringQ]:=Theory;
NotStringQ[InputExpr_]:=!StringQ@InputExpr;
RigidBox[InputExpr_]:=NewFramed@Grid[
					{{Text@"Lagrangian density",SpanFromLeft},
					{InputExpr[[1]],SpanFromLeft},
					{Text@"Added source term:",InputExpr[[2]]}},
						ItemStyle->{LineIndent->0},	
						Dividers->Center,
						Alignment->Left];
SummariseTheory[Theory_?NotStringQ]:=Module[{
		PlasticBoxFinal,
		PlasticBoxContent,
		PlasticBoxSize},
	PlasticBoxSize=50*Floor@Sqrt@(Length@(Expand@Theory/.{Plus->List}));
	PlasticBoxContent=Theory;
	PlasticBoxContent//=(Evaluate/@#)&;
	PlasticBoxContent//=(ExpandAll/@#)&;
	PlasticBoxContent//=(Text/@#)&;
	PlasticBoxFinal=RigidBox[PlasticBoxContent];
PlasticBoxFinal];
