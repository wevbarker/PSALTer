(*===============================*)
(*  RegisterFieldRank2Symmetric  *)
(*===============================*)

xAct`PSALTer`Private`DefFiducialField[Rank2Symmetric[-a,-b],Symmetric[{-a,-b}]];
xAct`PSALTer`Private`DefSO3Irrep[Rank2SymmetricPara0p[],xAct`PSALTer`Private`Spin->0,xAct`PSALTer`Private`Parity->xAct`PSALTer`Private`Even];
xAct`PSALTer`Private`DefSO3Irrep[Rank2SymmetricPara2p[-a,-b],Symmetric[{-a,-b}],xAct`PSALTer`Private`Spin->2,xAct`PSALTer`Private`Parity->xAct`PSALTer`Private`Even];
xAct`PSALTer`Private`DefSO3Irrep[Rank2SymmetricPerp0p[],xAct`PSALTer`Private`Spin->0,xAct`PSALTer`Private`Parity->xAct`PSALTer`Private`Even];
xAct`PSALTer`Private`DefSO3Irrep[Rank2SymmetricPerp1m[-a],xAct`PSALTer`Private`Spin->1,xAct`PSALTer`Private`Parity->xAct`PSALTer`Private`Odd];

DefTensor[ProjPerp[-a,-b],M4,Symmetric[{-a,-b}]];
DefTensor[ProjPara[-a,-b],M4,Symmetric[{-a,-b}]];
ProjPerpParaToVG=Join[
	MakeRule[{ProjPerp[-a,b],Evaluate[V[-a]V[b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjPara[-a,b],Evaluate[G[-a,b]-V[-a]V[b]]},MetricOn->All,ContractMetrics->True]];

ExpandFieldsRules=Join[
	MakeRule[{Rank2SymmetricPerp0p[],Evaluate[
		ProjPerp[a,b]Rank2Symmetric[-a,-b]/.ProjPerpParaToVG//ToCanonical]},
		MetricOn->All,ContractMetrics->True],
	MakeRule[{Rank2SymmetricPerp1m[-a],Evaluate[
		V[b]ProjPara[-a,c]Rank2Symmetric[-c,-b]/.ProjPerpParaToVG//ToCanonical]},
		MetricOn->All,ContractMetrics->True],
	MakeRule[{Rank2SymmetricPara0p[],Evaluate[
		ProjPara[a,b]Rank2Symmetric[-a,-b]/.ProjPerpParaToVG//ToCanonical]},
		MetricOn->All,ContractMetrics->True],
	MakeRule[{Rank2SymmetricPara2p[-a,-b],Evaluate[
		(ProjPara[-a,c]ProjPara[-b,d]-(1/3)*ProjPara[-a,-b]ProjPara[c,d])*Rank2Symmetric[-c,-d]/.ProjPerpParaToVG//ToCanonical]},
		MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank2SymmetricPerp0p[],Evaluate@Dagger[
		ProjPerp[a,b]Rank2Symmetric[-a,-b]/.ProjPerpParaToVG//ToCanonical]},
		MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank2SymmetricPerp1m[-a],Evaluate@Dagger[
		V[b]ProjPara[-a,c]Rank2Symmetric[-c,-b]/.ProjPerpParaToVG//ToCanonical]},
		MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank2SymmetricPara0p[],Evaluate@Dagger[
		ProjPara[a,b]Rank2Symmetric[-a,-b]/.ProjPerpParaToVG//ToCanonical]},
		MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank2SymmetricPara2p[-a,-b],Evaluate@Dagger[
		(ProjPara[-a,c]ProjPara[-b,d]-(1/3)*ProjPara[-a,-b]ProjPara[c,d])*Rank2Symmetric[-c,-d]/.ProjPerpParaToVG//ToCanonical]},
		MetricOn->All,ContractMetrics->True]];
ExpandSourcesRules=Join[
	MakeRule[{SourceRank2SymmetricPerp0p[],Evaluate[
		ProjPerp[a,b]SourceRank2Symmetric[-a,-b]/.ProjPerpParaToVG//ToCanonical]},
		MetricOn->All,ContractMetrics->True],
	MakeRule[{SourceRank2SymmetricPerp1m[-a],Evaluate[
		V[b]ProjPara[-a,c]SourceRank2Symmetric[-c,-b]/.ProjPerpParaToVG//ToCanonical]},
		MetricOn->All,ContractMetrics->True],
	MakeRule[{SourceRank2SymmetricPara0p[],Evaluate[
		ProjPara[a,b]SourceRank2Symmetric[-a,-b]/.ProjPerpParaToVG//ToCanonical]},
		MetricOn->All,ContractMetrics->True],
	MakeRule[{SourceRank2SymmetricPara2p[-a,-b],Evaluate[
		(ProjPara[-a,c]ProjPara[-b,d]-(1/3)*ProjPara[-a,-b]ProjPara[c,d])*SourceRank2Symmetric[-c,-d]/.ProjPerpParaToVG//ToCanonical]},
		MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank2SymmetricPerp0p[],Evaluate@Dagger[
		ProjPerp[a,b]SourceRank2Symmetric[-a,-b]/.ProjPerpParaToVG//ToCanonical]},
		MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank2SymmetricPerp1m[-a],Evaluate@Dagger[
		V[b]ProjPara[-a,c]SourceRank2Symmetric[-c,-b]/.ProjPerpParaToVG//ToCanonical]},
		MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank2SymmetricPara0p[],Evaluate@Dagger[
		ProjPara[a,b]SourceRank2Symmetric[-a,-b]/.ProjPerpParaToVG//ToCanonical]},
		MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank2SymmetricPara2p[-a,-b],Evaluate@Dagger[
		(ProjPara[-a,c]ProjPara[-b,d]-(1/3)*ProjPara[-a,-b]ProjPara[c,d])*SourceRank2Symmetric[-c,-d]/.ProjPerpParaToVG//ToCanonical]},
		MetricOn->All,ContractMetrics->True]];
DecomposeFieldsRules=Join[
	MakeRule[{Rank2Symmetric[-a,-b],Evaluate[
		(
			Rank2SymmetricPerp0p[]V[-a]V[-b]
			+Rank2SymmetricPerp1m[-a]V[-b]
			+Rank2SymmetricPerp1m[-b]V[-a]
			+(1/3)*Rank2SymmetricPara0p[]ProjPara[-a,-b]
			+Rank2SymmetricPara2p[-a,-b]
		)/.ProjPerpParaToVG//ToCanonical
	]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank2Symmetric[-a,-b],Evaluate@Dagger[
		(
			Rank2SymmetricPerp0p[]V[-a]V[-b]
			+Rank2SymmetricPerp1m[-a]V[-b]
			+Rank2SymmetricPerp1m[-b]V[-a]
			+(1/3)*Rank2SymmetricPara0p[]ProjPara[-a,-b]
			+Rank2SymmetricPara2p[-a,-b]
		)/.ProjPerpParaToVG//ToCanonical
	]},MetricOn->All,ContractMetrics->True]];
SourceRank2SymmetricToSourceRank2SymmetricSpinParity=Join[
	MakeRule[{SourceRank2Symmetric[-a,-b],Evaluate[
		(
			SourceRank2SymmetricPerp0p[]V[-a]V[-b]
			+SourceRank2SymmetricPerp1m[-a]V[-b]
			+SourceRank2SymmetricPerp1m[-b]V[-a]
			+(1/3)*SourceRank2SymmetricPara0p[]ProjPara[-a,-b]
			+SourceRank2SymmetricPara2p[-a,-b]
		)/.ProjPerpParaToVG//ToCanonical
	]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank2Symmetric[-a,-b],Evaluate@Dagger[
		(
			SourceRank2SymmetricPerp0p[]V[-a]V[-b]
			+SourceRank2SymmetricPerp1m[-a]V[-b]
			+SourceRank2SymmetricPerp1m[-b]V[-a]
			+(1/3)*SourceRank2SymmetricPara0p[]ProjPara[-a,-b]
			+SourceRank2SymmetricPara2p[-a,-b]
		)/.ProjPerpParaToVG//ToCanonical
	]},MetricOn->All,ContractMetrics->True]];
xAct`PSALTer`Private`CombineRules[ExpandFieldsRules,
			ExpandSourcesRules,
			DecomposeFieldsRules];
