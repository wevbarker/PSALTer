(*==================*)
(*  GraphicsMosaic  *)
(*==================*)

IncludeHeader@"ShrinkPackRectangles";

GraphicsMosaic[InputExpr_?ListQ,MosaicWidth_?IntegerQ]:=Module[{
		GraphicsDimensions,
		MaxWidth,
		PackedGraphicsDimensions,
		FrameSize,
		Packing,
		Flipped,
		GraphicsContent,
		PackedGraphicsCoordinates,
		ScalingError,
		FinalGraphicsMosaic},

	GraphicsDimensions=ImageDimensions/@(InputExpr);
	MaxWidth=Max@{MosaicWidth,500};
	If[MaxWidth>2000,
		FrameSize={Ceiling[5.*#],Ceiling[1.01*#]}&@(MaxWidth);,
		FrameSize={Ceiling[5.*#],Ceiling[1.9*#]}&@(MaxWidth);
	];
	{FrameSize,Packing}=ShrinkPackRectangles[FrameSize,GraphicsDimensions];
	MosaicSize=Max/@Transpose@((#[[2]])&/@Packing);
	DummyPacking=Graphics[{FaceForm[LightYellow],
				EdgeForm[Black],
				{LightBlue,
				Rectangle[{0,0},FrameSize],
				LightYellow}~Join~(Rectangle@@@Packing)},
				Frame->True];
	PackedGraphicsDimensions=(Minus@(Subtract@@#))&/@Packing;
	Permutation=(Sort/@GraphicsDimensions)~FindPermutation~(Sort/@PackedGraphicsDimensions);
	Flipped=MapThread[(If[#1==#2,False,True,True])&,
				{GraphicsDimensions~Permute~Permutation,PackedGraphicsDimensions}];
	GraphicsContent=(If[#2,Rotate[#1,Pi/2],#1])&~MapThread~{InputExpr~Permute~Permutation,
								Flipped};
	PackedGraphicsCoordinates=(N/@Simplify@((1/2)*Plus@@#))&/@Packing;
	Insets=MapThread[Inset[Magnify[#1,0.95],#2]&,
				{GraphicsContent,PackedGraphicsCoordinates}];
	MakeGraphicsMosaic[Insets_,ImageSizeScale_]:=Graphics[Insets,
			Background->$PanelColor,
			Frame->False,
			PlotRange->{{0,MosaicSize[[1]]},{0,MosaicSize[[2]]}},
			ImagePadding->None,
			ImageSize->ImageSizeScale*MosaicSize];
	FinalGraphicsMosaic=MakeGraphicsMosaic[Insets,1];
	ScalingError=(N@(#1/#2))&~MapThread~{MosaicSize,ImageDimensions@FinalGraphicsMosaic};
	ScalingError//=Total;
	ScalingError/=2;
	FinalGraphicsMosaic=MakeGraphicsMosaic[Insets,ScalingError];
	If[(ImageDimensions@FinalGraphicsMosaic)[[2]]>=(ImageDimensions@FinalGraphicsMosaic)[[1]],
		FinalGraphicsMosaic//=Rotate[#,-Pi/2]&];

FinalGraphicsMosaic];
