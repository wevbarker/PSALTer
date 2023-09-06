(*===========================*)
(*  ScalarGaussBonnetTheory  *)
(*===========================*)

Section@"Scalar-Gauss-Bonnet theory";

Comment@"Here is the PECT parameter.";
DefConstantSymbol[Pw,PrintAs->"\[Lambda]"];
DisplayExpression@Pw;

Comment@"Define a Planck mass.";
DefConstantSymbol[MPl,PrintAs->"\(\*SubscriptBox[\(\[ScriptCapitalM]\), \(Pl\)]\)"];
DisplayExpression@MPl;

Comment@"Now we think about expanding the scalar around a constant background.";
DefConstantSymbol[Phi0,PrintAs->"\(\*SubscriptBox[\(\[Phi]\), \(0\)]\)"];
DisplayExpression@Phi0;

Comment@"Next think of a rule to rescale the Planck mass.";
DisplayExpression[{MPl->Sqrt[xAct`PSALTer`ScalarTensorTheory`Coupling1]/Phi0^(Pw/2)},EqnLabel->"MPlRescale"];
Comment@"Next think of a rule to rescale the quadratic Ricci scalar coupling.";
DisplayExpression[{xAct`PSALTer`ScalarTensorTheory`Coupling5->xAct`PSALTer`ScalarTensorTheory`Coupling5/Phi0^2},EqnLabel->"Coupling5Rescale"];
Comment@"Next think of a rule to rescale the quadratic Ricci tensor coupling.";
DisplayExpression[{xAct`PSALTer`ScalarTensorTheory`Coupling6->xAct`PSALTer`ScalarTensorTheory`Coupling6/Phi0^2},EqnLabel->"Coupling6Rescale"];
Comment@"Next think of a rule to rescale the quadratic Riemann tensor coupling.";
DisplayExpression[{xAct`PSALTer`ScalarTensorTheory`Coupling7->xAct`PSALTer`ScalarTensorTheory`Coupling7/Phi0^2},EqnLabel->"Coupling7Rescale"];
Comment@"Next a rescaling of the dynamical scalar.";
DisplayExpression[{ScalarTensorPhi[]->ScalarTensorPhi[]*Phi0},EqnLabel->"PhiRescale"];
Comment@"Finally a rescaling of the kinetic term coefficient of the scalar.";
DisplayExpression[{xAct`PSALTer`ScalarTensorTheory`Coupling2->xAct`PSALTer`ScalarTensorTheory`Coupling2*Phi0^(-(Pw+2))},EqnLabel->"Phi0Rescale"];

Comment@{"So in summary, if we impose",Cref@{"Coupling5Rescale","Coupling6Rescale","Coupling7Rescale","PhiRescale","Phi0Rescale"}," on the linearised lagrangian, we can get it into the following form."};
LinearisedLagrangian=Get@FileNameJoin@{NotebookDirectory[],"Calibration","ScalarTensorTheory","ScalarGaussBonnetTheory","GeneralLambda.txt"};
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
DisplayExpression[LinearisedLagrangian,EqnLabel->"QuoteGeneralCase"];
GeneralLinearisedLagrangian=LinearisedLagrangian;

Get@FileNameJoin@{NotebookDirectory[],"Calibration","ScalarTensorTheory",
				"ScalarGaussBonnetTheory","GeneralLambda1.m"};
Get@FileNameJoin@{NotebookDirectory[],"Calibration","ScalarTensorTheory",
				"ScalarGaussBonnetTheory","GeneralLambda2.m"};
Get@FileNameJoin@{NotebookDirectory[],"Calibration","ScalarTensorTheory",
				"ScalarGaussBonnetTheory","GeneralLambda3.m"};

Comment@"So if we change the PECT parameter, we change the formulae for masses and residues, but the physics of the spectrum is unchanged. That looks promising. The point here is that without tuning the quadratic sector to be GB, the spectrum is not good.";

Comment@"Here are the rules which we will use to impose the scalar-Gauss-Bonnet theory.";
ImposeGaussBonnet={
	xAct`PSALTer`ScalarTensorTheory`Coupling5->
		xAct`PSALTer`ScalarTensorTheory`Coupling5,
	xAct`PSALTer`ScalarTensorTheory`Coupling6->
		xAct`PSALTer`ScalarTensorTheory`Coupling5,
	xAct`PSALTer`ScalarTensorTheory`Coupling7->
		xAct`PSALTer`ScalarTensorTheory`Coupling5};
DisplayExpression@ImposeGaussBonnet;

Get@FileNameJoin@{NotebookDirectory[],"Calibration","ScalarTensorTheory",
				"ScalarGaussBonnetTheory","SpecialLambda1.m"};
Get@FileNameJoin@{NotebookDirectory[],"Calibration","ScalarTensorTheory",
				"ScalarGaussBonnetTheory","SpecialLambda2.m"};
Get@FileNameJoin@{NotebookDirectory[],"Calibration","ScalarTensorTheory",
				"ScalarGaussBonnetTheory","SpecialLambda3.m"};

Comment@"So with GB tuning the spectrum is healthy, up to some nuances over the couplings. I don't have time to translate these back from alphas into the original constants, but I suspect it will be possible to track down the precise form of the unitarity conditions in terms of the PECT parameter.";
