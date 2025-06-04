(*=========================*)
(*  ReparameteriseSources  *)
(*=========================*)

IncludeHeader@"ExtractDenominator";
IncludeHeader@"ExtractReparameterisationMatrix";

ReparameteriseSources[InputMatrix_]~Y~Module[{
	ReparameterisedMatrix=InputMatrix,
	OverallDenominator,
	ReparameterisationMatrix	
	},

	OverallDenominator=ExtractDenominator@ReparameterisedMatrix;
	Diagnostic@ReparameterisedMatrix;
	ReparameterisedMatrix*=OverallDenominator;
	(*ReparameterisedMatrix//=Simplify;*)
	ReparameterisedMatrix=Map[
		(xAct`PSALTer`Private`NewParallelSubmit@(Simplify@#))&,
		ReparameterisedMatrix,{2}];
	ReparameterisedMatrix//=MonitorParallel;
(*
	ReparameterisationMatrix=ExtractReparameterisationMatrix@ReparameterisedMatrix;
	ReparameterisedMatrix=ReparameterisationMatrix.ReparameterisedMatrix.ReparameterisationMatrix;
	ReparameterisedMatrix//=Simplify;	
*)
{ReparameterisedMatrix,OverallDenominator}];
