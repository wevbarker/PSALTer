(*================*)
(*  IsolatePoles  *)
(*================*)

IsolatePoles[InputDenominator_,CouplingAssumptions_]:=Module[{
	Poly=InputDenominator,
	NewCouplingAssumptions=CouplingAssumptions},
	Poly=Poly/.{Def->Sqrt@xAct`PSALTer`Private`DefSquared};

	NewCouplingAssumptions=NewCouplingAssumptions~Join~{xAct`PSALTer`Private`DefSquared~Element~Reals};
	Assuming[NewCouplingAssumptions,Poly//=Simplify];
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
		ListOfRoots//=DeleteCases[#,_?NumberQ]&;
		Diagnostic@ListOfRoots;,
		ListOfRoots={};
	];
ListOfRoots];
