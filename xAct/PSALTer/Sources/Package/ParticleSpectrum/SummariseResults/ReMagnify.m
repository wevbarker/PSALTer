(*=============*)
(*  ReMagnify  *)
(*=============*)

ReMagnify[Object_]:=Module[{
	FullWidth,
	DesiredWidth,
	ActualWidth,
	RequiredMagnification},

	FullWidth=First@Rasterize[Show[Graphics[Circle[]],ImageSize->Full],"RasterSize"];
	DesiredWidth=0.9*FullWidth;
	ActualWidth=First@Rasterize[Object,"RasterSize"];
	RequiredMagnification=Piecewise[{{1,ActualWidth<=DesiredWidth},{DesiredWidth/ActualWidth,ActualWidth>DesiredWidth}}];
Magnify[Object,RequiredMagnification]];
