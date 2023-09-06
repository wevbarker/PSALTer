(*====================*)
(*  GetHermitianPart  *)
(*====================*)

GetHermitianPart[InputMatrix_]:=Module[{
	ImaginaryPart,
	RealPart,
	MatrixExpr=InputMatrix},
		
	ImaginaryPart=Map[(If[
(MemberQ[Flatten@(Arg@#&/@FactorList[#]),Pi/2]||MemberQ[Flatten@(Arg@#&/@FactorList[#]),-Pi/2]),#,0]&),MatrixExpr,{2}];

	RealPart=MatrixExpr-ImaginaryPart;
	MatrixExpr=Simplify@((1/2)(RealPart+Transpose@RealPart)+(1/2)(ImaginaryPart-Transpose@ImaginaryPart));
MatrixExpr];
