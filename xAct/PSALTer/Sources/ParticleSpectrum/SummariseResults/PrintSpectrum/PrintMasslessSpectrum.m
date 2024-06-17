(*=========================*)
(*  PrintMasslessSpectrum  *)
(*=========================*)

PrintMasslessSpectrum[MasslessEigenvalues_]:=Print@Column@(PrintParticle[First@#,0,0,0,Length@#]&/@Gather@(StripFactors/@MasslessEigenvalues));
