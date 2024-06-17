(*======================*)
(*  ValidateTheoryName  *)
(*======================*)

ParticleSpectrum::WrongTheoryName="You must pass a string to the option TheoryName.";
ValidateTheoryName[TheoryNameValue_]:=If[!(StringQ@TheoryNameValue),
			Throw@Message[ParticleSpectrum::WrongTheoryName,TheoryNameValue]
			];
