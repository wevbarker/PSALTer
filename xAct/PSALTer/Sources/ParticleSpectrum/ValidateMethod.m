(*==================*)
(*  ValidateMethod  *)
(*==================*)

ParticleSpectrum::WrongMethod="The method \"`1`\" for evaluating the source constraints and matrix pseudoinverses appears not to be either of the strings \"Easy\" or \"Hard\".";
ValidateMethod[MethodValue_]:=If[!({"Easy","Hard"}~MemberQ~MethodValue),
			Throw@Message[ParticleSpectrum::WrongMethod,MethodValue]
			];
