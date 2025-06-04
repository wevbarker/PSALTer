(*===============*)
(*  FieldMosaic  *)
(*===============*)

FieldMosaic[
		TheDecompositionTable_]~Y~Module[{
	DecompositionGroup=TheDecompositionTable,
	FinalGraphic},

	(*If[!$NoExport,DecompositionGroup//=Vectorize;];	*)
	
	FinalGraphic={
			DecompositionGroup
	};

	FinalGraphic//=Column[#,
			Alignment->{Left,Center},
			Background->$PanelColor,
			Frame->False,
			Spacings->{1,1}]&;
FinalGraphic];
