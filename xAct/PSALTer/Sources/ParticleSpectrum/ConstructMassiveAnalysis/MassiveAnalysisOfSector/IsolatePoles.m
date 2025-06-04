(*================*)
(*  IsolatePoles  *)
(*================*)

IncludeHeader@"StripPoly";
IncludeHeader@"IrrationalQ";
IncludeHeader@"PartitionDeterminant";

ParticleSpectrum::MultiMass="One of the spin sectors appears to contain multiple massive particles.";
ParticleSpectrum::IrrationalMass="One of the particles appears to have a square mass which is not a rational function of the Lagrangian coupling coefficients.";
IsolatePoles[InputDenominator_,CouplingAssumptions_]~Y~Module[{
	Poly=InputDenominator,
	NewCouplingAssumptions=CouplingAssumptions,
	RationalRoots},

	NewCouplingAssumptions=NewCouplingAssumptions~Join~{xAct`PSALTer`Private`DefSquared~Element~Reals};
	Poly//=StripPoly[#,NewCouplingAssumptions]&;
	Diagnostic@Poly;

	ListOfRoots=Assuming[NewCouplingAssumptions,Roots[Poly==0,xAct`PSALTer`Private`DefSquared]];
	Diagnostic@ListOfRoots;
	If[!(ListOfRoots===False),
		ListOfRoots=ListOfRoots/.{Or->List};
		ListOfRoots=Flatten@{ListOfRoots};
		Diagnostic@ListOfRoots;
		ListOfRoots=(xAct`PSALTer`Private`DefSquared/.First@Solve[#,xAct`PSALTer`Private`DefSquared])&/@ListOfRoots;
		Diagnostic@ListOfRoots;
		ListOfRoots//=DeleteDuplicates;
		Diagnostic@ListOfRoots;
		ListOfRoots//=DeleteCases[#,0,Infinity]&;
		Diagnostic@ListOfRoots;
		ListOfRoots//=DeleteCases[#,_?NumericQ]&;
		Diagnostic@ListOfRoots;
		RationalRoots=ListOfRoots~DeleteCases~_?IrrationalQ;
		If[(Length@RationalRoots)<(Length@ListOfRoots),
			Message@ParticleSpectrum::IrrationalMass;
			RationalRoots~AppendTo~(Poly~PartitionDeterminant~RationalRoots);
		];
	,
		RationalRoots={};
	];
	If[Length@RationalRoots>=2,Message@ParticleSpectrum::MultiMass;];
	Diagnostic@RationalRoots;
RationalRoots];
