(*===================*)
(*  CleanNullVector  *)
(*===================*)

CleanNullVector[NullVector_,CouplingAssumptions_]:=Module[{
	Expr=NullVector,
	MinimumPower},

	MinimumPower=NullVector;
	MinimumPower//=Assuming[CouplingAssumptions,(Exponent[#,xAct`PSALTer`Def,Min])&/@#]&;
	MinimumPower//=Assuming[CouplingAssumptions,Cases[#,_?NumericQ]]&;
	MinimumPower//=Assuming[CouplingAssumptions,Min@#]&;
	Expr/=xAct`PSALTer`Def^MinimumPower;
	CouplingAssumptions~Assuming~(Expr//=FullSimplify);
Expr];
