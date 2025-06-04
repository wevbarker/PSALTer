(*===========================*)
(*  ConsolidateFinalElement  *)
(*===========================*)

$ConsolidateFinalElementTime=20;
ConsolidateFinalElement[FinalElement_]~Y~Module[{
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
