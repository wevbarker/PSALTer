(*=======================*)
(*  ConjectureNullSpace  *)
(*=======================*)

BuildPackage@"ParticleSpectrum/ConstructSourceConstraints/CommonNullVector.m";

ConjectureNullSpace[InputMatrix_,Couplings_,CouplingAssumptions_]:=Module[{	
	MinimalExampleCaseRules,
	MinimalExampleCaseNullSpaces,
	AllNullVectors},

	MinimalExampleCaseRules=Table[(#->0)&/@Drop[Couplings,{i}],{i,Length@Couplings}];
	MinimalExampleCaseNullSpaces=Module[{MinimalExampleCaseNullSpace},
		Assuming[CouplingAssumptions,MinimalExampleCaseNullSpace=NullSpace[InputMatrix/.#]];
		Assuming[CouplingAssumptions,MinimalExampleCaseNullSpace//=Simplify];
	MinimalExampleCaseNullSpace]&/@MinimalExampleCaseRules;
	AllNullVectors=Join@@MinimalExampleCaseNullSpaces;
	AllNullVectors//=DeleteDuplicates;
	ConjecturedNullSpace=AllNullVectors~Select~(CommonNullVector[#,MinimalExampleCaseNullSpaces]&);
ConjecturedNullSpace];
