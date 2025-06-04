(*================*)
(*  GUICallStack  *)
(*================*)

(*Do **not** use ~Y~ here*)
TheProgressIndicator[]:=ProgressIndicator[Appearance->"Necklace",ImageSize->Small];
GUICallStack[CallStack_]:=Row[{TheProgressIndicator[],CallStack},
		Invisible@TheProgressIndicator[],
		Alignment->{Left,Center}];
