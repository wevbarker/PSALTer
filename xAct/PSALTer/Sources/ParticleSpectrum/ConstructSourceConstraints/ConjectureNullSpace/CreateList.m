(*==============*)
(*  CreateList  *)
(*==============*)

ClearAll[CreateList];
SetAttributes[CreateList,HoldAll];
CreateList[Plus[a__]]:={a};
CreateList[a_?AtomQ]:={a};
CreateList[a_]:=a;
