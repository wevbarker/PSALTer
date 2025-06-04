(*=======================*)
(*  IsNullVectorOfSpace  *)
(*=======================*)

IsNullVectorOfSpace[NullVector_,MinimalExampleCaseNullSpace_]~Y~Module[{LinearIndependence},
	LinearIndependence=ResourceFunction["LinearlyIndependent"]@(MinimalExampleCaseNullSpace~Join~{NullVector});
(!LinearIndependence)];
