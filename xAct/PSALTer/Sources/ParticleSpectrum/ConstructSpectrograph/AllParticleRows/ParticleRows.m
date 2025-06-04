(*================*)
(*  ParticleRows  *)
(*================*)

IncludeHeader@"ParticleRow";
IncludeHeader@"StripFactors";
IncludeHeader@"ProtractList";

ParticleRows[
		SquareMasses_,
		MassivePropagatorResidues_,
		MasslessEigenvalues_,
		QuarticAnalysisValue_,
		HexicAnalysisValue_,
		SecularEquation_]~Y~Module[{ContentList},

		NewMassivePropagatorResidues=MassivePropagatorResidues//ProtractList;
		NewSquareMasses=SquareMasses//ProtractList;
		Diagnostic@NewMassivePropagatorResidues;
		Diagnostic@NewSquareMasses;

	ContentList=(
		((MapThread[If[!(#1==={}),
					ParticleRow[#1,#2,#4,#3,2*#4+1,0],
					0
			]&,{
				NewMassivePropagatorResidues,
				NewSquareMasses,
				{1,-1,0,1,-1,0,1,-1,0,1,-1,0}~Take~Length@NewSquareMasses,
				{0,0,0,1,1,1,2,2,2,3,3,3}~Take~Length@NewSquareMasses
		}]~Flatten~1)~DeleteCases~0)
		)~Join~(
		Join[
			(ParticleRow[First@#,0,0,0,Length@#,1]&/@Gather@(StripFactors/@MasslessEigenvalues)),
			(ParticleRow[First@#,0,0,0,Length@#,2]&/@Gather@(StripFactors/@QuarticAnalysisValue)),
			(ParticleRow[First@#,0,0,0,Length@#,3]&/@Gather@(StripFactors/@HexicAnalysisValue))
		]
	);
ContentList];
