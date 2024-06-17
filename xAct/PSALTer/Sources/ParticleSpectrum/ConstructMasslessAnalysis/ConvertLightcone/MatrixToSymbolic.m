(*====================*)
(*  MatrixToSymbolic  *)
(*====================*)

MatrixToSymbolic[InputMatrix_]:=Module[{
	TheInputMatrix=InputMatrix,
	TheUniqueElements,
	TheSymbolicElements,
	TheUniqueToSymbolic,
	TheSymbolicToUnique,
	TheSymbolicMatrix
	},

	TheUniqueElements=First/@Tally@Flatten@TheInputMatrix;
	TheUniqueElements//=DeleteCases[#,0,Infinity]&;
	TheSymbolicElements=ToExpression/@Table["UniqueCoefficient"<>ToString@ii,
		{ii,Length@TheUniqueElements}];
	TheUniqueToSymbolic=MapThread[(#1->#2)&,
		{TheUniqueElements,TheSymbolicElements}];
	TheSymbolicToUnique=MapThread[(#1->#2)&,
		{TheSymbolicElements,TheUniqueElements}];
	TheSymbolicMatrix=Replace[TheInputMatrix,TheUniqueToSymbolic,{2}];
	
<|
	UniqueMatrix->TheInputMatrix,
	UniqueMatrixElements->TheUniqueElements,
	SymbolicMatrixElements->TheSymbolicElements,
	UniqueToSymbolic->TheUniqueToSymbolic,
	SymbolicToUnique->TheSymbolicToUnique,
	SymbolicMatrix->TheSymbolicMatrix
|>];
