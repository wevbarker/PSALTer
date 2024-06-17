(*=====================*)
(*  FourierLagrangian  *)
(*=====================*)

FourierLagrangian[ClassName_?StringQ,Expr_,Tensors_]:=Module[{
	Class,
	CrossingRules,
	NewExpr,
	ToMomentumExpr,
	Tensors1,
	Tensors2},

	$LocalWaveOperator=" ** FourierLagrangian...";

	Class=Evaluate@Symbol@ClassName;

	Tensors1=(#@@(ToExpression/@Alphabet[][[1;;(Length@SlotsOfTensor@#)]]))&/@(Tensors);
	Tensors2=(#@@(ToExpression/@Alphabet[][[-(Length@SlotsOfTensor@#);;-1]]))&/@(Tensors);

	CrossingRules={};

	Table[(CrossingRules=CrossingRules~Join~
	MakeRule[{Evaluate[CD[-u]@CD[-q]@Tensor1 CD[-v]@CD[-p]@Tensor2],Evaluate[Dagger@Tensor1 P[-u]P[-v]P[-p]P[-q]Tensor2]},MetricOn->All,ContractMetrics->True]),
	{Tensor1,Tensors1},{Tensor2,Tensors2}];

	Table[(CrossingRules=CrossingRules~Join~
	MakeRule[{Evaluate[CD[-q]@Tensor1 CD[-v]@CD[-p]@Tensor2],Evaluate[-I*Dagger@Tensor1 P[-v]P[-p]P[-q]Tensor2]},MetricOn->All,ContractMetrics->True]),
	{Tensor1,Tensors1},{Tensor2,Tensors2}];

	Table[(CrossingRules=CrossingRules~Join~
	MakeRule[{Evaluate[CD[-u]@CD[-q]@Tensor1 CD[-p]@Tensor2],Evaluate[I*Dagger@Tensor1 P[-u]P[-p]P[-q]Tensor2]},MetricOn->All,ContractMetrics->True]),
	{Tensor1,Tensors1},{Tensor2,Tensors2}];

	Table[(CrossingRules=CrossingRules~Join~
	MakeRule[{Evaluate[CD[-q]@Tensor1 CD[-p]@Tensor2],Evaluate[Dagger@Tensor1 P[-p]P[-q]Tensor2]},MetricOn->All,ContractMetrics->True]),
	{Tensor1,Tensors1},{Tensor2,Tensors2}];

	Table[(CrossingRules=CrossingRules~Join~
	MakeRule[{Evaluate[CD[-q]@CD[-p]@Tensor1 Tensor2],Evaluate[-Dagger@Tensor1 P[-p]P[-q]Tensor2]},MetricOn->All,ContractMetrics->True]),
	{Tensor1,Tensors1},{Tensor2,Tensors2}];

	Table[(CrossingRules=CrossingRules~Join~
	MakeRule[{Evaluate[Tensor1 CD[-q]@CD[-p]@Tensor2],Evaluate[-Dagger@Tensor1 P[-q]P[-p]Tensor2]},MetricOn->All,ContractMetrics->True]),
	{Tensor1,Tensors1},{Tensor2,Tensors2}];

	Table[(CrossingRules=CrossingRules~Join~
	MakeRule[{Evaluate[Tensor1 CD[-p]@Tensor2],Evaluate[-I Dagger@Tensor1 P[-p]Tensor2]},MetricOn->All,ContractMetrics->True]),
	{Tensor1,Tensors1},{Tensor2,Tensors2}];

	Table[(CrossingRules=CrossingRules~Join~
	MakeRule[{Evaluate[Tensor1 Tensor2],Evaluate[Dagger@Tensor1 Tensor2]},MetricOn->All,ContractMetrics->True]),
	{Tensor1,Tensors1},{Tensor2,Tensors2}];

	Diagnostic@CrossingRules;

	NewExpr=Expr/.(Class@FieldToFiducialField);
	ToMomentumExpr=NewExpr;
	ToMomentumExpr//=ToNewCanonical;
	ToMomentumExpr//=CollectTensors;
	ToMomentumExpr=ToMomentumExpr/.CrossingRules;
	Diagnostic@ToMomentumExpr;
	ToMomentumExpr=ToMomentumExpr/.CrossingRules;
	Diagnostic@ToMomentumExpr;
	ToMomentumExpr//=ToNewCanonical;
	Diagnostic@ToMomentumExpr;
	ToMomentumExpr=ToMomentumExpr/.ToV;
	ToMomentumExpr//=Class@DecomposeFields;
	Diagnostic@ToMomentumExpr;

ToMomentumExpr];
