(*========================*)
(*  ShrinkPackRectangles  *)
(*========================*)

ShrinkPackRectangles[FrameSize_,GraphicsDimensions_]:=Module[{
	TheFrameSize=FrameSize,
	Packing,
	Unpacked=True},

	While[Unpacked,
		TheFrameSize[[1]]*=0.9;
		TheFrameSize[[1]]//=Floor;
		Packing=Quiet@PackRectangles[TheFrameSize,
				GraphicsDimensions,Method->$MaxRectangles];
		If[(Head/@Packing)~MemberQ~Failure,
			Unpacked=False;
			TheFrameSize[[1]]/=0.9;
			TheFrameSize[[1]]//=Ceiling;
			Packing=Quiet@PackRectangles[TheFrameSize,
					GraphicsDimensions,Method->$MaxRectangles];
		];
	];
{FrameSize,Packing}];
