(*==============*)
(*  CreateList  *)
(*==============*)

ClearAll[CreateList];
SetAttributes[CreateList,HoldAll];
CreateList[Plus[a__]]~Y~{a};
CreateList[a_?AtomQ]~Y~{a};
CreateList[a_]~Y~a;
