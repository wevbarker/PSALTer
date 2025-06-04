(*======================*)
(*  UnresolvedPoleRows  *)
(*======================*)

IncludeHeader@"UnresolvedPoleRow";

UnresolvedPoleRows[UnresolvedPoles_]~Y~Module[{ContentList},

		NewUnresolvedPoles=UnresolvedPoles//ProtractList;
		Diagnostic@NewUnresolvedPoles;

	ContentList=((MapThread[If[!(#1==={}),
					UnresolvedPoleRow[#1,#3,#2],
					0
			]&,{
				NewUnresolvedPoles,
				{1,-1,0,1,-1,0,1,-1,0,1,-1,0}~Take~Length@NewUnresolvedPoles,
				{0,0,0,1,1,1,2,2,2,3,3,3}~Take~Length@NewUnresolvedPoles
		}]~Flatten~1)~DeleteCases~0);
	If[Length@ContentList>0,
		ContentList//=({{Text@"Unresolved pole(s)",Text@"# d.o.f.",Text@"Pole structure(s)",SpanFromLeft}}~Join~#)&;
	];
ContentList];
