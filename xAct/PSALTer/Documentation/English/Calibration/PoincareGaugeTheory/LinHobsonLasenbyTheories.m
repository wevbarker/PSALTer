(*============================*)
(*  LinHobsonLasenbyTheories  *)
(*============================*)

Section@"Power-counting renormalisable and unitary catalogue";

Get@FileNameJoin@{NotebookDirectory[],"Calibration","PoincareGaugeTheory",
					"LinHobsonLasenbyTheories","CriticalCases.m"};
Get@FileNameJoin@{NotebookDirectory[],"Calibration","PoincareGaugeTheory",
					"LinHobsonLasenbyTheories","Unitarity.m"};

Off[Solve::svars];
CriticalCasesSolutions=First/@(Solve[#,{kR1,kR2,kR3,kR4,kR5,kT1,kT2,kT3,kLambda}]&/@CriticalCases);
On[Solve::svars];

Comment@"We now evaluate the 58 theories in arXiv:1910.14197.";

Get@FileNameJoin@{NotebookDirectory[],"Calibration","PoincareGaugeTheory",
					"LinHobsonLasenbyTheories","CalibrateCase.m"};

CalibrationTimingData=MapThread[
		AbsoluteTiming@CalibrateCase[#1,#2,#3]&,
		{
			Table[i,{i,1,58}],
			CriticalCasesSolutions[[1;;58]],
			Unitarity[[1;;58]]
		}];
(*
Section@"How long did this take?";
Comment@"Okay, that's all the cases. You can see from the timing below (in seconds) that each theory takes about a minute to process:";
DisplayExpression@CalibrationTimingData;
*)
