\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resonancecv}[2026/03/14 v0.2 Resonance CV class]

\newif\ifresonance@lineheader\resonance@lineheadertrue

\DeclareOption{line}{\resonance@lineheadertrue}
\DeclareOption{centered}{\resonance@lineheaderfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\LoadClass[10pt,letterpaper]{article}

\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{lmodern}
\RequirePackage{geometry}
\RequirePackage{calc}
\RequirePackage{changepage}
\RequirePackage{enumitem}
\RequirePackage{tabularx}
\RequirePackage{array}
\RequirePackage{ragged2e}
\RequirePackage{xparse}
\RequirePackage{etoolbox}
\RequirePackage{microtype}
\RequirePackage{xcolor}
\RequirePackage{needspace}
\RequirePackage{hyperref}
\RequirePackage{url}

\geometry{
  letterpaper,
  left=0.55in,
  right=0.55in,
  top=0.45in,
  bottom=0.45in
}

\definecolor{ResonanceAccent}{HTML}{1F4E79}
\definecolor{ResonanceMuted}{HTML}{4B5563}

\hypersetup{
  colorlinks,
  citecolor=black,
  filecolor=black,
  linkcolor=black,
  urlcolor=ResonanceAccent
}

\urlstyle{same}
\pagestyle{empty}
\setlength{\parindent}{0pt}
\setlength{\parskip}{0pt}
\emergencystretch=2em
\raggedbottom
\clubpenalty=10000
\widowpenalty=10000
\displaywidowpenalty=10000

%% ── Layout dimensions ──────────────────────────────────────────────
\newlength{\resonance@sectionwidth}
\newlength{\resonance@sectiongap}
\newlength{\resonance@bodyindent}
\newlength{\resonance@datewidth}
\setlength{\resonance@sectionwidth}{0.85in}
\setlength{\resonance@sectiongap}{0.08in}
\setlength{\resonance@datewidth}{1.45in}
\setlength{\resonance@bodyindent}{\resonance@sectionwidth + \resonance@sectiongap}

%% ── Fonts ──────────────────────────────────────────────────────────
\newcommand{\sectionfont}{\normalfont\sffamily\bfseries\footnotesize\color{ResonanceAccent}}
\newcommand{\namefont}{\fontsize{18}{20}\selectfont\bfseries}
\newcommand{\taglinefont}{\small\itshape\color{ResonanceMuted}}
\newcommand{\entrytitlefont}{\normalfont\bfseries}
\newcommand{\entryorgfont}{\normalfont\itshape}
\newcommand{\datefont}{\small\bfseries\color{ResonanceMuted}}
\newcommand{\subheadingfont}{\normalfont\sffamily\bfseries\footnotesize\color{ResonanceMuted}}
\newcommand{\scholarlyfont}{\normalsize}

%% ── Column types ───────────────────────────────────────────────────
\newcolumntype{Y}{>{\RaggedRight\arraybackslash}X}
\newcolumntype{R}[1]{>{\raggedleft\arraybackslash}p{#1}}

%% ── Internal storage ──────────────────────────────────────────────
\newcommand{\resonance@name}{}
\newcommand{\resonance@tagline}{}
\newcommand{\resonance@contacts}{}
\newcommand{\resonance@pdftitle}{Curriculum Vitae}

%% ── User commands ─────────────────────────────────────────────────
\NewDocumentCommand{\name}{m}{\gdef\resonance@name{#1}}
\NewDocumentCommand{\tagline}{m}{\gdef\resonance@tagline{#1}}
\NewDocumentCommand{\cvtitle}{m}{\gdef\resonance@pdftitle{#1}}
\NewDocumentCommand{\setsectionwidth}{m}{%
  \setlength{\resonance@sectionwidth}{#1}%
  \setlength{\resonance@bodyindent}{\resonance@sectionwidth + \resonance@sectiongap}%
}
\NewDocumentCommand{\setdatewidth}{m}{\setlength{\resonance@datewidth}{#1}}

%% ── Contact rows ──────────────────────────────────────────────────
\newcommand{\resonance@contactrow}[2]{%
  \noindent\begin{tabularx}{\linewidth}{@{}Y@{\hspace{1em}}>{\raggedleft\arraybackslash}X@{}}
  #1 & #2\\
  \end{tabularx}\par
}

\NewDocumentCommand{\contactline}{m m}{%
  \gappto\resonance@contacts{\resonance@contactrow{#1}{#2}}%
}

%% ── Metadata ──────────────────────────────────────────────────────
\newcommand{\resonance@applymetadata}{%
  \hypersetup{
    pdftitle={\resonance@pdftitle},
    pdfauthor={\resonance@name},
    pdfsubject={Curriculum Vitae}
  }%
}

%% ── Header ────────────────────────────────────────────────────────
\newcommand{\resonance@makeheader}{%
  \resonance@applymetadata
  \ifresonance@lineheader
    {\namefont \resonance@name\par}
    \ifstrempty{\resonance@tagline}{}{\vspace{0.1em}{\taglinefont \resonance@tagline\par}}
    \vspace{0.25em}
    \resonance@contacts
    \vspace{0.2em}\hrule height 0.4pt\vspace{0.45em}
  \else
    \begin{center}
      {\namefont \resonance@name\par}
      \ifstrempty{\resonance@tagline}{}{\vspace{0.1em}{\taglinefont \resonance@tagline\par}}
    \end{center}
    \vspace{0.25em}
    \resonance@contacts
    \vspace{0.45em}
  \fi
}

%% ── Resume environment ───────────────────────────────────────────
\newenvironment{resume}{%
  \resonance@makeheader
  \begin{adjustwidth}{\resonance@bodyindent}{0pt}
}{%
  \end{adjustwidth}
}

%% ── Section ──────────────────────────────────────────────────────
\renewcommand\section[1]{%
  \par\Needspace{3\baselineskip}\addvspace{0.65\baselineskip}%
  \noindent\leavevmode
  \makebox[0pt][r]{%
    \parbox[t]{\resonance@sectionwidth}{\RaggedRight\sectionfont #1}%
    \hspace{\resonance@sectiongap}%
  }%
  \ignorespaces
}

%% ── Lists ────────────────────────────────────────────────────────
\newlist{cvitems}{itemize}{2}
\setlist[cvitems,1]{label=\textbullet,leftmargin=1.1em,itemsep=0pt,topsep=1.5pt,parsep=0pt,partopsep=0pt}
\setlist[cvitems,2]{label=\textendash,leftmargin=1.2em,itemsep=0pt,topsep=1pt,parsep=0pt,partopsep=0pt}

\newenvironment{list1}{\begin{cvitems}}{\end{cvitems}}
\newenvironment{list2}{\begin{cvitems}}{\end{cvitems}}

%% ── Shared content-width length ──────────────────────────────────
\newlength{\resonance@contentwidth}

%% ── Entry macros ─────────────────────────────────────────────────

% Full entry: bold title + date row, italic org, then body
\NewDocumentCommand{\cventry}{m m m +m}{%
  \ifhmode\unskip\else\Needspace{4\baselineskip}\addvspace{0.35\baselineskip}\noindent\fi%
  \setlength{\resonance@contentwidth}{\dimexpr\linewidth-\resonance@datewidth-0.5em\relax}%
  \parbox[t]{\resonance@contentwidth}{\entrytitlefont #1}%
  \hfill{\datefont\mbox{#3}}\par\nopagebreak
  {\entryorgfont #2}\par\nopagebreak
  #4\par
}

% Degree entry: alias for \cventry (same visual treatment)
\let\degreeentry\cventry

% Dated item: bold title + date row, then body
\NewDocumentCommand{\cvdateditem}{m m +m}{%
  \ifhmode\unskip\else\Needspace{3\baselineskip}\addvspace{0.35\baselineskip}\noindent\fi%
  \setlength{\resonance@contentwidth}{\dimexpr\linewidth-\resonance@datewidth-0.5em\relax}%
  \parbox[t]{\resonance@contentwidth}{\entrytitlefont #1}%
  \hfill{\datefont\mbox{#2}}\par\nopagebreak
  #3\par
}

% Row: text + date on one line
\NewDocumentCommand{\cvrow}{m m}{%
  \ifhmode\unskip\else\addvspace{0.1\baselineskip}\noindent\fi%
  \setlength{\resonance@contentwidth}{\dimexpr\linewidth-\resonance@datewidth-0.5em\relax}%
  \parbox[t]{\resonance@contentwidth}{#1}%
  \hfill{\datefont\mbox{#2}}\par
}

% Minor row: dense, bulleted, minimal spacing
\NewDocumentCommand{\cvminorrow}{m m}{%
  \ifhmode\unskip\else\addvspace{0.1\baselineskip}\noindent\fi%
  \setlength{\resonance@contentwidth}{\dimexpr\linewidth-\resonance@datewidth-0.5em\relax}%
  \parbox[t]{\resonance@contentwidth}{\textbullet\ #1}%
  \hfill{\datefont\mbox{#2}}\par
}

%% ── Academic macros ──────────────────────────────────────────────

\newcommand{\cvsubheading}[1]{%
  \ifhmode\unskip\else\Needspace{2\baselineskip}\addvspace{0.35\baselineskip}\noindent\fi{\subheadingfont #1\par}\vspace{0.05em}
}

\NewDocumentCommand{\pubentry}{+m}{%
  \ifhmode\unskip\else\Needspace{2\baselineskip}\addvspace{0.15\baselineskip}\fi%
  {\scholarlyfont\RaggedRight\sloppy\hangindent=1.2em\hangafter=1\noindent #1\par}%
}

\NewDocumentCommand{\talkentry}{m m m}{%
  \ifhmode\unskip\else\Needspace{3\baselineskip}\addvspace{0.3\baselineskip}\noindent\fi%
  \setlength{\resonance@contentwidth}{\dimexpr\linewidth-\resonance@datewidth-0.5em\relax}%
  \parbox[t]{\resonance@contentwidth}{\entryorgfont #1}%
  \hfill{\datefont\mbox{#2}}\par\nopagebreak
  {\scholarlyfont #3\par}
}
