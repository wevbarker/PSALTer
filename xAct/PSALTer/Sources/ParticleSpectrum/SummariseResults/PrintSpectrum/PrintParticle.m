(*=================*)
(*  PrintParticle  *)
(*=================*)

IncludeHeader@"GetDiagram";

Options@PrintParticleList={LaurentDepth->1};
PrintParticleList[
	MassivePoleResidue_,
	SquareMass_,
	Spin_,
	Parity_,
	Polarisations_,
	Opts:OptionsPattern[]]:=MapThread[PrintParticle[#1,#2,Spin,Parity,Polarisations,Opts]&,
			{MassivePoleResidue,SquareMass}];

Options@PrintParticle={LaurentDepth->1};
PrintParticle[
	MassivePoleResidue_,
	SquareMass_,
	Spin_,
	Parity_,
	Polarisations_,
	OptionsPattern[]]:=Module[{TempGraphics,TheParity},

	TheParity=Switch[Parity,Even,"Even",Odd,"Odd"];

	If[SquareMass===0,

	Switch[OptionValue@LaurentDepth,
		1,	
		(
		TempGraphics=NewFramed@Row[{
			GetDiagram@"FeynmanDiagramQuadratic.pdf",
			Grid[
			{
				{Text@"Quadratic pole",SpanFromLeft},
				{Text@"Pole residue: ",Text@ShowIfSmall@(MassivePoleResidue>0)},
				{Text@"Polarisations: ",Text@ShowIfSmall@(Polarisations)}
			},
			Dividers->Center,
			Alignment->Left]
		},Alignment->Center];
		),
		2,
		(
		TempGraphics=NewFramed@Row[{
			GetDiagram@"FeynmanDiagramQuartic.pdf",
			Grid[
			{
				{Text@"Quartic pole",SpanFromLeft},
				{Text@"Pole residue: ",Text@ShowIfSmall@(0<MassivePoleResidue>0)},
				{Text@"Polarisations: ",Text@ShowIfSmall@(Polarisations)}
			},
			Dividers->Center,
			Alignment->Left]
		},Alignment->Center];
		),
		3,
		(
		TempGraphics=NewFramed@Row[{
			GetDiagram@"FeynmanDiagramHexic.pdf",
			Grid[
			{
				{Text@"Hexic pole",SpanFromLeft},
				{Text@"Pole residue: ",Text@ShowIfSmall@(0<MassivePoleResidue>0)},
				{Text@"Polarisations: ",Text@ShowIfSmall@(Polarisations)}
			},
			Dividers->Center,
			Alignment->Left]
		},Alignment->Center];
		)
	];
	,
	TempGraphics=NewFramed@Row[{
		GetDiagram@("FeynmanDiagramSpin"<>(ToString@Spin)<>"Parity"<>TheParity<>".pdf"),
		Grid[
		{
			{Text@"Massive particle",SpanFromLeft},
			{Text@"Pole residue: ",Text@ShowIfSmall@(MassivePoleResidue>0)},
			{Text@"Polarisations: ",Text@(2*Spin+1)},
			{Text@"Square mass: ",Text@ShowIfSmall@(SquareMass>0)},
			{Text@"Spin: ",Text@(Spin)},
			{Text@"Parity: ",Text@TheParity}
		},
		Dividers->Center,
		Alignment->Left]
	},Alignment->Center];
	];
TempGraphics];
