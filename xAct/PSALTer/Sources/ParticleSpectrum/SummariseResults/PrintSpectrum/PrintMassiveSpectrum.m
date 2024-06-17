(*========================*)
(*  PrintMassiveSpectrum  *)
(*========================*)

PrintMassiveSpectrum[SquareMasses_,MassivePropagatorResidues_]:=Print@Column@(Flatten[MapThread[If[!(PossibleZeroQ@#1),
			PrintParticle[#1,#2,#4,#3,2*#4+1],
			0
	]&,
	PadRight[#,{Length@#,Max@(Length/@#)}]&/@{
		MassivePropagatorResidues,
		SquareMasses,
		MapThread[ConstantArray[#1,Length@#2]&,
				{{Even,Odd,Even,Odd,Even,Odd,Even,Odd}~Take~Length@SquareMasses,
				SquareMasses},1],
		MapThread[ConstantArray[#1,Length@#2]&,
				{{0,0,1,1,2,2,3,3}~Take~Length@SquareMasses,
				SquareMasses},1]
	},2],{1,2}]~DeleteCases~0);
