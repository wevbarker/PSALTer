(*===========================*)
(*  ParticleSpectrumSummary  *)
(*===========================*)

ParticleSpectrumSummary[MassiveAnalysis_,MassiveGhostAnalysis_,MasslessAnalysisValue_]:=Module[{
	SpinParitySectors,
	CillianArgument},

	SpinParitySectors={
		"\!\(\*SuperscriptBox[\(0\),\(+\)]\)",
		"\!\(\*SuperscriptBox[\(0\),\(-\)]\)",
		"\!\(\*SuperscriptBox[\(1\),\(+\)]\)",
		"\!\(\*SuperscriptBox[\(1\),\(-\)]\)",
		"\!\(\*SuperscriptBox[\(2\),\(+\)]\)",
		"\!\(\*SuperscriptBox[\(2\),\(-\)]\)"
	};	

	CillianArgument=(If[!(#1==={}),{First@#2,#3,First@#1}]&)~MapThread~{MassiveAnalysis,MassiveGhostAnalysis,SpinParitySectors};

	CillianArgument~AppendTo~(If[!(MasslessAnalysisValue==={}),{First@MasslessAnalysisValue},{}]);
	CillianArgument=CillianArgument~DeleteCases~Null;
	
CillianArgument];
