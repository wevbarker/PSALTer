(*====================*)
(*  CommonNullVector  *)
(*====================*)

BuildPackage@"ParticleSpectrum/ConstructSourceConstraints/IsNullVectorOfSpace.m";

CommonNullVector[NullVector_,MinimalExampleCaseNullSpaces_]:=Module[{IsNullVectorOfExampleCaseNullSpaces},
	IsNullVectorOfExampleCaseNullSpaces=IsNullVectorOfSpace[NullVector,#]&/@MinimalExampleCaseNullSpaces;
And@@IsNullVectorOfExampleCaseNullSpaces];
