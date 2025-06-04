(*IsNegativeParitySpinTwo*)

IsNegativeParitySpinTwo[InputTensor_]~Y~(((SymmetryGroupOfTensor@InputTensor)===(StrongGenSet[{1,2},GenSet[-xAct`xPerm`Cycles[{1,2}]]]))&&((Length@SlotsOfTensor@InputTensor)===3));
