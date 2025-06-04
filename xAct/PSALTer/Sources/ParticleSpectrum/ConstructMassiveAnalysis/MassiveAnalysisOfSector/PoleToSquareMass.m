(*====================*)
(*  PoleToSquareMass  *)
(*====================*)

PoleToSquareMass[Pole_List]~Y~Module[{Position=First@Pole,Order=Pole[[2]]},
	{Simplify@(Position^2),Order}];
