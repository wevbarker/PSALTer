(*===========================*)
(*  ConsolidateFinalElement  *)
(*===========================*)

$ConsolidateFinalElementTime=500;
ConsolidateFinalElement[FinalElement_]:=Module[{
	CouplingAssumptions,
	FullElement},

	{CouplingAssumptions,FullElement}=FinalElement;
	TimeConstrained[
	(
		Assuming[CouplingAssumptions,FullElement//=FullSimplify];	
	)
	,
	$ConsolidateFinalElementTime,
	(
		TimeConstrained[
		(
			Assuming[CouplingAssumptions,FullElement//=Simplify];	
		),$ConsolidateFinalElementTime];
	)
	];
FullElement];
