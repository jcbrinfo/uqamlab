% Fusion de `memoireuqam1.3`, de `memoireuqam1.3ang` et de plusieurs astuces
% pratiques par Jean-Christophe Beaupré.
%
% Conçu pour fonctionner avec XeLaTeX. Peut fonctionner avec d’autres moteurs
% TeX (à vos risques et périls).
%
% Description originale
% ---------------------
% format LaTeX pour memoire et these de l'UQAM
% d'apres "Guide de presentation des memoires et theses"
% auteur: Gisele Legault
% collaborateurs: Stephane Poirier, Rene Ferland,
%                  Luc Belanger, Andre Lauzon
%                  Jerome Tremblay, Anthony Monnet
%
% Licence
% -------
% © Jean-Christophe Beaupré, Gisèle Legault et collaborateurs.
% 
% Il est autorisé d’utiliser, de reproduire, de modifier et/ou de distribuer
% cette œuvre, avec ou sans frais, à condition que la mention de droit d’auteur
% ainsi que le présent avis d’autorisation apparaissent dans toutes les
% reproductions.
%
% Familles de polices de caractères requises
% ------------------------------------------
% * Liberation Serif
% * Linux Biolinum O (fait partie du projet Linux Libertine)
% * DejaVu Sans Mono
%
% Citations
% ---------
% * Pour suivre le style de citation par défaut de l’UQAM, utilisez `\citep*` et
%   `\citet*` (les variantes sans astérisque ne mentionnant que le premier
%   auteur).
% * Pour les citations paraphrasées, `\citeauthor*`, `\citeyear` et
%   `\citeyearpar` peuvent vous être utiles.
% * Pour les sites web complets (pas uniquement une page), utilisez
%   `\defcitealias`, `\url` et `\citepalias` pour citer avec l’URL.
%   Malheureusement, `natbib` ne permet pas d’extraire l’attribut `URL` de
%   l’entrée BibTeX.
%   Exemple : `\defcitealias{nit}{\url{http://nitlanguage.org}}` dans le
%   préambule et `\citepalias{nit}` dans le texte.
% * Lorque l’auteur est un organisme (exemple : une norme), combinez `\citetext`
%   avec `\citeyear` tout en respectant la règle « 7. Auteur collectif ».
%   Exemple : `\citetext{{E}uropean {A}ssociation for {S}tandardizing {I}nformation and {C}ommunication {S}ystems ({ECMA}), \citeyear{ECMA-262-v6}}` la première fois et `\citetext{{ECMA}, \citeyear{ECMA-262-v6}}` la deuxième fois.
% * Lorqu’il n’y a pas de date, inscrivez `\iflanguage{english}{n.d.}{s. d.}`
%   dans l’attribut `YEAR` de l’entrée BibTeX. Vous devez aussi retravailler
%   l’appel à citation à la main puisque `natbib` n’est pas conçu pour composer
%   avec ce genre de mention (et vous vous retrouvez avec quelque chose comme
%   « ds da »). Exemple : \citetext{\citeauthor{page-web}, s. d.}
%
% Exemple d’entrée BibTeX pour une norme
% --------------------------------------
% Avec BibTeX, il faut parfois beaucoup tricher pour obtenir un rendu similaire
% à celui recommandée.
%
% ```
% @Book{ECMA-262-v6,
% 	Title    = {{ECMAScript} 2015 {L}anguage {S}pecification},
% 	Author   = {{European Association for Standardizing Information and Communication Systems}},
% 	Year     = {2015},
% 
% 	Address  = {\iflanguage{english}{Geneva}{Genève}},
% 	Note     = {ECMA-262 2015},
% 
% 	File     = {:../literature_repository/languages/Ecma-262.pdf:PDF},
% 	Language = {english}
% }
% ```
%
% Changements majeurs
% -------------------
% * La sélection de la langue et du type de document se fait par des options.
% * Le style de bibliographie est automatiquement sélectionné.
% * Les pages titres sont automatiquement insérées.
% * Les pages titres doivent être configurées dans le préambule.
% * `\titleanglais` devient `\titleEnglish`.
% * `\matiere` devient `\matter`.
% * `\matiereanglais` devient `\matterEnglish`.
% * Par défaut, la matière est `sciences`/`science`.
% * La commande `\concentrationEnglish` a été ajouté pour distinguer le libellé
%   de concentration anglophone de celui francophone.
% * Les commandes  `\degreemonth`, `\degreemonthfrancais` et  `\degreeyear` ne
%   sont pas définies. Configurez les compteurs `\month` et `\year` à la place.
%   Exemple : `\year=1942`
% * Les paquetages suivants sont préconfigurés :
%   * `babel`
%   * `bookmark`
%   * `comment`
%   * `fancyvrb`
%   * `float`
%   * `fontspec`
%   * `graphicx`
%   * `hyperref`
%   * `ifpdf`
%   * `ltabulary`
%   * `natbib`
%   * `pdflscape`
%   * `setspace`
%   * `textcase`
%   * `url`
%   * `xcolor`
%
%   Note : `hyperref`, `natbib`, `setspace` et `textcase` sont requis pour que
%   cette classe reproduise la mise en forme de `memoireuqam`.
%
%   Note : N’importez pas `cite`. Sinon, vous allez avoir des erreurs dû à des
%   conflits avec `natbib` (je crois).
%
% * Les couleurs de la palette Tango (`tango-*`) sont définis.
% * Les polices de caractères sont différentes et sont configurées pour
%   fonctionner avec `xelatex`.
% * Dans les signets PDF, les titres de chapitre ne sont pas mis en majuscules.
% * Les règles d’espacement françaises (spécifiques à la France) pour `;`, `?`
%   et `!` sont désactivées. Pour les régles québecoises, voir la
%   [Banque de dépannage liguistique de l’OQLF](http://bdl.oqlf.gouv.qc.ca/bdl/gabarit_bdl.asp?id=2039)
% * Toutes les années non numériques sont mis entre crochets dans la
%   bibliographie.
% * Si un article de conférence possède déjà un DOI, l’attribut `URL` est
%   ignoré. Cela évite de se retrouver avec l’URL de la conférence en plus de
%   l’URL de l’article dans l’entrée bibliographique.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{UqamLab}[2017/05/24 v1.3L Classe pour les mémoires à l’UQAM]

% ------------------------------------------------------------------------------
% Options et classe de base
% ------------------------------------------------------------------------------

\newcommand{\@ifEnglish}[2]{#2}
\DeclareOption{english}{
	\renewcommand{\@ifEnglish}[2]{#1}
}

% Par défaut : thèse de doctorat
\newcommand{\@theseType}{TH\`ESE}
\newcommand{\@theseProg}{DU DOCTORAT EN \MakeTextUppercase{\@matter}}
\newcommand{\@theseAccord}{E}
\newcommand{\@theseTypeEnglish}{THESIS}
\newcommand{\@theseProgEnglish}{TO THE PH.D IN \MakeTextUppercase{\@matterEnglish}}

% Thèse de docotorat (remplace `\uqamthese`)
\DeclareOption{these}{
	\renewcommand{\@theseType}{TH\`ESE}
	\renewcommand{\@theseProg}{DU DOCTORAT EN \MakeTextUppercase{\@matter}}
	\renewcommand{\@theseAccord}{E}
	\renewcommand{\@theseTypeEnglish}{THESIS}
	\renewcommand{\@theseProgEnglish}{TO THE PH.D IN \MakeTextUppercase{\@matterEnglish}}
}

% Mémoire de maîtrise (remplace `\uqammemoire`)
\DeclareOption{memoire}{
	\renewcommand{\@theseType}{M\'EMOIRE}
	\renewcommand{\@theseProg}{DE LA MA\^ITRISE EN \MakeTextUppercase{\@matter}}
	\renewcommand{\@theseAccord}{}
	\renewcommand{\@theseTypeEnglish}{DISSERTATION}
	\renewcommand{\@theseProgEnglish}{TO THE MASTERS IN \MakeTextUppercase{\@matterEnglish}}
}

% Rapport technique de maîtrise (remplace `\uqamrapport`)
\DeclareOption{rapport}{
	\renewcommand{\@theseType}{RAPPORT DE RECHERCHE}
	\renewcommand{\@theseProg}{DE LA MA\^ITRISE EN \MakeTextUppercase{\@matter}}
	\renewcommand{\@theseAccord}{}
	\renewcommand{\@theseTypeEnglish}{REPORT}
	\renewcommand{\@theseProgEnglish}{TO THE MASTERS IN \MakeTextUppercase{\@matterEnglish}}
}

\DeclareOption*{
	\PassOptionsToClass{\CurrentOption}{report}
}
\ProcessOptions*

\LoadClass[twoside, letterpaper, 12pt]{report}

% ------------------------------------------------------------------------------
% Commentaires
% ------------------------------------------------------------------------------

\RequirePackage{comment}

% ------------------------------------------------------------------------------
% PDF
% ------------------------------------------------------------------------------

\RequirePackage{ifpdf}

% Insère des liens hypertextes, sans changer le style.
\RequirePackage[hidelinks]{hyperref}
% Solution de contournement d’un bug d’`hyperref` avec un `%` dans le texte.
\RequirePackage{bookmark}

% ------------------------------------------------------------------------------
% Case
% ------------------------------------------------------------------------------

\RequirePackage{textcase}
\newcommand{\@UpperRef}[1]{%
	\texorpdfstring{%
		\MakeTextUppercase{#1}%
	}{%
		#1%
	}%
}

% ------------------------------------------------------------------------------
% Polices de caractères
% ------------------------------------------------------------------------------

\RequirePackage{fontspec}
% Liberation Serif est de même dimensions que Times New Roman (la police
% recommandée par le guide).
\setmainfont{Liberation Serif}
\setsansfont{Linux Biolinum O}
\setmonofont[Scale=0.9]{DejaVu Sans Mono}

% ------------------------------------------------------------------------------
% Citations et bibliographies
% ------------------------------------------------------------------------------

\RequirePackage{url}
%\RequirePackage{cite} % Conflit avec `natbib`!
\RequirePackage{natbib}

\@ifEnglish{
	\AtEndDocument{
		\bibliographystyle{apalike-uqam-anglais}
	}
}{
	\AtEndDocument{
		\bibliographystyle{apalike-uqam}
	}
}

% ------------------------------------------------------------------------------
% Langues
% ------------------------------------------------------------------------------

\@ifEnglish{
	% Il semble y avoir un bug lorsque `babel` chargé depuis `RequirePackage` :
	% `canadien` prend toujours le dessus, à moins que l’option `main` soit
	% explicitée.
	\RequirePackage[canadien, main=english]{babel}
}{
	\RequirePackage[english, main=canadien]{babel}
	\renewcommand{\contentsname}{TABLE DES MATI\`ERES}
	\renewcommand{\listfigurename}{LISTE DES FIGURES}
	\renewcommand{\listtablename}{LISTE DES TABLEAUX}
	\renewcommand{\bibname}{BIBLIOGRAPHIE}
	\renewcommand{\indexname}{INDEX}
	\renewcommand{\figurename}{Figure}
	\renewcommand{\tablename}{Tableau}
	\renewcommand{\partname}{PARTIE}
	\renewcommand{\chaptername}{CHAPITRE}
	\renewcommand{\appendixname}{APPENDICE}
	\renewcommand{\abstractname}{R\'esum\'e}
}

% Désactiver les changements étranges de la mise en page.
\frenchbsetup {
	FrenchFootnotes=false % À l’UQAM, on suit la même règle qu’en anglais (appel de note toujours en exposant).
}

% Désactiver les régles d’espacement françaises.
\renewcommand{\FBthinspace}{}

\newcommand{\@raiseInvalidMonth}{
	\ClassError{UqamLab}{Mois invalide}{Le mois doit être entre 1 et 12.}
}
\newcommand{\@monthFrench}[1]{%
	\ifcase#1
		\@raiseInvalidMonth
		\or Janvier
		\or F\'{e}vrier
		\or Mars
		\or Avril
		\or Mai
		\or Juin
		\or Juillet
		\or Ao\^{u}t
		\or Septembre
		\or Octobre
		\or Novembre
		\or D\'{e}cembre
		\else \@raiseInvalidMonth
	\fi
}
\newcommand{\@monthEnglish}[1]{%
	\ifcase#1
		\@raiseInvalidMonth
		\or January
		\or February
		\or March
		\or April
		\or May
		\or June
		\or July
		\or August
		\or September
		\or October
		\or November
		\or December
		\else \@raiseInvalidMonth
	\fi
}

% ------------------------------------------------------------------------------
% Palette de couleurs Tango
% ------------------------------------------------------------------------------
\RequirePackage[table]{xcolor}
\definecolor{tango-butter-1}{HTML}{FCE94F}
\definecolor{tango-butter-2}{HTML}{EDD400}
\definecolor{tango-butter-3}{HTML}{C4A000}
\definecolor{tango-orange-1}{HTML}{FCAF3E}
\definecolor{tango-orange-2}{HTML}{F57900}
\definecolor{tango-orange-3}{HTML}{CE5C00}
\definecolor{tango-chocolate-1}{HTML}{E9B96E}
\definecolor{tango-chocolate-2}{HTML}{C17D11}
\definecolor{tango-chocolate-3}{HTML}{8F5902}
\definecolor{tango-chameleon-1}{HTML}{8AE234}
\definecolor{tango-chameleon-2}{HTML}{73D216}
\definecolor{tango-chameleon-3}{HTML}{4E9A06}
\definecolor{tango-sky-blue-1}{HTML}{729FCF}
\definecolor{tango-sky-blue-2}{HTML}{3465A4}
\definecolor{tango-sky-blue-3}{HTML}{204A87}
\definecolor{tango-plum-1}{HTML}{AD7FA8}
\definecolor{tango-plum-2}{HTML}{75507B}
\definecolor{tango-plum-3}{HTML}{5C3566}
\definecolor{tango-scarlet-red-1}{HTML}{EF2929}
\definecolor{tango-scarlet-red-2}{HTML}{CC0000}
\definecolor{tango-scarlet-red-3}{HTML}{A40000}
\definecolor{tango-aluminium-1}{HTML}{EEEEEC}
\definecolor{tango-aluminium-2}{HTML}{D3D7CF}
\definecolor{tango-aluminium-3}{HTML}{BABDB6}
\definecolor{tango-aluminium-4}{HTML}{888A85}
\definecolor{tango-aluminium-5}{HTML}{555753}
\definecolor{tango-aluminium-6}{HTML}{2E3436}

% ------------------------------------------------------------------------------
% Code source
% ------------------------------------------------------------------------------
\RequirePackage{fancyvrb}
\fvset{
	frame=single,
	numbers=left,
	numbersep=3pt,
	tabsize=4
}

% ------------------------------------------------------------------------------
% Images
% ------------------------------------------------------------------------------
\RequirePackage{graphicx}
\RequirePackage{pdflscape}
\RequirePackage{float}

% ------------------------------------------------------------------------------
% Tableaux
% ------------------------------------------------------------------------------
\RequirePackage{ltabulary}
\colorlet{table-row-odd}{tango-aluminium-1}
\definecolor{table-row-even}{HTML}{FFFFFF}

% ------------------------------------------------------------------------------
% Paragraphes
% ------------------------------------------------------------------------------

\renewcommand{\baselinestretch}{1.5}

\newlength{\simpleinter}
\setlength{\simpleinter}{\baselineskip}
\newlength{\doubleinter}
\setlength{\doubleinter}{1.5\baselineskip}

\RequirePackage{setspace}

\parindent=0ex
\parskip=2ex

% ------------------------------------------------------------------------------
% Marges
% ------------------------------------------------------------------------------

\setlength{\oddsidemargin}{1.35cm}
\setlength{\evensidemargin}{0.35cm}
\setlength{\topmargin}{1.3cm}
\setlength{\textwidth}{14.6cm}
\setlength{\textheight}{21.2cm}
\addtolength{\topmargin}{-\headheight}  % No header, so compensate
\addtolength{\topmargin}{-\headsep}     % for header height and separation

% ------------------------------------------------------------------------------
% Pages
% ------------------------------------------------------------------------------

% Code for creating empty pages
% No headers on empty pages before new chapter
\renewcommand{\cleardoublepage}{%
	\clearpage%
	\if@twoside
		\ifodd%
			\c@page%
		\else
			\mbox{}
			\thispagestyle{empty}
			\newpage
			\if@twocolumn%
				\mbox{}%
				\newpage%
			\fi%
		\fi%
	\fi
}


% Redefine '/chapter' to always start on an odd page.
% Should make no difference in singleside mode.
%
\renewcommand{\chapter}{%
	\cleardoublepage      % Starts new page.
	\thispagestyle{empty} % Page non numerotee
	\global\@topnum\z@    % Prevents figures from going at top of page.
	\@afterindenttrue     % indent in first paragraph.  Change to \@afterindentfalse to have none.
	\secdef\@chapter\@schapter%
}

% ------------------------------------------------------------------------------
% Chapitres et sections
% ------------------------------------------------------------------------------

\newcommand{\@numerochap}{\Roman{chapter}}
\renewcommand{\thechapter}{\arabic{chapter}}
\renewcommand{\thesection}{\thechapter.\arabic{section}}

\renewcommand{\@makechapterhead}[1]{%
	{%
		\parskip=0pt
		\vspace*{0.3 truecm}
		\parindent \z@ \raggedright \reset@font
		\ifnum \c@secnumdepth >\m@ne
			\centering{\MakeTextUppercase{\@chapapp{} \@numerochap}}
			\par
			\vskip 1.6truecm
		\fi
		\centering{\MakeTextUppercase{ #1}}\par

		\nobreak
		\vspace*{2.15 truecm}
		\parskip=2ex%
	}%
}

\renewcommand{\@makeschapterhead}[1]{
	\parskip=0pt
	\vspace*{0.1 truecm}
	\begin{center}
		{\MakeTextUppercase{ #1 }}%
		\par

	\end{center}
	\nobreak \vspace*{1.10 truecm}
	\parskip=2ex
}

\renewcommand{\section}{%
	\@startsection{section}{1}{\z@}%
	{1.5ex\@plus.2ex\@minus.2ex}%
	{1ex \@plus.2ex}%
	{\noindent\normalfont\baselineskip=\simpleinter}%
}
\renewcommand{\subsection}{%
	\@startsection{subsection}{2}{\z@}%
	{1.5ex\@plus .2ex \@minus .2ex}%
	{1ex \@plus .2ex}%
	{\normalfont\normalsize\baselineskip=\simpleinter}%
}
\renewcommand{\subsubsection}{%
	\@startsection{subsubsection}{3}{\z@}%
	{1.5ex\@plus .2ex \@minus .2ex}%
	{1ex \@plus .2ex}%
	{\normalfont\normalsize\baselineskip=\simpleinter}%
}
\renewcommand{\paragraph}{%
	\@startsection{paragraph}{4}{\z@}%
	{3.25ex \@plus1ex \@minus.2ex}%
	{-1em}%
	{\normalfont\normalsize\baselineskip=\simpleinter}%
}
\renewcommand{\subparagraph}{%
	\@startsection{subparagraph}{5}{\z@}%
	{3.25ex \@plus1ex \@minus .2ex}%
	{-1em}%
	{\normalfont\normalsize\baselineskip=\simpleinter}%
}

\markright{}
\pagestyle{myheadings}
\pagenumbering{arabic}

% ------------------------------------------------------------------------------
% Figures
% ------------------------------------------------------------------------------

\renewcommand{\thefigure}{{\thechapter.\@arabic\c@figure}}
\setlength\abovecaptionskip{10\p@}
\setlength\belowcaptionskip{5\p@}

\renewcommand{\@makecaption}[2]{%
	\vskip\abovecaptionskip
	\sbox\@tempboxa{{#1} #2}
	\ifdim \wd\@tempboxa >\hsize
		{#1} #2\par
	\else
		\global \@minipagefalse
		\hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
	\fi
	\vskip\belowcaptionskip%
}

\renewcommand{\fps@figure}{tbp}
\renewcommand{\ftype@figure}{1}
\renewcommand{\ext@figure}{lof}
\renewcommand{\fnum@figure}{{\figurename~}\thefigure}

\renewenvironment{figure}{%
	\@float{figure}%
}{%
	\end@float%
}

\renewenvironment{figure*}{%
	\@dblfloat{figure}%
}{%
	\end@dblfloat%
}

% ------------------------------------------------------------------------------
% Tables
% ------------------------------------------------------------------------------

\renewcommand{\thetable}{{\thechapter.\@arabic\c@table}}
\renewcommand{\fps@table}{tbp}
\renewcommand{\ftype@table}{2}
\renewcommand{\ext@table}{lot}
\renewcommand{\fnum@table}{{\tablename~}\thetable}

\renewenvironment{table}{%
	\@float{table}%
}{%
	\end@float%
}

\renewenvironment{table*}{%
	\@dblfloat{table}%
}{%
	\end@dblfloat%
}

% ------------------------------------------------------------------------------
% Table des matières
% ------------------------------------------------------------------------------

\renewcommand\tableofcontents{%
	\thispagestyle{empty}
	\baselineskip=\simpleinter
	\if@twocolumn
		\@restonecoltrue\onecolumn
	\else
		\@restonecolfalse
	\fi
	\chapter*{\@UpperRef{\contentsname}}
	\parskip=0ex
	\vspace*{-1.5ex}
	\@starttoc{toc}%
	\noindent
	\if@restonecol\twocolumn\fi
	\baselineskip=\doubleinter
	\parskip=2ex%
}

\renewcommand{\l@chapter}[2]{%
	\ifnum \c@tocdepth >\m@ne
		\addpenalty{-\@highpenalty}%
		\vskip 1.0em \@plus\p@
		\setlength\@tempdima{1.5em}%
		\begingroup
			\parindent \z@ \rightskip \@pnumwidth
			\parfillskip -\@pnumwidth
			\nopagebreak
			\leavevmode
			\hskip -\leftskip
			#1%
			\nobreak\hfil \nobreak\hbox to\@pnumwidth{\hss #2}\par
			\penalty\@highpenalty
		\endgroup
	\fi%
}

\def\@chapter[#1]#2{%
	\ifnum \c@secnumdepth >\m@ne
		\refstepcounter{chapter}%
		\typeout{\@chapapp\space\thechapter.}%
		\addtocontents{toc}{\protect\vspace{1.5ex}}
		\addtocontents{toc}{\noindent\@UpperRef{\@chapapp\protect\hskip 0.5em \@numerochap}\vskip 0ex}
		\addcontentsline{toc}{chapter}{\@UpperRef{#1}}
	\else
		\addcontentsline{toc}{chapter}{#1}
	\fi
	\chaptermark{#1}%
	\if@twocolumn
		 \@topnewpage[\@makechapterhead{#2}]%
	\else
		\@makechapterhead{#2}%
		\@afterheading
	\fi
}


\def\@sect#1#2#3#4#5#6[#7]#8{%
	\ifnum #2>\c@secnumdepth
		\let\@svsec\@empty
	\else
		\refstepcounter{#1} \protected@edef\@svsec{\@seccntformat{#1}\hskip 1em}%
	\fi
	\@tempskipa #5\relax
	\ifdim \@tempskipa>\z@
		\begingroup
			#6{%
				\relax
				\@hangfrom{\hskip #3\relax\@svsec}\interlinepenalty \@M #8\@@par%
			}%
		\endgroup
		\csname #1mark\endcsname%
		{#7}%
		\ifnum #2>\tw@
		\else
			%ne pas inserer si niveau de section > 2
			\addtocontents{toc}{\protect\vspace{1.5ex}}
			\addcontentsline{toc}{#1}{%
				\ifnum #2>\c@secnumdepth
				\else
					\protect\numberline{\csname the#1\endcsname}%
				\fi
				#7%
			}
		\fi
	\else
		\def\@svsechd{%
			#6{%
				\hskip #3\relax
				\@svsec #8%
			}%
			\csname #1mark\endcsname
			{#7}
			\addcontentsline{toc}{#1}{%
				\ifnum #2>\c@secnumdepth
				\else
					\protect\numberline{\csname the#1\endcsname}%
				\fi
				#7%
			}%
		}
	\fi
	\@xsect{#5}%
}

\renewcommand{\l@chapter}      {\@dottedtocline{0}{0em}{0em}}
\renewcommand{\l@section}      {\@dottedtocline{1}{0em}{2.3em}}
\renewcommand{\l@subsection}   {\@dottedtocline{2}{2.3em}{3.2em}}
\renewcommand{\l@subsubsection}{\@dottedtocline{3}{7.0em}{4.1em}}

% ------------------------------------------------------------------------------
% Appendices
% ------------------------------------------------------------------------------

\renewcommand{\appendix}{%
	\par
	\setcounter{chapter}{0}%
	\setcounter{section}{0}%
	\def\@chapapp{\@UpperRef{\appendixname}}%
	\renewcommand{\@numerochap}{\Alph{chapter}}
	\def\thechapter{\Alph{chapter}}%
}

% ------------------------------------------------------------------------------
% Liste des figures
% ------------------------------------------------------------------------------

\renewcommand{\listoffigures}{{%
	\baselineskip=\simpleinter
	\if@twocolumn
		\@restonecoltrue\onecolumn
	\else
		\@restonecolfalse
	\fi
    \chapter*{%
    	\@UpperRef{\listfigurename}
		\@mkboth{%
			\@UpperRef{\listfigurename}%
		}{%
			\@UpperRef{\listfigurename}%
		}%
	}%
	\addtocontents{toc}{\protect\vspace{1.5ex}}
	\addcontentsline{toc}{chapter}{\@UpperRef{\listfigurename}}
	\noindent \figurename \hfill Page
	\@starttoc{lof}%
	\if@restonecol%
		\twocolumn%
	\fi
}}

% ------------------------------------------------------------------------------
% Liste des tableaux
% ------------------------------------------------------------------------------

\renewcommand{\listoftables}{{%
	\baselineskip=\simpleinter

	\if@twocolumn
		\@restonecoltrue\onecolumn
	\else
		\@restonecolfalse
	\fi
    \chapter*{%
    	\@UpperRef{\listtablename}
		\@mkboth{%
			\@UpperRef{\listtablename}%
		}{%
			\@UpperRef{\listtablename}%
		}%
	}%
	\addtocontents{toc}{\protect\vspace{1.5ex}}
	\addcontentsline{toc}{chapter}{\@UpperRef{\listtablename}}
	\noindent \tablename \hfill Page
	\@starttoc{lot}%
	\if@restonecol%
		\twocolumn%
	\fi
}}

% ------------------------------------------------------------------------------
% Notes en bas de page
% ------------------------------------------------------------------------------

\setlength{\footnotesep}{\doubleinter}

\renewcommand{\@makefntext}[1]{%
	\setlength{\parindent}{2em}%
	\makebox[1.8em][r]{\@makefnmark}%
	#1%
}

\renewcommand{\footnoterule}{
	\noindent
	\rule{4cm}{0.4pt}
}

% ------------------------------------------------------------------------------
% Page titre
% ------------------------------------------------------------------------------

\newcommand{\@titleEnglish}{science}
\newcommand{\titleEnglish}[1]{
	\renewcommand{\@titleEnglish}{#1}
}

\newcommand{\@matter}{sciences}
\newcommand{\matter}[1]{
	\renewcommand{\@matter}{#1}
}

\newcommand{\@matterEnglish}{science}
\newcommand{\matterEnglish}[1]{
	\renewcommand{\@matterEnglish}{#1}
}

\newcommand{\@concentration}{}
\newcommand{\concentration}[1]{
	\renewcommand{\@concentration}{\MakeTextUppercase{#1}\\}
}

\newcommand{\@concentrationEnglish}{}
\newcommand{\concentrationEnglish}[1]{
	\renewcommand{\@concentrationEnglish}{\MakeTextUppercase{#1}\\}
}

\renewcommand{\maketitle}{
	\begin{titlepage}
	\begin{doublespace}
	\begin{center}
		UNIVERSIT\'E DU QU\'EBEC \`A MONTR\'EAL\\
		\vfill

		{\MakeTextUppercase{\@title}}\\
		\vfill

		\@theseType
		\\
		PR\'ESENT\'E\@theseAccord \\
		COMME EXIGENCE PARTIELLE\\
		\@theseProg\\
		\@concentration
		\vfill
		PAR\\
		{\MakeTextUppercase{\@author}}
		\\
		\vfill
		\MakeTextUppercase{\@monthFrench{\month} \the\year}
		\\
	\end{center}
	\end{doublespace}
	\end{titlepage}
}

\newcommand{\maketitleEnglish}{
	\begin{titlepage}
	\begin{doublespace}
	\begin{center}
		UNIVERSIT\'E DU QU\'EBEC \`A MONTR\'EAL\\
		\vfill

		{\MakeTextUppercase{\@titleEnglish}}\\
		\vfill

		\@theseTypeEnglish
		\\
		PRESENTED\\
		AS PARTIAL REQUIREMENT\\
		\@theseProgEnglish\\
		\@concentrationEnglish
		\vfill
		BY\\
		{\MakeTextUppercase{\@author}}
		\\
		\vfill
		\MakeTextUppercase{\@monthEnglish{\month} \the\year}
		\\
	\end{center}
	\end{doublespace}
	\end{titlepage}
}

\AtBeginDocument{
	\thispagestyle{empty}
	\maketitle
	\@ifEnglish{
		\maketitleEnglish
	}{}
	\pagenumbering{roman} % numérotation des pages en chiffres romains
	\addtocounter{page}{1} % Pour que les remerciements commencent à la page ii
}

% ------------------------------------------------------------------------------
% Résumé
% ------------------------------------------------------------------------------

\renewenvironment{abstract}{%
	\chapter*{\@UpperRef{\abstractname}}
	\addtocontents{toc}{\protect\vspace{1.5ex}}
	\addcontentsline{toc}{chapter}{\@UpperRef{\abstractname}}
	\baselineskip=\simpleinter%
}{}

\@ifEnglish{
	\newenvironment{resume}{%
		\begin{otherlanguage}{canadien}
		\chapter*{\@UpperRef{R\'esum\'e}}
		\addtocontents{toc}{\protect\vspace{1.5ex}}
		\addcontentsline{toc}{chapter}{\@UpperRef{R\'esum\'e}}
		\baselineskip=\simpleinter%
	}{%
		\end{otherlanguage}%
	}
}{
	\excludecomment{resume}
}

% ------------------------------------------------------------------------------
% Introduction
% ------------------------------------------------------------------------------

\newenvironment{introduction}{%
	\chapter*{\@UpperRef{Introduction}}
	\pagenumbering{arabic}
	\setcounter{page}{1}
	\addtocontents{toc}{\protect\vspace{1.5ex}}
	\addcontentsline{toc}{chapter}{\@UpperRef{Introduction}}
}

% ------------------------------------------------------------------------------
% Conclusion
% ------------------------------------------------------------------------------

\newenvironment{conclusion}{%
	\chapter*{\@UpperRef{Conclusion}}
	\addtocontents{toc}{\protect\vspace{1.5ex}}
	\addcontentsline{toc}{chapter}{\@UpperRef{Conclusion}}
}

\endinput
