(*==============================*)
(*  RemoveReferencesToMomentum  *)
(*==============================*)

RemoveReferencesToMomentum[InputMatrix_,Couplings_]:=Module[{
	FieldRescaledMatrix=InputMatrix,
	ConstantRescalingPowers,
	ConstantRescalingRules,
	ConstantDescalingRules,
	FieldRescalingPowers,
	FieldRescalingMatrix,
	FieldDescalingMatrix,
	ScalingSolutions,
	UnsolvedScalingSolutions
	},

	ConstantRescalingPowers=Table[ToExpression@("ConstantRescalingPower"<>ToString@ii),{ii,Length@Couplings}];
	ConstantRescalingRules=MapThread[(#1->#1*xAct`PSALTer`Def^#2)&,{Couplings,ConstantRescalingPowers}];
	ConstantDescalingRules=MapThread[(#1->#1*xAct`PSALTer`Def^-#2)&,{Couplings,ConstantRescalingPowers}];

	FieldRescalingPowers=Table[ToExpression@("FieldRescalingPower"<>ToString@ii),{ii,Length@InputMatrix}];
	FieldRescalingMatrix=DiagonalMatrix@((xAct`PSALTer`Def^#)&/@FieldRescalingPowers);
	FieldDescalingMatrix=DiagonalMatrix@((xAct`PSALTer`Def^-#)&/@FieldRescalingPowers);

	FieldRescaledMatrix=FieldRescalingMatrix.FieldRescaledMatrix.FieldRescalingMatrix/.ConstantRescalingRules;

	ScalingSolutions=Flatten@FieldRescaledMatrix;
	ScalingSolutions//=(PowerExpand/@#)&;
	ScalingSolutions//=(Expand[#,xAct`PSALTer`Def]&/@#)&;
	ScalingSolutions//=(CreateList/@#)&;
	ScalingSolutions//=Flatten;
	ScalingSolutions//=(((PowerExpand@Log@#)~Coefficient~Log@xAct`PSALTer`Def)&/@#)&;
	ScalingSolutions//=Flatten;
	ScalingSolutions//=((#==0)&/@#)&;
	ScalingSolutions//=DeleteDuplicates;
	ScalingSolutions//=(#~DeleteElements~{True})&;
	ScalingSolutions//=(First@Quiet@Solve[#,ConstantRescalingPowers~Join~FieldRescalingPowers])&;

	UnsolvedScalingSolutions=DeleteDuplicates@Flatten@(Variables/@((ConstantRescalingPowers~Join~FieldRescalingPowers)/.ScalingSolutions));
	UnsolvedScalingSolutions//=((#->-(2*3*5*7*11)^10)&/@#)&;
	ScalingSolutions//=(#/.UnsolvedScalingSolutions)&;
	ScalingSolutions//=FullSimplify;
	ScalingSolutions//=(#~Join~UnsolvedScalingSolutions)&;

	FieldRescaledMatrix=FieldRescaledMatrix/.ScalingSolutions;
	FieldRescaledMatrix//=PowerExpand;
	FieldRescaledMatrix//=FullSimplify;

{FieldRescaledMatrix,ConstantDescalingRules,FieldRescalingMatrix,ScalingSolutions}];
