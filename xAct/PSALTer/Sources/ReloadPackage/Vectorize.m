(*=============*)
(*  Vectorize  *)
(*=============*)

VectorizeEPS[InputExpr_]:=Module[{TemporaryFileNameEPS,TemporaryFileNamePDF,Expr},

	TemporaryFileNamePDF=CreateFile[];
	TemporaryFileNamePDF//=(#~RenameFile~(#<>".pdf"))&;
	Export[TemporaryFileNamePDF,InputExpr,"PDF",AllowRasterization->False];

	TemporaryFileNameEPS=CreateFile[];
	TemporaryFileNameEPS//=(#~RenameFile~(#<>".eps"))&;
	RunProcess@{"inkscape",TemporaryFileNamePDF,"--export-eps="<>TemporaryFileNameEPS};
	TemporaryFileNamePDF//DeleteFile;
	Expr=TemporaryFileNameEPS~Import~{"EPS","Graphics"};
	TemporaryFileNameEPS//DeleteFile;
Expr];

VectorizePDF[InputExpr_]:=Module[{TemporaryFileNameEPS,TemporaryFileNamePDF,Expr},

	TemporaryFileNamePDF=CreateFile[];
	TemporaryFileNamePDF//=(#~RenameFile~(#<>".pdf"))&;
	Export[TemporaryFileNamePDF,InputExpr,"PDF",AllowRasterization->False];

	Expr=TemporaryFileNamePDF~Import~{"PDF","PageGraphics"};
	TemporaryFileNamePDF//DeleteFile;
	Expr//=First;
Expr];

Vectorize[InputExpr_]:=Module[{TemporaryFileNameEPS,TemporaryFileNamePDF,Expr=InputExpr},


	Which[
		($OperatingSystem==="Unix")||($OperatingSystem==="MacOSX")
	,
		(Expr=InputExpr//VectorizeEPS;)~Check~(Expr=InputExpr//VectorizePDF;)
	,
		($OperatingSystem==="Windows")
	,
		Expr=InputExpr//VectorizePDF;
	];
Expr];

(*Run@("where /r \"C:\\Program Files\" inkscape.com > \""<>TemporaryFileNameTXT<>"\" & set /p myvar= < \""<>TemporaryFileNameTXT<>"\" & \"%myvar%\" "<>TemporaryFileNamePDF<>" --export-eps="<>TemporaryFileNameEPS);*)
