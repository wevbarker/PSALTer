(*=========================*)
(*  ReparameteriseSources  *)
(*=========================*)

IncludeHeader@"ExtractDenominator";
IncludeHeader@"ExtractReparameterisationMatrix";

ReparameteriseSources[InputMatrix_]:=Module[{
	ReparameterisedMatrix=InputMatrix,
	OverallDenominator,
	ReparameterisationMatrix	
	},

	OverallDenominator=ExtractDenominator@ReparameterisedMatrix;
	Diagnostic@ReparameterisedMatrix;
	ReparameterisedMatrix*=OverallDenominator;
	ReparameterisedMatrix//=Simplify;
	ReparameterisationMatrix=ExtractReparameterisationMatrix@ReparameterisedMatrix;
	ReparameterisedMatrix=ReparameterisationMatrix.ReparameterisedMatrix.ReparameterisationMatrix;
	ReparameterisedMatrix//=Simplify;	
{ReparameterisedMatrix,OverallDenominator}];
