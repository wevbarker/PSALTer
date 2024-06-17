(*===================*)
(*  SplitWignerGrid  *)
(*===================*)

SplitWignerGrid[AllMatrices_,Sizes_,Spins_,Sides_,Tops_]:=(WignerGrid@@#)&/@MapThread[
	(List/@{#1,#2,#3,#4,#5})&,
	{AllMatrices,Sizes,Spins,Sides,Tops}];
