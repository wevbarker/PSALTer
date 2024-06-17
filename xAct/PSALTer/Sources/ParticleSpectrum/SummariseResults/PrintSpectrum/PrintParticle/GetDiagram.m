(*==============*)
(*  GetDiagram  *)
(*==============*)

GetDiagram[FileName_]:=Module[{TemporaryFileName,Expr},
	TemporaryFileName=FileNameJoin@{$InstallDirectory,
		"Sources",
		"ParticleSpectrum",
		"SummariseResults",
		"PrintSpectrum",
		"PrintParticle",FileName};
	Expr=$Failed;
	While[Expr===$Failed,
		Expr=TemporaryFileName~Import~{"PDF","PageGraphics"};
	];
	Expr//=First;
	Expr=Magnify[Expr,1.1];
Expr];
