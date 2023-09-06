(*===========================*)
(*  MakeFreeSourceVariables  *)
(*===========================*)

MakeFreeSourceVariables[NullSpace_List,SourceComponents_List]:=Module[{
	NullSpaceDimension,
	FreeSourceVariables,
	SourceComponentsAsFreeSourceVariables,
	SourceComponentsToFreeSourceVariables},

	NullSpaceDimension=(Dimensions@NullSpace)[[1]];
	FreeSourceVariables=Table[Symbol["X"<>ToString@i],{i,NullSpaceDimension}];
	SourceComponentsAsFreeSourceVariables=(Transpose@FreeSourceVariables) . NullSpace;
	SourceComponentsToFreeSourceVariables=Flatten@MapThread[#1->#2&,{SourceComponents,SourceComponentsAsFreeSourceVariables}];
	SourceComponentsToFreeSourceVariables=SourceComponentsToFreeSourceVariables~Join~Flatten@MapThread[Evaluate@Dagger@#1->Evaluate@Dagger@#2&,{SourceComponents,SourceComponentsAsFreeSourceVariables}];
SourceComponentsToFreeSourceVariables];
