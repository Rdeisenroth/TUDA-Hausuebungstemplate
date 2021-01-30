\def\fileversion{1.00}
\def\filedate{2020/12/05}

% Sets the LaTeX version for the package to work.
\NeedsTeXFormat{LaTeX2e}
% Identification of the class and its date and version.
\ProvidesClass{Tuda_Hausuebung} [Hausuebungsvorlage basierend auf TuDaExercise]


% Studenten und Matrikelnummern
\newcommand*{\studentEins}[2]{ % Name, Matrikelnummer
	\gdef\@studentNameEins{#1}
    \gdef\@matrikelnummerEins{#2}
}
\newcommand*{\studentZwei}[2]{ % Name, Matrikelnummer
	\gdef\@studentNameZwei{#1}
    \gdef\@matrikelnummerZwei{#2}
}
\newcommand*{\studentDrei}[2]{ % Name, Matrikelnummer
	\gdef\@studentNameDrei{#1}
    \gdef\@matrikelnummerDrei{#2}
}


\newcommand{\taskstyle}{1} % Default task style
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{tudaexercise}}
\ProcessOptions\relax
\LoadClass[
	%fontsize= 12pt,
	a4paper,
	ngerman,
	color=3b,% Farbe für Hervorhebungen auf Basis der Deklarationen in den
	%type=intern,
	%titlepage=true,
    marginpar=false,
    colorback=false,
    %logo=head,
    leqno,
    fleqn,
	]{tudaexercise}
  
\RequirePackage{enumitem}
\RequirePackage{totcount}
\regtotcounter{task}

% Strings
\renewcaptionname*{ngerman}{\solutionname}{Lösung}

% Punkteformat
\newcommand{\definevalue}[2]{%
  \begingroup\edef\x{\endgroup
    \write\@auxout{%
      \global\string\@namedef{usevalue@#1}{#2}%
    }%
  }\x
}

\newcommand{\definevalueNoOverwrite}[2]{%
  \ifx \value{subtask} 0\relax%
    %
  \else%
    \definevalue{#1}{#2}%
  \fi%
}

\newcommand{\usevalue}[1]{%
  \ifcsname usevalue@#1\endcsname
    \csname usevalue@#1\endcsname
  \else
    0
  \fi
}

\ExplSyntaxOn
\renewcommand*{\pointformat}[1]{
	\int_case:nnF {#1}
		{
		{0} {}
		{1} {\creditformat{\int_to_arabic:n {#1}\space\PointName}}
		}
		{\creditformat{\int_to_arabic:n {#1}\space\PointsName}}
	}
\ExplSyntaxOff
\renewcommand*{\creditformat}[1]{\hfill\space(#1)}
\renewcommand*{\subtaskformat}{\thetask{}\space\thesubtask\enskip}

% \newcommand{\verifystudents}{
% 	%\ifx
% }
% \let\oldtitle\title
\newcommand*{\verifyStudents}{ 
     % Make Sure at least two Students are correctly defined
    \ifdefined\@studentNameEins
        \ifdefempty{\@studentNameEins}{\ClassError{Tuda_Hausuebung}{Student Name eins leer}{Ein Student braucht Name und Matrikelnummer}}{}
        \ifdefined\@matrikelnummerEins
            \ifdefempty{\@matrikelnummerEins}{\ClassError{Tuda_Hausuebung}{matrikelnummer von Student Eins leer}{Ein Student braucht Name und Matrikelnummer}}{}
        \else
            \ClassError{Tuda_Hausuebung}{matrikelnummer von Student Eins undefiniert}{Ein Student braucht Name und Matrikelnummer}
        \fi
    \else
        \ClassError{Tuda_Hausuebung}{Student eins undefiniert}{Eine Abgabe braucht mindestens einen Studenten}
    \fi
    \ifdefined\@studentNameZwei
        \ifdefempty{\@studentNameZwei}{\ClassError{Tuda_Hausuebung}{Student Name zwei leer}{Ein Student braucht Name und Matrikelnummer}}{}
        \ifdefined\@matrikelnummerZwei
            \ifdefempty{\@matrikelnummerZwei}{\ClassError{Tuda_Hausuebung}{matrikelnummer von Student zwei leer}{Ein Student braucht Name und Matrikelnummer}}{}
        \else
            \ClassError{Tuda_Hausuebung}{matrikelnummer von Student zwei undefiniert}{Ein Student braucht Name und Matrikelnummer}
        \fi
	\else
		% Uncomment the following line if two students are required
        %\ClassError{Tuda_Hausuebung}{Student zwei undefiniert}{Eine Abgabe braucht mindestens zwei Studenten}
    \fi
    \ifdefined\@studentNameDrei
        \ifdefempty{\@studentNameDrei}{\ClassError{Tuda_Hausuebung}{Student Name drei leer}{Ein Student braucht Name und Matrikelnummer}}{}
        \ifdefined\@matrikelnummerDrei
            \ifdefempty{\@matrikelnummerDrei}{\ClassError{Tuda_Hausuebung}{matrikelnummer von Student drei leer}{Ein Student braucht Name und Matrikelnummer}}{}
        \else
            % Uncomment the following line if three students are required
        	%\ClassError{Tuda_Hausuebung}{Student zwei undefiniert}{Eine Abgabe braucht mindestens zwei Studenten}
        \fi
    \else
        
    \fi
}

\newcommand*{\maketerm}{
	\term{
	    \begin{minipage}[t]{.5\textwidth}
	        \textbf{\sffamily Abgabe von:}\newline%
				\@studentNameEins\space(Mat.:\space\@matrikelnummerEins)%
					\ifthenelse{\isundefined{\@studentNameZwei}}{}{%
						,\newline\@studentNameZwei\space(Mat.:\space\@matrikelnummerZwei)%
					}%
					\ifthenelse{\isundefined{\@studentNameDrei}}{}{%
						,\newline\@studentNameDrei\space(Mat.:\space\@matrikelnummerDrei)%
					}%
		\end{minipage}
		\begin{minipage}[t]{.49\textwidth}
			\raggedleft
			\begin{flushright}
				\printSheetNumber{}\printGroupNumber{}\printGroupLeader{}
			\end{flushright}
		\end{minipage}
		\vspace*{2ex}
	}
}

\newcommand*{\printGradeTable}{%
    \begin{minipage}{\textwidth}
    \centering
    \begin{tikzpicture}
        \tikzstyle{Pointstablenode} = [draw, minimum height=1cm, minimum width=1cm];
        \tikzstyle{leftPointstablenode} = [Pointstablenode, text width=3.5cm];
        \node[leftPointstablenode](r1-0){Aufgabe};
        \node[leftPointstablenode, below=-\pgflinewidth of r1-0](r2-0){maximale Punktzahl};
        \node[leftPointstablenode, below=-\pgflinewidth of r2-0](r3-0){erreichte Punktzahl};
        \newcounter{totmp}\setcounter{totmp}{0}
        \foreach \i in {1,...,\totvalue{task}}{
            \pgfmathtruncatemacro{\j}{\i-1}
            \node[Pointstablenode,right=-\pgflinewidth of r1-\j](r1-\i){\i};
            \node[Pointstablenode,right=-\pgflinewidth of r2-\j](r2-\i){\usevalue{cp\i}};
            \node[Pointstablenode,right=-\pgflinewidth of r3-\j](r3-\i){};
            \addtocounter{totmp}{\usevalue{cp\i}}
        }
        % Summe
        \pgfmathtruncatemacro{\i}{\totvalue{task}}
        \pgfmathtruncatemacro{\k}{\totvalue{task}+1}
        \pgfmathtruncatemacro{\l}{\k+1}
        \node[Pointstablenode,right=-\pgflinewidth of r1-\i](r1-\k){$\sum$};
        \node[Pointstablenode,right=-\pgflinewidth of r2-\i](r2-\k){\thetotmp};
        \node[Pointstablenode,right=-\pgflinewidth of r3-\i](r3-\k){};
        \node[Pointstablenode,right=-\pgflinewidth of r1-\k](r1-\l){Note};
        \node[Pointstablenode,minimum height=2cm, below=-\pgflinewidth of r1-\l](r2-\l){};
    \end{tikzpicture}
    
\end{minipage}
}

% Prefix filling 0 if the number is smaller than 10.
\newcommand*{\twodigits}[1]{\ifnum #1 < 10 0#1\else #1\fi}

%% Sheet number
\ExplSyntaxOn
\newcommand*{\getSheetnumber}{\g_ptxcd_ex_sheetnum_tl}
\newcommand*{\printSheetNumber}{\tl_if_empty:NF \g_ptxcd_ex_sheetnum_tl {\sffamily\textbf{Übungsblatt\space{}Nummer:}\space\twodigits{\getSheetnumber}\\}}
\ExplSyntaxOff

% Group Number
\ExplSyntaxOn
\tl_new:N \g_ptxcd_ex_groupnum_tl
\newcommand*{\groupnumber}[1]{\tl_gset:Nn \g_ptxcd_ex_groupnum_tl {#1}}
\groupnumber{}
\newcommand*{\getGroupnumber}{\g_ptxcd_ex_groupnum_tl}
\newcommand*{\printGroupNumber}{\tl_if_empty:NF \g_ptxcd_ex_groupnum_tl {\sffamily\textbf{Übungsgruppe\space{}Nummer:}\space\twodigits{\getGroupnumber}\\}}
\ExplSyntaxOff

%Group Leader
\ExplSyntaxOn
\tl_new:N \g_ptxcd_ex_groupleader_tl
\newcommand*{\groupleader}[1]{\tl_gset:Nn \g_ptxcd_ex_groupleader_tl {#1}}
\groupnumber{}
\newcommand*{\getGroupLeader}{\g_ptxcd_ex_groupleader_tl}
\newcommand*{\printGroupLeader}{\tl_if_empty:NF \g_ptxcd_ex_groupleader_tl {\sffamily\textbf{Übungsgruppenleiter:}\space\getGroupLeader\\}}
\ExplSyntaxOff

\ExplSyntaxOn
\newcommand*{\getShortTitle}{\g_ptxcd_shorttitle_tl}
\ExplSyntaxOff
% \ExplSyntaxOn
% \newcommand*{\getPoints}{\l_ptxcd_ex_1_points_int}
% \ExplSyntaxOff

\ExplSyntaxOn
\renewcommand*{\@maketitle}{%
	\verifyStudents{}
	\maketerm{}
  \global\@topnum=\z@
  \setparsizes{\z@}{\z@}{\z@\@plus 1fil}\par@updaterelative
  \vspace*{-\dim_eval:n {
      \headheight
	-\c_ptxcd_largerule_dim -\c_ptxcd_rulesep_dim
      +\headsep
      +\ht\strutbox
      +\p@
    }}
  \par
  \nointerlineskip
  \begingroup
  \setlength{\fboxsep}{\z@}
  \bool_if:NT \g_ptxcd_colorback_bool {\colorbox{accentcolor}}{\parbox[t]{\linewidth}{
	\rule{0pt}{\bool_if:NTF \g_ptxcd_smalltitle_bool {.25} {.5}\c_ptxcd_logoheight_dim}
	\par\nointerlineskip
      \raisebox{-\height}{%
        \begin{minipage}[t]{\dimexpr\linewidth-2.2\c_ptxcd_logoheight_dim-1ex}
          \bool_if:NT \g_ptxcd_colorback_bool  {\begin{addmargin}{3mm}}
            \raggedright
            \bool_if:NT \g_ptxcd_colorback_bool {\color{textonaccentcolor}}
            \tl_if_empty:NF \@titlehead {\usekomafont{titlehead}{\@titlehead\par}}
            \leavevmode\usekomafont{title}%
            {\usekomafont{title}\bool_if:NTF \g_ptxcd_smalltitle_bool {\LARGE} {\huge} {\@title\par}}%
            \vskip 1em
            \bool_if:NF \g_ptxcd_ex_compatibility_bool
	            {
					{\ifx\@subtitle\@empty\else\usekomafont{subtitle}\@subtitle\par\fi}%
					\gdef\@subtitle{}
					\vskip .5em
				}
			{
              \xdef\@author {\@author}
              \ifx\@author\@empty\else\usekomafont{author}\@author\par\fi
			}
            \vskip .5em
          \bool_if:NTF \g_ptxcd_colorback_bool {\end{addmargin}} {\par}
        \end{minipage}}
		\tl_if_empty:NF \g_ptxcd_logofile_tl {
		\hfill\raisebox{\dim_eval:n {
				\bool_if:NTF \g_ptxcd_colorback_bool
				{-\height}
				{-.9\c_ptxcd_logoheight_dim}
			}}
			[0pt]
			[\dim_eval:n {
			\bool_if:NTF \g_ptxcd_smalltitle_bool
				{\bool_if:NTF \g_ptxcd_colorback_bool {1.15}{1}}
				{\bool_if:NTF \g_ptxcd_colorback_bool {1.5}{1.3}
			}\c_ptxcd_logoheight_dim}]
		{\makebox[2.2\c_ptxcd_logoheight_dim][l]{\includegraphics[height=\c_ptxcd_logoheight_dim]{\g_ptxcd_logofile_tl}}}
		}
      \par\medskip
    }}
  \par
  \nointerlineskip
  \rule{\linewidth}{\g_ptxcd_titlerule_dim}
    % subtitle fields if not compat
  \exp_args:Nf \tl_if_empty:nF {\g_ptxcd_ex_sheetnum_tl\@date\g_ptxcd_ex_term_tl\use:c {@subsubtitle}\@subtitle}{
    \par\nointerlineskip
    \bool_if:NT \g_ptxcd_colorback_bool {\colorbox{accentcolor}}{
      \parbox{\linewidth}{
        \begin{minipage}{\linewidth}
			\bool_if:NT \g_ptxcd_colorback_bool {
				\color{textonaccentcolor}
				\begin{addmargin}{3mm}
			}
            \null\par
            \def\ptxcd_nextsep{}
            \clist_map_inline:nn {@subtitle, @subsubtitle, g_ptxcd_ex_term_tl, @date} {
              \tl_if_empty:cF {##1} {\ptxcd_nextsep\use:c {##1}\def\ptxcd_nextsep{\\}}
            }
            %\tl_if_empty:NF \g_ptxcd_ex_sheetnum_tl {\ptxcd_nextsep\sheetname\sheetsep\g_ptxcd_ex_sheetnum_tl}
          \bool_if:NT \g_ptxcd_colorback_bool {\end{addmargin}}
        \end{minipage}
        \vspace*{\dp\strutbox}
      }}\par\nointerlineskip
    \rule{\linewidth}{\g_ptxcd_titlerule_dim}
  }
  \par
  \bool_if:NT  \g_ptxcd_headontitle_bool {
    \if@twoside
    \box_use:N \g_ptxcd_ex_headline_odd_box
    \else
    \box_use:N \g_ptxcd_ex_headline_oneside_box
    \fi
    \par
    \rule{\linewidth}{\g_ptxcd_titlerule_dim}
    \par
  }
  \endgroup
  \vskip 2em
  \ConfigureHeadline{}
}%

\ExplSyntaxOn
\renewcommand*\sectionlinesformat[4]{%
\parbox{\linewidth}{
	\rule[5\g_ptxcd_titlerule_dim]{\linewidth}{\g_ptxcd_titlerule_dim}\par\nointerlineskip
	\@hangfrom{%
		\hskip #2#3}{
		\tl_if_eq:nnT {#1} {task} {
      \definevalue{cp\arabic{task}}{\int_to_arabic:n {\tl_use:c {l_ptxcd_ex_#1_points_int}}}
			\exp_args:No \tl_if_empty:nF {\textmd{#4}}
				{:~}
    }
    {\textmd{#4}}
		\tl_if_in:nnT {#1} {task} {
			\tl_if_empty:cTF{l_ptxcd_ex_#1_credit_tl}
				{\pointformat{\tl_use:c {l_ptxcd_ex_#1_points_int}}}
				{\creditformat{\tl_use:c {l_ptxcd_ex_#1_credit_tl}}}
		}
		\rule[-\dp\strutbox]{0pt}{\dp\strutbox}\par}\nointerlineskip
		\skip_vertical:n {\ptxcd_titlerule_sep: -\dp\strutbox}
	\smash{\rule{\linewidth}{\g_ptxcd_titlerule_dim}}
}}
\ExplSyntaxOff



% Makros
\newenvironment*{cpenumerate}[1][]{\begin{enumerate}[nosep, #1]}{\end{enumerate}}

\newcommand{\gegeben}{\textbf{\textsf{Gegeben: }}}
\newcommand{\gesucht}{\textbf{\textsf{Gesucht: }}}
\newcommand{\zuzeigen}{\textbf{\textsf{Zu zeigen: }}}
\newcommand{\zuberechnen}{\textbf{\textsf{Zu berechnen: }}}
\newcommand{\zubestimmen}{\textbf{\textsf{Zu bestimmen: }}}
\newcommand{\anzugeben}{\textbf{\textsf{Anzugeben: }}}
\newcommand{\loesung}{\textbf{\textsf{Lösung: }}}
\newcommand{\rechnung}{\textbf{\textsf{Rechnung: }}}