(*========================*)
(*  ViewParticleSpectrum  *)
(*========================*)

Options[ViewParticleSpectrum]={
	Literature->True,
	Brackets->True,
	Velocities->True};

ViewParticleSpectrum::nobin="The binary at `1` cannot be found; quitting.";

ViewParticleSpectrum[TheoryName_String,OptionsPattern[]]:=Module[{
	Theory},

	(*---------------------------------------------------*)
	(*  Import the theory if defined in another session  *)
	(*---------------------------------------------------*)

	If[!(AssociationQ@Evaluate@Symbol@TheoryName),

		Print[" ** ViewParticleSpectrum: Incorporating the binary at "<>TheoryName<>".thr.mx"];
		Check[
			ToExpression["<<"<>
					FileNameJoin@{$WorkingDirectory,TheoryName<>
					".thr.mx"}<>";"],
			Throw@Message[
					ViewParticleSpectrum::nobin,
					FileNameJoin@{$WorkingDirectory,TheoryName<>".thr.mx"}
				];Quit[];];,
	];

	Theory=Evaluate@Symbol@TheoryName;

	(*-----------------------------------------------*)
	(*  Present information about particle spectrum  *)
	(*-----------------------------------------------*)

	If[OptionValue[Literature],
	];

	Print@"The Lagrangian of the theory in momentum space, as described in
	Eq. (18) of arXiv:1812.02675, with field operators linearised according to the
	scheme set out around Eq. (50) and Eq. (51), and decomposed into the
	spin-parity sectors listed in Appendix A:";	
	Print@Theory@MomentumSpaceLagrangian;

	Print@"The (possibly singular) \[ScriptA]-matrices associated with the
	Lagrangian, as defined below Eq. (18) of arXiv:1812.02675, in the order
	0+, 0-, 1+, 1-, 2+, 2-:";
	Print/@MatrixForm/@Theory@BMatrices;

	Print@"The Drazin (Moore-Penrose) inverses of these
	\[ScriptA]-matrices, which are functionally analogous to the inverse
	\[ScriptB]-matrices described below Eq. (21) of arXiv:1812.02675, in
	the order 0+, 0-, 1+, 1-, 2+, 2-:";
	Print/@MatrixForm/@Theory@InverseBMatrices;

	Print@"The constraints on the source currents (stress-energy and spin
	tensors), implied by the singularity of the \[ScriptA]-matrices. These
	are expressed in the Lorentzian component form defined below Eq. (28)
	of arXiv:1812.02675, whereby the momentum vector has components
	\[ScriptK]=(\!\(\*SubscriptBox[\(\[ScriptK]\),
\(0\)]\),\!\(\*SubscriptBox[\(\[ScriptK]\),
\(1\)]\),\!\(\*SubscriptBox[\(\[ScriptK]\),
\(2\)]\),\!\(\*SubscriptBox[\(\[ScriptK]\),
\(3\)]\))=(\[ScriptCapitalE],0,0,\[ScriptP]):";	
	Print/@Theory@SourceConstraintComponents;

	Print@"The square masses associated with the massvie poles in each
	spin-parity sector (if any). As described around Eq. (38) of
		arXiv:1812.02675, the positivity of nonzero masses determines
		the no-tachyon condition. Sectors given in the order 0+, 0-,
		1+, 1-, 2+, 2-:";
	Print/@Theory@SquareMasses;

	Print@"The nonzero, massless eigenvalues (if any) of the free
		components of the whole (i.e. summed over all spin-parity
		sectors) saturated propagator in the massless limit
		\[ScriptCapitalE]->\[ScriptP]. The no-ghost condition on the
		massless sector, as set out in Eq. (36) of arXiv:1812.02675,
		rests on the positivity of these eigenvalues, and their number
		is the the number of propagating massless polarisations:";
	Print@Theory@MasslessEigenvalues;
];
