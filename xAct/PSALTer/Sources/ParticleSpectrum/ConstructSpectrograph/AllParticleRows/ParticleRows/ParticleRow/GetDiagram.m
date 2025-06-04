(*==============*)
(*  GetDiagram  *)
(*==============*)

GetDiagram[FileName_]:=Module[{TemporaryFileName,Expr},
	TemporaryFileName=FileNameJoin@{$InstallDirectory,
		"Sources",
		"ParticleSpectrum",
		"ConstructSpectrograph",
		"AllParticleRows",
		"ParticleRows",
		"ParticleRow",FileName};
	Expr=$Failed;
	While[Expr===$Failed,
		Expr=TemporaryFileName~Import~{"PDF","PageGraphics"};
	];
	Expr//=First;
	Expr=Magnify[Expr,0.6];
Expr];
