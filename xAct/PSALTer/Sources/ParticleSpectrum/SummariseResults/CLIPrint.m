(*============*)
(*  CLIPrint  *)
(*============*)

IncludeHeader@"Status";

CLIPrint[TheoryName_?StringQ,WaveOperator_,Propagator_,SourceConstraints_,Spectrum_,MasslessSpectrum_,OverallUnitarity_]:=Module[{
	TextTotal,
	TextASCIILogo=Import@FileNameJoin@{$InstallDirectory,"Logos","ASCIILogo.txt"}},
TextTotal=StringJoin@@{
TextASCIILogo,
"
Theory name........................",
TheoryName,
"
Wave operator......................",
Status@WaveOperator,
"
Saturated propagator...............",
Status@Propagator,
"
Source constraints.................",
Status@SourceConstraints,
"
Massive spectrum...................",
Status@Spectrum,
"
Massless spectrum..................",
Status@MasslessSpectrum,
"
Unitarity conditions...............",
Status@OverallUnitarity};
TextTotal];
