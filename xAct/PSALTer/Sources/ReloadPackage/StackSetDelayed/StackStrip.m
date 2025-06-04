(*==============*)
(*  StackStrip  *)
(*==============*)

StackStrip[RawStack_]:=Module[{Expr},
	Expr=(If[(Head@#===Symbol),#,(Head@#)]&/@RawStack);
	Expr=DeleteElements[Expr,Complement[Expr,$DefinedFunctions]];
Expr];
