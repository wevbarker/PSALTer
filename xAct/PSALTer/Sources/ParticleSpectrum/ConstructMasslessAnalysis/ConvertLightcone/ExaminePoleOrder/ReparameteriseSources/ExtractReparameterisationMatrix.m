(*===================================*)
(*  ExtractReparameterisationMatrix  *)
(*===================================*)

ExtractReparameterisationMatrix[InputMatrix_]:=Module[{ReparameterisationMatrix},

	ReparameterisationMatrix=InputMatrix;
	ReparameterisationMatrix//=Diagonal;
	ReparameterisationMatrix//=(FactorList/@#)&;
	ReparameterisationMatrix//=(DeleteCases[#,{TheExpression___,Num_?OddQ}]&/@#)&;
	ReparameterisationMatrix//=((1/PowerExpand@Sqrt@(Times@@((Power@@#)&/@#)))&/@#)&;
	ReparameterisationMatrix//=DiagonalMatrix;
ReparameterisationMatrix];
