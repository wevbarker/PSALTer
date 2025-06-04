(*======================*)
(*  MatrixFromSymbolic  *)
(*======================*)

MatrixFromSymbolic[
			InputSymbolicMatrix_,
			InputSymbolicElements_,
			InputUniqueElements_]~Y~Module[{
	TheSymbolicToUnique,
	TheUniqueMatrix
	},
	
	TheSymbolicToUnique=MapThread[(#1->#2)&,
		{InputSymbolicElements,InputUniqueElements}];
	TheUniqueMatrix=InputSymbolicMatrix/.TheSymbolicToUnique;
	
TheUniqueMatrix];
