(*===================*)
(*  ToCovariantForm  *)
(*===================*)

ToCovariantForm[ClassName_?StringQ,InputExpr_,SourceSpinParityTensorHeadsValue_]:=Module[{
	MomentumToDerivativeRules,
	Expr=InputExpr,
	Class},

	LocalSourceConstraints=" ** ToCovariantForm...";

	Class=Evaluate@Symbol@ClassName;
	
	MomentumToDerivativeRules=(P[Ind_]*#[OtherInds___]->-I*CD[Ind]@#[OtherInds])&/@(Keys@(SourceSpinParityTensorHeadsValue));
	MomentumToDerivativeRules=MomentumToDerivativeRules~Join~{P[Ind_]*CD[OtherInds_]@Anything_->-I*CD[Ind]@CD[OtherInds]@Anything};
	Diagnostic@MomentumToDerivativeRules;

	Expr//=(Class@ExpandSources);
	Expr=Expr/.ToP;
	Expr//=(Numerator@Together@(#/(2*3*5*7*11*Def^2)^9)&);
	Expr//=ToCanonical;
	Diagnostic@Expr;

	Expr=Expr/.{Def^2->Scalar[P[-a]P[a]]};
	Expr//=NoScalar;
	Expr//=ToCanonical;
	Expr=Expr/.{Def^4->Scalar[P[-a]P[a]]^2};
	Expr//=NoScalar;
	Expr//=ToCanonical;
	Expr=Expr/.{Def^6->Scalar[P[-a]P[a]]^3};
	Expr//=NoScalar;
	Expr//=ToCanonical;

	Expr//=ScreenDollarIndices;
	Expr=Expr/.MomentumToDerivativeRules;
	Expr//=ToCanonical;
	Expr=Expr/.MomentumToDerivativeRules;
	Expr//=ToCanonical;
	Expr=Expr/.MomentumToDerivativeRules;
	Expr//=ToCanonical;
	Expr=Expr/.MomentumToDerivativeRules;
	Expr//=ToCanonical;
	Expr//=(Numerator@Together@(#/(I*2*3*5*7*11*Def^2)^9)&);
	Expr=Expr/.{I->1};
	Expr=Expr/.{I->1};
	Expr//=ToCanonical;
	Expr//=SortCovDs;
	Expr//=ToCanonical;	
Expr];
