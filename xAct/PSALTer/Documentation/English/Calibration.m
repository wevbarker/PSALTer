(*===============*)
(*  Calibration  *)
(*===============*)

<<xAct`xPlain`;

Title@"PSALTer Calibration";

Subsection@"About xPlain and formatting";

Comment@"Welcome to the calibration file for the PSALTer package. Commentary is provided in this green text throughout by virtue of the xPlain package.";

Expression@"xPlain also allows you to format numbered equations.";

Supercomment@"Occasionally, more important points will be highlighted in boxes like this.";

Comment@"The xPlain package is not part of PSALTer, so the output from PSALTer itself will contrast with this formatting and be quite distinctive.";

Subsection@"The structure of this file";

Comment@"The calibration file runs PSALTer on a very long list of theories, whose particle spectra are already known.";

Comment@"The first step is to load the PSALTer package.";

<<xAct`PSALTer`;

(*For when we want to only run the commentary part of the script*)
(*
Unprotect@xAct`PSALTer`ParticleSpectrum;
ClearAll@xAct`PSALTer`ParticleSpectrum;
Protect@xAct`PSALTer`ParticleSpectrum;
*)

(*Global settings for xAct*)
$DefInfoQ=False;
Unprotect@AutomaticRules;
Options[AutomaticRules]={Verbose->False};
Protect@AutomaticRules;

(*Global settings for PSALTer*)
$DiagnosticMode=False;
$MonitorParallel=False;
$ExportPDF=True;

Comment@"Great, so PSALTer is now loaded and we can start to do some science.";

Get@FileNameJoin@{NotebookDirectory[],"Calibration","ScalarTheory.m"};
Get@FileNameJoin@{NotebookDirectory[],"Calibration","VectorTheory.m"};
Get@FileNameJoin@{NotebookDirectory[],"Calibration","TensorTheory.m"};
Get@FileNameJoin@{NotebookDirectory[],"Calibration","ScalarTensorTheory.m"};
Get@FileNameJoin@{NotebookDirectory[],"Calibration","PoincareGaugeTheory.m"};
Get@FileNameJoin@{NotebookDirectory[],"Calibration","ErrorMessages.m"};

Supercomment@"We have now reached the end of the PSALTer calibration script.";

Quit[];
