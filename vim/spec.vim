" Filename:    spec.vim
" Purpose:     Vim syntax file
" Language:    SPEC: Build/install scripts for Linux RPM packages
" Maintainer:  Donovan Rebbechi elflord@pegasus.rutgers.edu
" URL:         http://pegasus.rutgers.edu/~elflord/vim/syntax/spec.vim
" Last change: Tue Abr 16 16:58:34 EST 2001 <verde (a) aurelio net>

" Changelog:   Wed Sep 22: several improvements and fixes. Added preamble tags
"              and %ifFOO macros. Removed all hardcoded colours.
"              Wed Oct 20: Added %lang
"              Sat Nov 27: fixed a typo
"
" CHANGELO(N)G - 03 october 2000 <verde (a) aurelio net>
" ------------
"syntax is now "contained", defined areas are only highlighted in valid places,
"  i.e. %doc and %dir are only valid in %files section
"macros/vars recognized in all formats: %macro, %{macro}, $macro, ${macro}
"specWeekday & specMonth: are now \<atoms\> (keywords)
"created: specLicense, specPercent, shQuote*
"changed names of some regions
"specTarCommand: I and p options added, ER improved
"specPreAmble: new fields added, deprecated fields with Error syntax
"  (see specPreAmbleDeprecated)
"various regexps improved like specEmail,specURL,specCommandOpts
"specURLMacro: macros are highlighted inside URLs
"spec*Opts: section valid options are recognized (%description, %package and %files)
"specMacroName*: included *ALL* %[A-z] and %_[A-z] macros from /usr/lib/rpm/macros
"sections and section macros *HAVE* to be at the begining of the line
"  i.e. %prep, %install, %configure
"specComment != shComment (and each one valid in its own section)
"shQuote*: treating '' and "" as strings
"new set of colors, identifying diferent type of macros
"more comments on the syntax file, to help maintance
"
"  <verde (a) aurelio net>
"20001026 specIf also permitted in %files
"20010220 blank spaces permitted at specSectionMacroArea beginning 
"         %trigger == %post, BuildPreReq tag is now obsoleted
"20010322 PACKAGE_(VERSION|RELEASE) tags accepted
"20010410 -:- a spec's shell area total cleanup -:-
"         deleted specIfError,shFunction,sh...Error references (not defined)
"         sh...Keys: areas created (now all structures seems ok)
"         specIfKeys: created to avoid %else being start of block
"         specTarCommand: requires at least 2 options like: tar tf file
"         shQuote1: \' NOT permitted
"         shSubshell: created area for `` and $()
"         shOperators: added things like 2>&1, <&- and -lt
"         specCommand: 'basename' in and 'moc' out
"         specCommand: most of commands requires arguments (\s after)
"         ...All: created various clusters to help the maintaince
"         specNumber: improved and specNoNumberHilite deleted
"         wiped all the contains=ALLBUT from the syntax file. they REALLY suck.
"20010521 specScriptArea: added triggerpostun
"         shIf, shDo, shCase: s/\<if\>/\<if\s/
"         specCommand: added chown
"20010606 specPreAmble: BuildConflicts tag confirmed ok
"         shSpecial: created to handle \" not inside shQuote2
"         shHereDoc: created ( <<-EOF )
"         specScriptArea: added trigger(in|un), removed trigger
"20010628 specIf: %if added
"         specScriptArea: %verifyscript added
           
"TODO <<\s*EOF
"TODO register %files macros directives?
"TODO why shSpecial and shHereDoc colors doesn't work?

syn clear
syn sync minlines=1000

syn match specSpecialChar contained '[][()!$\\|>^;:{}&]'
syn match specColon       contained ':'
syn match specPercent     contained '%'

syn match specVariables   contained '\$\h\w*' contains=specSpecialVariablesNames,specSpecialChar
syn match specVariables   contained '\${\w*}' contains=specSpecialVariablesNames,specSpecialChar

syn match specMacroIdentifier contained '%\h\w*' contains=specMacroNameLocal,specMacroNameOther,specPercent
syn match specMacroIdentifier contained '%{\w*}' contains=specMacroNameLocal,specMacroNameOther,specPercent,specSpecialChar

syn match specSpecialVariables contained '\$[0-9]\|\${[0-9]}'
syn match specCommandOpts      contained '\s\(-\w\+\|--\w[a-zA-Z_-]\+\)'ms=s+1
syn match specComment '^\s*#.*$'


"all the clusters defined
syn cluster specCommands contains=specCommand,specTarCommand,specConfigure,specCommandSpecial,specCommandOpts
syn cluster specListedFiles contains=specListedFilesBin,specListedFilesLib,specListedFilesDoc,specListedFilesEtc,specListedFilesShare,specListedFilesPrefix,specVariables,specSpecialChar

syn cluster specSectionAll contains=specPreAmbleDeprecated,specPreAmble,specDescriptionArea,specPackageArea,specScriptArea,specChangelogArea,specFilesArea
syn cluster shAll contains=shComment,shSpecial,shQuote1,shQuote2,shHereDoc,shOperator,shSubshell,shIf,shDo,shCase
syn cluster specVarsAll contains=specVariables,specSpecialVariables,specMacroIdentifier
syn cluster specScriptAll contains=specSpecialChar,specNumber,specSectionMacroArea,specSectionMacroBracketArea,@shAll,@specVarsAll,@specCommands

syn case match


"matches with no highlight
syn match specManpageFile '[a-zA-Z]\.1'

"Day, Month and most used license acronyms
syn keyword specLicense contained GPL LGPL BSD MIT GNU
syn keyword specWeekday contained Mon Tue Wed Thu Fri Sat Sun
syn keyword specMonth   contained Jan Feb Mar Apr Jun Jul Aug Sep Oct Nov Dec
syn keyword specMonth   contained January February March April May June July August September October November December

"#, @, www
syn match specNumber '\(^-\=\|[ \t]-\=\|-\)\<[0-9.-]*[0-9]\>'
syn match specEmail    contained '<\=\<[A-Za-z0-9_.-]\+@\([A-Za-z0-9_-]\+\.\)\+[A-Za-z]\+\>>\='
syn match specURL      contained '\<\(\(https\{0,1}\|ftp\)://\|\(www[23]\{0,1}\.\|ftp\.\)\)[A-Za-z0-9._/~:,#-]\+\>'
syn match specURLMacro contained '\<\(\(https\{0,1}\|ftp\)://\|\(www[23]\{0,1}\.\|ftp\.\)\)[A-Za-z0-9._/~:,#%{}-]\+\>' contains=specMacroIdentifier

"Special system directories
syn match specListedFilesPrefix contained '/\(usr\|local\|opt\|X11R6\|X11\)/'me=e-1
syn match specListedFilesBin    contained '/s\=bin/'me=e-1
syn match specListedFilesLib    contained '/\(lib\|include\)/'me=e-1
syn match specListedFilesDoc    contained '/\(man\d*\|doc\|info\)\>'
syn match specListedFilesEtc    contained '/etc/'me=e-1
syn match specListedFilesShare  contained '/share/'me=e-1

"specComands
syn match   specConfigure  contained '\./configure'
syn match   specTarCommand contained '\<tar\s\+[cxvpzIf]\{2,5}\s*'
syn keyword specCommandSpecial contained root
syn keyword specCommand    contained cd echo make xmkmf
syn match   specCommand    contained '\<\(basename\|cat\|chmod\|chown\|cp\|eval\|export\|find\|grep\|gzip\|install\|ln\|ls\|mkdir\|mv\|pwd\|rm\|rmdir\|sed\|strip\|tail\|touch\)\s'me=e-1

"frequently used rpm env vars
syn keyword specSpecialVariablesNames contained RPM_BUILD_ROOT RPM_BUILD_DIR RPM_SOURCE_DIR RPM_OPT_FLAGS LDFLAGS CC CC_FLAGS CPPNAME CFLAGS CXX CXXFLAGS CPPFLAGS PACKAGE_VERSION PACKAGE_RELEASE

"valid macro names from /usr/lib/rpm/macros
syn keyword specMacroNameOther contained buildroot buildsubdir distribution disturl ix86 name nil optflags perl_sitearch release requires_eq vendor version
syn match   specMacroNameOther contained '\<\(PATCH\|SOURCE\)\d*\>'

"valid _macro names from /usr/lib/rpm/macros
syn keyword specMacroNameLocal contained _arch _binary_payload _bindir _build _build_alias _build_cpu _builddir _build_os _buildshell _buildsubdir _build_vendor _bzip2bin _datadir _dbpath _dbpath_rebuild _defaultdocdir _docdir _excludedocs _exec_prefix _fixgroup _fixowner _fixperms _ftpport _ftpproxy _gpg_path _gzipbin _host _host_alias _host_cpu _host_os _host_vendor _httpport _httpproxy _includedir _infodir _install_langs _install_script_path _instchangelog _langpatt _lib _libdir _libexecdir _localstatedir _mandir _netsharedpath _oldincludedir _os _pgpbin _pgp_path _prefix _preScriptEnvironment _provides _rpmdir _rpmfilename _sbindir _sharedstatedir _signature _sourcedir _source_payload _specdir _srcrpmdir _sysconfdir _target _target_alias _target_cpu _target_os _target_platform _target_vendor _timecheck _tmppath _topdir _usr _usrsrc _var _vendor


"------------------------------------------------------------------------------
" here's is all the spec sections definitions: PreAmble, Description, Package,
"   Scripts, Files and Changelog

"One line macros - valid in all ScriptAreas
"tip: remember do include new itens on specScriptArea's skip section
syn region specSectionMacroArea oneline matchgroup=specSectionMacro start='^\s*%\(define\|patch\d*\|setup\|configure\|GNUconfigure\|find_lang\|makeinstall\)\>' end='$' contains=specCommandOpts,specMacroIdentifier
syn region specSectionMacroBracketArea oneline matchgroup=specSectionMacro start='^%{\(configure\|GNUconfigure\|find_lang\|makeinstall\)}' end='$' contains=specCommandOpts,specMacroIdentifier

"%% Files Section %%
"TODO %config valid parameters: missingok\|noreplace
"TODO %verify valid parameters: \(not\)\= \(md5\|atime\|...\)
syn region specFilesArea matchgroup=specSection start='^%[Ff][Ii][Ll][Ee][Ss]\>' skip='%\(attrib\|defattr\|attr\|dir\|config\|docdir\|doc\|lang\|verify\|ghost\|ifosf\|ifos\|ifnos\|ifarch\|ifnarch\|if\|else\|endif\)\>' end='^%[a-zA-Z]'me=e-2 contains=specFilesOpts,specFilesDirective,@specListedFiles,specComment,specCommandSpecial,specMacroIdentifier,specIf
"tip: remember to include new itens in specFilesArea above
syn match  specFilesDirective contained '%\(attrib\|defattr\|attr\|dir\|config\|docdir\|doc\|lang\|verify\|ghost\)\>'

"valid options for certain section headers
syn match specDescriptionOpts contained '\s-[ln]\s*\a'ms=s+1,me=e-1
syn match specPackageOpts     contained    '\s-n\s*\w'ms=s+1,me=e-1
syn match specFilesOpts       contained    '\s-f\s*\w'ms=s+1,me=e-1

syn case ignore

"%% PreAmble Section %%
"Copyright, Serial and BuildPreReq were deprecated by
"License,   Epoch  and BuildRequires
syn region specPreAmbleDeprecated oneline matchgroup=specError start='^\(Copyright\|Serial\|BuildPreReq\)' end='$' contains=specEmail,specURL,specURLMacro,specLicense,specColon,specSpecialChar,@specVarsAll
syn region specPreAmble oneline matchgroup=specCommand start='^\(Prereq\|Summary\|Name\|Version\|Packager\|Requires\|Icon\|URL\|Source\d*\|Patch\d*\|Prefix\|Packager\|Group\|License\|Release\|BuildRoot\|Distribution\|Vendor\|Provides\|ExclusiveArch\|ExcludeArch\|ExclusiveOS\|Obsoletes\|BuildArchitectures\|BuildArch\|BuildRequires\|BuildConflicts\|BuildPreReq\|Conflicts\|AutoRequires\|AutoReqProv\|AutoReq\|AutoProv\|Epoch\)' end='$' contains=specEmail,specURL,specURLMacro,specLicense,specColon,specSpecialChar,@specVarsAll

"%% Description Section %%
syn region specDescriptionArea matchgroup=specSection start='^%description' end='^%[a-zA-Z]'me=e-2 contains=specDescriptionOpts,specEmail,specURL,specNumber,specMacroIdentifier,specComment

"%% Package Section %%
syn region specPackageArea matchgroup=specSection start='^%package' end='^%[a-zA-Z]'me=e-2 contains=specPackageOpts,specPreAmble,specComment

"%% Scripts Section %%
syn region specScriptArea matchgroup=specSection start='^%\(prep\|build\|install\|clean\|pre\|postun\|preun\|post\|triggerpostun\|triggerun\|triggerin\|verifyscript\)\>' skip='^%\(define\|patch\d*\|configure\|GNUconfigure\|setup\|find_lang\|makeinstall\|ifosf\|ifos\|ifnos\|ifarch\|ifnarch\|if\|else\|endif\)\>' end='^%[a-zA-Z]'me=e-2 contains=specIf,@specScriptAll,@specCommands,@shAll

"%% Changelog Section %%
syn region specChangelogArea matchgroup=specSection start='^%changelog' end='^%[a-zA-Z]'me=e-2 contains=specEmail,specURL,specWeekday,specMonth,specNumber,specComment,specLicense


"------------------------------------------------------------------------------
"here's the shell syntax for all the Script Sections

syn case match

"sh-like comment stile, only valid in script part
syn match shComment contained '#.*$'
syn match shSpecial contained '\\"'

" 1st: >= !=   2nd: > 2> <&- 2>&1    *the order is important, don't change
syn match shOperator contained '[!=><]=\|\(\W\d\)\=[><]\(&[0-9-]\)\='
"test's arithmetic literal operators
syn match shOperator contained '\s-\([lg][te]\|e[qf]\|n[et]\|ot\)\>'ms=s+1

syn region shQuote1 contained matchgroup=shQuoteDelim start=+'+ end=+'+ contains=specMacroIdentifier
syn region shQuote2 contained matchgroup=shQuoteDelim start=+"+ skip=+\\"+ end=+"+ contains=specVariables,specMacroIdentifier,shSpecial
syn region shHereDoc contained matchgroup=shQuoteDelim start='<<-\=EOF$' end='^EOF' contains=specVariables,specMacroIdentifier,shSpecial

syn region shSubshell transparent contained matchgroup=shOperator start="`" skip="\\`" end="`" contains=@shAll,@specVarsAll,@specCommands,specSpecialChar
syn region shSubshell transparent contained matchgroup=shOperator start="$(" end=")" contains=@shAll,@specVarsAll,@specCommands,specSpecialChar

"why it's in the middle of shell part? just don't ask &:)
syn match  specIfKeys  contained '%else\>'
syn region specIf      transparent matchgroup=specBlock start='%\(ifosf\|ifos\|ifnos\|ifarch\|ifnarch\|if\)\>' end='%endif\>' contains=specIfKeys,@specScriptAll,@specSectionAll,specIf,specFilesDirective

syn keyword shIfKeys   contained then else elif
syn region  shIf       transparent matchgroup=specBlock start='\<if\s'me=e-1 end='\<fi\>' contains=shIfKeys,@specScriptAll,specIf

syn keyword shDoKeys   contained in do
syn region  shDo       transparent matchgroup=specBlock start='\<\(for\|while\|until\)\s'me=e-1 end='\<done\>' contains=shDoKeys,@specScriptAll,specIf

syn keyword shCaseKeys contained in
syn region  shCaseItem contained   matchgroup=specBlock start=')' end=';;' contains=@specScriptAll,specIf
syn region  shCase     transparent matchgroup=specBlock start='\<case\s'me=e-1 end='\<esac\>' contains=shCaseKeys,shCaseItem,shComment,shSubshell,@specVarsAll


if !exists("did_spec_syntax_inits")
        let did_spec_syntax_inits = 1
        " The default methods for highlighting. Can be overridden later.

          "main types color definitions
          hi link specSection                   Structure
          hi link specSectionMacro              Macro
          hi link specWWWlink                   PreProc
          hi link specOpts                      Operator

          "yes, it's ugly, but white is sooo cool
          if &background == "dark"
            hi      specGlobalMacro            ctermfg=white
          else
            hi link specGlobalMacro            Identifier
          endif

          "sh colors
          hi link shComment                     Comment
          hi link shSpecial                     Special
          hi link shIfKeys                      Function
          hi link shDoKeys                      Function
          hi link shCaseKeys                    Function
          hi link shOperator                    Special
          hi link shQuote1                      String
          hi link shQuote2                      String
          hi link shHereDoc                     String
          hi link shQuoteDelim                  Statement

          "spec colors
          hi link specBlock                     Function
          hi link specColon                     Special
          hi link specCommand                   Statement
          hi link specCommandOpts               specOpts
          hi link specCommandSpecial            Special
          hi link specComment                   Comment
          hi link specConfigure                 specCommand
          hi link specDate                      String
          hi link specDescriptionOpts           specOpts
          hi link specEmail                     specWWWlink
          hi link specError                     Error
          hi link specFilesDirective            specSectionMacro
          hi link specFilesOpts                 specOpts
          hi link specIfKeys                    Function
          hi link specLicense                   String
          hi link specMacroNameLocal            specGlobalMacro
          hi link specMacroNameOther            specGlobalMacro
          hi link specManpageFile               NONE
          hi link specMonth                     specDate
          hi link specNumber                    Number
          hi link specPackageOpts               specOpts
          hi link specPercent                   Special
          hi link specSpecialChar               Special
          hi link specSpecialVariables          specGlobalMacro
          hi link specSpecialVariablesNames     specGlobalMacro
          hi link specTarCommand                specCommand
          hi link specURL                       specWWWlink
          hi link specURLMacro                  specWWWlink
          hi link specVariables                 Identifier
          hi link specWeekday                   specDate
          hi link specListedFilesBin            Statement
          hi link specListedFilesDoc            Statement
          hi link specListedFilesEtc            Statement
          hi link specListedFilesLib            Statement
          hi link specListedFilesPrefix         Statement
          hi link specListedFilesShare          Statement
  endif

let b:current_syntax = "spec"

" vim: ts=8
