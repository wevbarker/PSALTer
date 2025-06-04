(*=============*)
(*  Vectorize  *)
(*=============*)

VectorizeEPS[InputExpr_]:=Module[{TemporaryFileNameEPS,TemporaryFileNamePDF,Expr},

	TemporaryFileNamePDF=CreateFile[];
	TemporaryFileNamePDF//=(#~RenameFile~(#<>".pdf"))&;
	UsingFrontEnd@Export[TemporaryFileNamePDF,InputExpr,"PDF",AllowRasterization->False];

	TemporaryFileNameEPS=CreateFile[];
	TemporaryFileNameEPS//=(#~RenameFile~(#<>".eps"))&;
	Run[$InkscapePath<>" --export-eps="<>TemporaryFileNameEPS<>" "<>TemporaryFileNamePDF<>" > /dev/null 2>&1"];
	(*RunProcess@{$InkscapePath,TemporaryFileNamePDF,"--export-eps="<>TemporaryFileNameEPS};*)
	TemporaryFileNamePDF//DeleteFile;
	Expr=UsingFrontEnd@(TemporaryFileNameEPS~Import~{"EPS","Graphics"});
	TemporaryFileNameEPS//DeleteFile;
Expr];

VectorizePDF[InputExpr_]:=Module[{TemporaryFileNameEPS,TemporaryFileNamePDF,Expr},

	TemporaryFileNamePDF=CreateFile[];
	TemporaryFileNamePDF//=(#~RenameFile~(#<>".pdf"))&;
	UsingFrontEnd@Export[TemporaryFileNamePDF,InputExpr,"PDF",AllowRasterization->False];

	Expr=UsingFrontEnd@(TemporaryFileNamePDF~Import~{"PDF","PageGraphics"});
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
