(*==============*)
(*  WignerGrid  *)
(*==============*)

WignerGrid[AllMatrices_,Sizes_,Spins_,Sides_,Tops_]:=Module[{
	SpinParities,
	TheSides,
	TheTops,
	Mask,
	AllElements,
	EndCells,
	StartCells,
	Frames,
	InnerFrames,
	Cols
	},


	SpinParities=Table[Superscript[ToString@i,j],{i,Spins},{j,{"+","-"}}]~Take~Length@Spins;
	TheSides=Sides~Take~Length@Spins;
	TheTops=Tops~Take~Length@Spins;
	Mask=ArrayPad[Normal@BlockDiagonalMatrix@Map[(True)&,AllMatrices,{3}],{{1,0},{1,0}}]/.{0->False};
	AllElements=Normal@BlockDiagonalMatrix@AllMatrices;
	AllElements=ArrayPad[AllElements,{{1,0},{1,0}}];
	AllElements=MapThread[If[#2,#1,Null]&,{AllElements,Mask},2];

	EndCells=(Accumulate@Flatten@Sizes)~Partition~2;
	StartCells=EndCells-(Sizes/.{0->1});
	StartCells=Map[(#+1)&,StartCells,{2}];

	Alignments={};

	MapThread[
	(
	Which[
	#4[[1]]==0,
		Table[Alignments=Alignments~Join~{{#1[[2]]+j,#1[[1]]+1}->{Right,Center}},{j,Length@#5}];
		Table[Alignments=Alignments~Join~{{#1[[1]]+1,#1[[2]]+j}->{Center,Bottom}},{j,Length@#5}];
		Table[AllElements[[#1[[2]]+j,#1[[1]]+1]]=#5[[j]],{j,Length@#5}];
		Table[AllElements[[#1[[1]]+1,#1[[2]]+j]]=#6[[j]],{j,Length@#6}];,
	#4[[2]]==0,
		Table[Alignments=Alignments~Join~{{#1[[1]]+j,#1[[1]]}->{Right,Center}},{j,Length@#5}];
		Table[Alignments=Alignments~Join~{{#1[[1]],#1[[1]]+j}->{Center,Bottom}},{j,Length@#5}];
		Table[AllElements[[#1[[1]]+j,#1[[1]]]]=#5[[j]],{j,Length@#5}];
		Table[AllElements[[#1[[1]],#1[[1]]+j]]=#6[[j]],{j,Length@#6}];,
	(!(#4[[1]]==0))&&(!(#4[[2]]==0)),
		Table[Alignments=Alignments~Join~{{#1[[1]]+j,#1[[1]]}->{Right,Center}},{j,Length@#5}];
		Table[Alignments=Alignments~Join~{{#1[[1]],#1[[1]]+j}->{Center,Bottom}},{j,Length@#5}];
		Table[AllElements[[#1[[1]]+j,#1[[1]]]]=#5[[j]],{j,Length@#5}];
		Table[AllElements[[#1[[1]],#1[[1]]+j]]=#6[[j]],{j,Length@#6}];
	];
	)&,
	{StartCells,EndCells,SpinParities,Sizes,TheSides,TheTops},1];

	OuterDirective=Directive[Black,Thick];
	InnerDirective=Directive[Black,Thickness@Medium];

	Frames=MapThread[
	(
	Which[
	#3[[1]]==0,
		{
		{{#1[[2]]+1,#2[[2]]+1},{#1[[2]]+1,#2[[2]]+1}}->OuterDirective
		},
	#3[[2]]==0,
		{
		{{#1[[1]]+1,#2[[1]]+1},{#1[[1]]+1,#2[[1]]+1}}->OuterDirective
		},
	(!(#3[[1]]==0))&&(!(#3[[2]]==0)),
		{
		{{#1[[1]]+1,#2[[2]]+1},{#1[[1]]+1,#2[[2]]+1}}->OuterDirective,
		{{#1[[1]]+1,#2[[1]]+1},{#1[[1]]+1,#2[[1]]+1}}->OuterDirective,
		{{#1[[2]]+1,#2[[2]]+1},{#1[[2]]+1,#2[[2]]+1}}->OuterDirective
		}
	]
	)&,
	{StartCells,EndCells,Sizes}
	];
	Frames//=Flatten;

	InnerFrames=MapThread[
	(
	Which[
	#3[[1]]==0,
		Table[
		{
		{{#1[[2]]+1,#2[[2]]+1},{#1[[2]]+1,qf}}->InnerDirective,
		{{#1[[2]]+1,qf},{#1[[2]]+1,#2[[2]]+1}}->InnerDirective
		},
		{qf,#1[[2]]+1,#2[[2]]+1}]
		,
	#3[[2]]==0,
		Table[
		{
		{{#1[[1]]+1,#2[[1]]+1},{#1[[1]]+1,qf}}->InnerDirective,
		{{#1[[1]]+1,qf},{#1[[1]]+1,#2[[1]]+1}}->InnerDirective
		},
		{qf,#1[[1]]+1,#2[[1]]+1}],
	(!(#3[[1]]==0))&&(!(#3[[2]]==0)),
		Table[
		{
		{{#1[[1]]+1,#2[[2]]+1},{#1[[1]]+1,qf}}->InnerDirective,
		{{#1[[1]]+1,qf},{#1[[1]]+1,#2[[2]]+1}}->InnerDirective
		},
		{qf,#1[[1]]+1,#2[[2]]+1}]
	]
	)&,
	{StartCells,EndCells,Sizes}
	];
	InnerFrames//=Flatten;

	Cols=MapThread[
	(
	Which[
	#3[[1]]==0,
		Table[{i,j}->$ParityOddColor,{i,#1[[2]]+1,#2[[2]]+1},{j,#1[[2]]+1,#2[[2]]+1}],
	#3[[2]]==0,
		Table[{i,j}->$ParityEvenColor,{i,#1[[1]]+1,#2[[1]]+1},{j,#1[[1]]+1,#2[[1]]+1}],
	(!(#3[[1]]==0))&&(!(#3[[2]]==0)),
		Join[
		Table[{i,j}->$ParityEvenColor,{i,#1[[1]]+1,#2[[1]]+1},{j,#1[[1]]+1,#2[[1]]+1}],
		Table[{i,j}->$ParityOddColor,{i,#1[[2]]+1,#2[[2]]+1},{j,#1[[2]]+1,#2[[2]]+1}],
		Table[{i,j}->$ParityMixColor,{i,#1[[1]]+1,#2[[1]]+1},{j,#1[[2]]+1,#2[[2]]+1}],
		Table[{i,j}->$ParityMixColor,{i,#1[[2]]+1,#2[[2]]+1},{j,#1[[1]]+1,#2[[1]]+1}]
		]
	]
	)&,
	{StartCells,EndCells,Sizes}
	];
	Cols//=Flatten;
	Frames=InnerFrames~Join~Frames;

	NewFramed@Grid[Map[If[#==Null,Null,Text@#,Text@#]&,AllElements,{2}],Background->{None,None,Cols},Frame->{None,None,Frames},Alignment->{Center,Center,Alignments},ItemSize->Full]];