(*====================*)
(*  PoleToSquareMass  *)
(*====================*)

PoleToSquareMass[Pole_List]:=Module[{Position=First@Pole,Order=Pole[[2]]},
	{Simplify@(Position^2),Order}];
