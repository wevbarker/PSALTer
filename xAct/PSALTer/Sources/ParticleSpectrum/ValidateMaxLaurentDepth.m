(*===========================*)
(*  ValidateMaxLaurentDepth  *)
(*===========================*)

ParticleSpectrum::WrongMaxLaurentDepth="The maximum requested depth n of the 1/k^(2n) residue n=`1` appears not to be a natural number 1, 2 or 3.";
ValidateMaxLaurentDepth[MaxLaurentDepthValue_]:=If[!({1,2,3}~MemberQ~MaxLaurentDepthValue),
			Throw@Message[ParticleSpectrum::WrongMaxLaurentDepth,MaxLaurentDepthValue]
			];
