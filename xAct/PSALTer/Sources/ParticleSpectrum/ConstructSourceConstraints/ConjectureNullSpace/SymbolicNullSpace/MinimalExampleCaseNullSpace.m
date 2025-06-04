(*===============================*)
(*  MinimalExampleCaseNullSpace  *)
(*===============================*)

MinimalExampleCaseNullSpace[InputMatrix_,NumericalCouplingRules_]~Y~(Normalize/@NullSpace@FullSimplify@(InputMatrix/.NumericalCouplingRules));
