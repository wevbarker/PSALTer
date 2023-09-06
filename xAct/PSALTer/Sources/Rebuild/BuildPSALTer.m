(*================*)
(*  BuildPSALTer  *)
(*================*)

xAct`PSALTer`Private`BuildRebuild@"DefManifold.m";
xAct`PSALTer`Private`BuildRebuild@"Foliation.m";
xAct`PSALTer`Private`BuildRebuild@"Lightcone.m";

(*=========================*)
(*  Import theory classes  *)
(*=========================*)

If[!(ValueQ@ClassNames),ClassNames={}];
Off[General::shdw];
xAct`PSALTer`Private`BuildRebuild@"Classes/ScalarTheory.m";
xAct`PSALTer`Private`BuildRebuild@"Classes/VectorTheory.m";
xAct`PSALTer`Private`BuildRebuild@"Classes/TensorTheory.m";
xAct`PSALTer`Private`BuildRebuild@"Classes/ScalarTensorTheory.m";
xAct`PSALTer`Private`BuildRebuild@"Classes/PoincareGaugeTheory.m";
On[General::shdw];
