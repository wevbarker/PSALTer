(*===================*)
(*  AllParticleRows  *)
(*===================*)

IncludeHeader@"ParticleRows";

AllParticleRows[MasslessSpectrum_,Spectrum_]~Y~Module[{
	MasslessRows=ParticleRows@@MasslessSpectrum,
	MassiveRows=ParticleRows@@Spectrum,
	Expr},

	If[(Length@MassiveRows==0)&&(Length@MasslessRows==0),
		Expr={};
	,
		Expr=Join[
			{Text/@{"Resolved pole(s)","# d(s).o.f","Square mass","Residue"}},
			MasslessRows,
			MassiveRows
		];
	];
Expr];
