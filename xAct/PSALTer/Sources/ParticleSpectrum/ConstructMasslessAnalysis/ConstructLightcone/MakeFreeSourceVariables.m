(*===========================*)
(*  MakeFreeSourceVariables  *)
(*===========================*)

IncludeHeader@"DefFreeSourceVariables";

MakeFreeSourceVariables[NullSpace_List,SourceComponents_List]:=Module[{
	NullSpaceDimension,
	FreeSourceVariables,
	SourceComponentsAsFreeSourceVariables,
	SourceComponentsToFreeSourceVariables},

	NullSpaceDimension=(Dimensions@NullSpace)[[1]];
	Diagnostic@NullSpaceDimension;
	DefFreeSourceVariables@NullSpaceDimension;
	Map[
		(xAct`PSALTer`Private`NewParallelSubmit@(DefFreeSourceVariables[#]))&,
		NullSpaceDimension~Table~$KernelCount];
	FreeSourceVariables=Table[Symbol["xAct`PSALTer`Private`X"<>ToString@i],
		{i,NullSpaceDimension}];
	Diagnostic@FreeSourceVariables;
	SourceComponentsAsFreeSourceVariables=(Transpose@FreeSourceVariables) . NullSpace;
	Diagnostic@SourceComponentsAsFreeSourceVariables;
	SourceComponentsToFreeSourceVariables=Flatten@MapThread[#1->#2&,
		{SourceComponents,SourceComponentsAsFreeSourceVariables}];
	Diagnostic@SourceComponentsToFreeSourceVariables;
	SourceComponentsToFreeSourceVariables=SourceComponentsToFreeSourceVariables~Join~Flatten@MapThread[Evaluate@Dagger@#1->Evaluate@Dagger@#2&,
		{SourceComponents,SourceComponentsAsFreeSourceVariables}];
	Diagnostic@SourceComponentsToFreeSourceVariables;
SourceComponentsToFreeSourceVariables];
