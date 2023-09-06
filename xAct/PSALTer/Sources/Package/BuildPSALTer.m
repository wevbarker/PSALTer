(*================*)
(*  BuildPSALTer  *)
(*================*)

SaveBinaryContext[Context_String]:=DumpSave[FileNameJoin[{$PSALTerInstallDirectory,"Binaries","Contexts",Context<>".mx"}],Context];

SaveBinaryContexts[]:=Module[{PrintVariable},
	Run@("rm -rf "<>FileNameJoin[{$PSALTerInstallDirectory,"Binaries","Contexts"}]<>"/*");
	PrintVariable=PrintTemporary[" ** BuildPSALTer: saving binary definitions for the context ",
		Context];
	SaveBinaryContext/@ContextList;
	NotebookDelete@PrintVariable;	
];

LoadBinaryContext[Context_String]:=Module[{PrintVariable},
	PrintVariable=PrintTemporary[" ** BuildPSALTer: loading binary definitions for the context ",
		Context];
	Off@(RuleDelayed::rhs);(* again emulating the xTensor sources *)
	Get[FileNameJoin[{$PSALTerInstallDirectory,"Binaries","Contexts",#<>".mx"}]]&/@ContextList;
	On@(RuleDelayed::rhs);
	NotebookDelete@PrintVariable;	
];

LoadPSALTer[]:=Catch@Module[{PrintVariable,InitialMemory,Progress},

	(*<<xAct`PSALTer`PoincareGaugeTheory`;*)

	PrintVariable=PrintTemporary[" ** BuildPSALTer: loading binary definitions..."];
	InitialMemory=MemoryInUse[];
(*
	Progress=PrintTemporary@ProgressIndicator[Dynamic[N[(Refresh[MemoryInUse[],UpdateInterval->0.1]-InitialMemory)/10^8]],Appearance->"Percolate"];
*)
	Progress=PrintTemporary@ProgressIndicator[Appearance->"Necklace",ImageSize->Large];
	LoadBinaryContext/@ContextList;
	NotebookDelete@PrintVariable;	
	NotebookDelete@Progress;
];

Options@BuildPSALTer={Recompile->False};
BuildPSALTer[OptionsPattern[]]:=Module[{PrintVariable},

	If[$PSALTerBuilt,Throw@Message[BuildPSALTer::built]];

		If[OptionValue@Recompile,
			
			Print@" ** BuildPSALTer: A rebuild of the context binaries was requested by an edit to PSALTer.m...";
			BuildRebuild["BuildPSALTer.m"];
			SaveBinaryContexts[];
			Print@" ** BuildPSALTer: The context binaries have been rebuilt, the kernel will
			now quit. Please reload PSALTer.";
			Quit[];,

			Check[

				PrintVariable=PrintTemporary@" ** BuildPSALTer: Attempting to load PSALTer as usual
				from context binaries...";
				LoadPSALTer[];,

				Print@" ** BuildPSALTer: No suitable context binaries found, rebuilding them from
				scratch. Don't worry: this should happen if it is your first time loading the
				package from a fresh install! It is *very important* that PSALTer is installed to
				a place where Mathematica has permissions to write files. For example on linux
				this might be ~/.Mathematica/Applications/xAct/PSALTer/.";
				BuildRebuild["BuildPSALTer.m"];
				SaveBinaryContexts[];
				Print@" ** BuildPSALTer: The context binaries have been rebuilt, the kernel will
				now quit. Please reload PSALTer.";
				Quit[];
			];

			NotebookDelete@PrintVariable;	
			Begin["xAct`PSALTer`Private`"];
				BuildPSALTerPackage[];
			End[];
		];
];
