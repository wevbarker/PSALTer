(*==================*)
(*  SummariseField  *)
(*==================*)

IncludeHeader@"ExpansionTable";
IncludeHeader@"DecompositionTable";
IncludeHeader@"FieldMosaic";

SummariseField[]:=Module[{
	Class,
	BasicInfo,
	FieldSpinParityTensors,
	FieldSpinParityTensorsSymmetries,
	FieldSpinParityTensorsExpanded,
	SourceSpinParityTensors,
	TheExpansionTable,
	FieldTensors,
	FieldTensorsSymmetries,
	FieldTensorsDecomposed,
	SourceTensors,
	TheDecompositionTable,
	DecompositionExpansionTable,
	TheFieldMosaic
	},

	Class=FieldAssociation@Context[];

	FieldSpinParityTensors=Flatten@Values@(Flatten/@(Values/@(Values/@(Class@FieldSpinParityTensorHeads))));
	FieldSpinParityTensors//=((FromIndexFree@ToIndexFree@#)&/@#)&;
	FieldSpinParityTensorsSymmetries=SymmetryOf/@FieldSpinParityTensors;
	FieldSpinParityTensorsExpanded=(Class@ExpandFields)/@FieldSpinParityTensors;
	SourceSpinParityTensors=Flatten@Values@(Flatten/@(Values/@(Values/@(Class@SourceSpinParityTensorHeads))));
	SourceSpinParityTensors//=((FromIndexFree@ToIndexFree@#)&/@#)&;

	TheExpansionTable=ExpansionTable[FieldSpinParityTensors,
		FieldSpinParityTensorsSymmetries,
		FieldSpinParityTensorsExpanded,
		SourceSpinParityTensors];

	FieldTensors=Class@Tensors;
	FieldTensors//=((FromIndexFree@ToIndexFree@#)&/@#)&;
	FieldTensorsSymmetries=SymmetryOf/@FieldTensors;
	FieldTensorsDecomposed=(Class@DecomposeFields)/@FieldTensors;
	SourceTensors=Class@Sources;
	SourceTensors//=((FromIndexFree@ToIndexFree@#)&/@#)&;

	BasicInfo=NewFramed@Grid[{
	{
		Text@"Basic conventions",
		SpanFromLeft,
		SpanFromLeft,
		SpanFromLeft,
		SpanFromLeft
	},
		{
		Text@"Minkowski metric tensor",
		Text@"Totally antisymmetric tensor",
		Text@"Four-momentum",
		Text@"Four-momentum norm",
		Text@"Massive rest-frame"},
		{
		Text@(G[-m,-n]),
		Text@(epsilonG[-m,-n,-r,-s]),
		Text@(P[m]),
		Text@(Def^2==P[m]*P[-m]),
		Text@(V[m]==P[m]/Def)}},
		ItemSize->Large,
		Dividers->Center,
		Alignment->Left];

	TheDecompositionTable=DecompositionTable[FieldTensors,
		FieldTensorsSymmetries,
		FieldTensorsDecomposed,
		SourceTensors];

	DecompositionExpansionTable=NewFramed@Grid[
		(
		TheDecompositionTable~Join~TheExpansionTable
		),
		ItemSize->{Full,Full,{1,3}->60},
		Dividers->Center,
		Alignment->{Left,Center}];

	If[!$CLI,
		TheFieldMosaic=FieldMosaic[
					DecompositionExpansionTable
					];
		If[!$NoExport,
			Export[FileNameJoin@{$WorkingDirectory,"FieldKinematics"<>(StringReplace[Context[],{"xAct"->"","PSALTer"->"","`"->""}])<>".pdf"},
				TheFieldMosaic
			];
		];
		Print@TheFieldMosaic;
	];
];
