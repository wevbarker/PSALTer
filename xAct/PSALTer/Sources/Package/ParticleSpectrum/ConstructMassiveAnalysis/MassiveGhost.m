(*================*)
(*  MassiveGhost  *)
(*================*)

MassiveGhost[InverseBMatrix_,SquareMassesValue_,Couplings_]:=Module[{
	NotZero,
	CouplingAssumptions,
	InverseBMatrixTrace,
	SquareDef,
	TraceResidue},

	LocalSpectrum=" ** MassiveGhost...";

	NotZero=!(PossibleZeroQ@SquareMassesValue);
	Diagnostic@NotZero;
	If[NotZero,
		CouplingAssumptions=(#~Element~Reals)&/@Couplings;
		Diagnostic@CouplingAssumptions;

		InverseBMatrixTrace=Tr@InverseBMatrix;
		Diagnostic@InverseBMatrixTrace;
		(*Assuming[CouplingAssumptions,InverseBMatrixTrace//=Simplify];*)
		InverseBMatrixTrace=SimplifyIfSmall[CouplingAssumptions,InverseBMatrixTrace];
		Diagnostic@InverseBMatrixTrace;
		InverseBMatrixTrace=InverseBMatrixTrace/.{Def->Sqrt@SquareDef};
		Diagnostic@InverseBMatrixTrace;
		(*Assuming[CouplingAssumptions,InverseBMatrixTrace//=Simplify];*)
		InverseBMatrixTrace=SimplifyIfSmall[CouplingAssumptions,InverseBMatrixTrace];
		Diagnostic@InverseBMatrixTrace;
		TraceResidue=InverseBMatrixTrace~Residue~{SquareDef,SquareMassesValue};
		Diagnostic@TraceResidue;
		(*Assuming[CouplingAssumptions,TraceResidue//=Simplify];*)
		TraceResidue=SimplifyIfSmall[CouplingAssumptions,TraceResidue];
		Diagnostic@TraceResidue;,
		TraceResidue=0;
		Diagnostic@TraceResidue;
	];
TraceResidue];
