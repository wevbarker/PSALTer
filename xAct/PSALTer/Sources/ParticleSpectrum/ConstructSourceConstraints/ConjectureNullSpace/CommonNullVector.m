(*====================*)
(*  CommonNullVector  *)
(*====================*)

IncludeHeader@"IsNullVectorOfSpace";

CommonNullVector[NullVector_,MinimalExampleCaseNullSpaces_]:=Module[{IsNullVectorOfExampleCaseNullSpaces},
	IsNullVectorOfExampleCaseNullSpaces=IsNullVectorOfSpace[NullVector,#]&/@MinimalExampleCaseNullSpaces;
And@@IsNullVectorOfExampleCaseNullSpaces];
