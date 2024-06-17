(*======================*)
(*  ValidateLagrangian  *)
(*======================*)

ParticleSpectrum::Zero="The Lagrangian density is zero.";
ParticleSpectrum::NonLinearCouplings="The method \"Hard\" was selected but the Lagrangian density contains the monomial `1` which is not linear in constant symbols.";
ParticleSpectrum::NonQuadraticFields="The Lagrangian density contains the monomial `1` which is not quadratic in fields or their derivatives.";
ParticleSpectrum::UnknownField="The Lagrangian density contains a tensor `1` which was not defined using DefField.";
ParticleSpectrum::UnknownCoupling="The Lagrangian density contains a symbol `1` which was not defined using DefConstantSymbol.";
ParticleSpectrum::ParityOdd="The Lagrangian density contains at least one term with an odd power of totally antisymmetric tensors.";

Options@ValidateLagrangian={Method->"Easy"};
ValidateLagrangian[InputExpr_,OptionsPattern[]]:=Module[{
	Expr=InputExpr,
	PolyExpr,
	LagrangianCouplingsValue,
	Unknowns,
	TensorsValue
	},

	If[PossibleZeroQ@Expr,Throw@Message@ParticleSpectrum::Zero];
	Expr=Expr/.{Plus->List};
	(!(ListQ@Expr))~If~(Expr//=List);
	Expr//=ToIndexFree;
	Expr=Expr/.{CD->Identity,IndexFree->Identity};
	Expr//=Flatten;
	PolyExpr=Expr;
	Expr=Expr.Table[0.1*Exp@ii,{ii,Length@Expr}];
	Expr//=Variables;	
	Expr//=DeleteDuplicates;
	LagrangianCouplingsValue=DeleteCases[Expr,_?xTensorQ];
	Unknowns=DeleteCases[LagrangianCouplingsValue,_?ConstantSymbolQ];
	(Length@Unknowns>=1)~If~(Throw@Message[ParticleSpectrum::UnknownCoupling,First@Unknowns]);
	TensorsValue=DeleteCases[Expr,_?ConstantSymbolQ];
	(MemberQ[TensorsValue,epsilonG])~If~(Throw@Message@ParticleSpectrum::ParityOdd);
	(((Length@Names@("xAct`PSALTer`"<>ToString@#<>"`*"))===0)~If~(Throw@Message[ParticleSpectrum::UnknownField,#]))&/@TensorsValue;
	(*(((ResourceFunction["PolynomialDegree"][#,LagrangianCouplingsValue]!=1)&&((OptionValue@Method)==="Hard"))~If~(Throw@Message[ParticleSpectrum::NonLinearCouplings,#]))&/@PolyExpr;*)
	((ResourceFunction["PolynomialDegree"][#,TensorsValue]>2)~If~(Throw@Message[ParticleSpectrum::NonQuadraticFields,#]))&/@PolyExpr;
];	
