(*=======================*)
(*  IsNullVectorOfSpace  *)
(*=======================*)

IsNullVectorOfSpace[NullVector_,MinimalExampleCaseNullSpace_]:=Module[{LinearIndependence},
	LinearIndependence=ResourceFunction["LinearlyIndependent"]@(MinimalExampleCaseNullSpace~Join~{NullVector});
(!LinearIndependence)];
