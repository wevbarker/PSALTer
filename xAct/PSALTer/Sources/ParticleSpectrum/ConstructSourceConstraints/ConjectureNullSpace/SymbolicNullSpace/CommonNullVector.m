(*====================*)
(*  CommonNullVector  *)
(*====================*)

IncludeHeader@"IsNullVectorOfSpace";

CommonNullVector[NullVector_,MinimalExampleCaseNullSpaces_]~Y~Module[{IsNullVectorOfExampleCaseNullSpaces},

	IsNullVectorOfExampleCaseNullSpaces=MapThread[
		(xAct`PSALTer`Private`NewParallelSubmit@(IsNullVectorOfSpace[#1,#2]))&,
		{Map[(NullVector)&,MinimalExampleCaseNullSpaces],
		MinimalExampleCaseNullSpaces}];
	IsNullVectorOfExampleCaseNullSpaces//=MonitorParallel;
	Diagnostic@IsNullVectorOfExampleCaseNullSpaces;
And@@IsNullVectorOfExampleCaseNullSpaces];
