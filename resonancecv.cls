%% ============================================================================
%% resonancecv.cls — Resonance CV Class  v0.3
%% ============================================================================
%%
%% Copyright (c) 2026 Enes Kemal Ergin
%%
%% Permission is hereby granted, free of charge, to any person obtaining a copy
%% of this software and associated documentation files (the "Software"), to deal
%% in the Software without restriction, including without limitation the rights
%% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
%% copies of the Software, and to permit persons to whom the Software is
%% furnished to do so, subject to the following conditions:
%%
%% The above copyright notice and this permission notice shall be included in
%% all copies or substantial portions of the Software.
%%
%% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
%% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
%% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
%% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
%% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
%% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
%% THE SOFTWARE.
%%
%% ============================================================================
%%
%% A modern, minimalist academic and professional CV class.
%%
%% DESIGN PHILOSOPHY
%%   Section labels live in a narrow left-margin gutter; all body content sits
%%   in a clean indented column.  Every entry type shares a consistent right-
%%   aligned date column.  A single sans-serif family is used throughout —
%%   hierarchy is achieved with weight, size, and colour, not family mixing.
%%
%% CLASS OPTIONS
%%   line      (default)  Header ends with a thin horizontal rule.
%%   centered             Header is centred; no rule.
%%   Any option accepted by the article class (e.g. 10pt, 11pt) passes through.
%%
%% QUICK-REFERENCE — USER COMMANDS
%% ─────────────────────────────────────────────────────────────────────────────
%% Preamble setup
%%   \name{Full Name}               Name shown in the header.
%%   \tagline{Short descriptor}     One-line descriptor below the name.
%%   \cvtitle{PDF title string}     Sets the PDF document title metadata.
%%   \contactline{left}{right}      Adds one two-column contact row.
%%
%% Layout & colour overrides  (call in preamble, after \documentclass)
%%   \setsectionwidth{0.95in}       Width of the left-margin gutter.
%%   \setdatewidth{1.45in}          Width of the right date column.
%%   \setaccentcolor{HTML}{1F4E79}  Accent colour (section labels, links).
%%   \setmutedcolor{HTML}{4B5563}   Muted colour (dates, orgs, sub-heads).
%%
%% Entry macros  (use inside the {resume} environment)
%%   \cventry{title}{org}{date}{body}      Full entry: title+date / org / body.
%%   \degreeentry{degree}{uni}{date}{body} Semantic alias for \cventry.
%%   \cvdateditem{title}{date}{body}       Entry with title+date row, then body.
%%   \cvminorrow{text}{date}               Compact bulleted entry + right date.
%%   \cvrow{text}{date}                    Plain text + right date (no bullet).
%%   \cvskill{Category}{items}             Skill bullet: bold label + items.
%%   \cvsubheading{text}                   In-body sub-section grouping label.
%%   \pubentry{full reference text}        Hanging-indent bibliographic entry.
%%   \talkentry{venue}{date}{title}        Talk: venue+date row, then title.
%%
%% List environments
%%   list1, list2   Bulleted lists with tight spacing (two indent levels).
%%   (Both are aliases for the internal cvitems environment.)
%% ============================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resonancecv}[2026/03/14 v0.3 Resonance CV class]

%% ── Class options ─────────────────────────────────────────────────────────────
\newif\ifresonance@lineheader\resonance@lineheadertrue   % default: ruled header
\DeclareOption{line}    {\resonance@lineheadertrue}
\DeclareOption{centered}{\resonance@lineheaderfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\LoadClass[10pt,letterpaper]{article}

%% ── Required packages ─────────────────────────────────────────────────────────
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{lmodern}          % Latin Modern — high-quality scalable fonts
\RequirePackage{geometry}         % page margins
\RequirePackage{calc}             % arithmetic on lengths
\RequirePackage{changepage}       % adjustwidth (body indent environment)
\RequirePackage{enumitem}         % list customisation (tight spacing, labels)
\RequirePackage{tabularx}         % stretchy-column tables (contact rows)
\RequirePackage{array}            % extended column types
\RequirePackage{ragged2e}         % \RaggedRight with hyphenation
\RequirePackage{xparse}           % \NewDocumentCommand
\RequirePackage{etoolbox}         % \gappto, \ifstrempty
\RequirePackage{microtype}        % microtypography (protrusion & expansion)
\RequirePackage{xcolor}           % colour support
\RequirePackage{needspace}        % \Needspace — avoid orphaned section heads
\RequirePackage{hyperref}         % clickable links & PDF metadata
\RequirePackage{xurl}             % \xurl command and style control
% \RequirePackage{fontawesome5}     % icon support
% \RequirePackage{fontawesome5}      % icon support

%% ── Page geometry ─────────────────────────────────────────────────────────────
\geometry{
  letterpaper,
  left   = 0.55in,
  right  = 0.55in,
  top    = 0.45in,
  bottom = 0.45in,
}

%% ── Colours ───────────────────────────────────────────────────────────────────
%% Default palette. Override with \setaccentcolor / \setmutedcolor in preamble.
\definecolor{ResonanceAccent}{HTML}{1F4E79}   % deep navy  — section labels, links
\definecolor{ResonanceMuted}{HTML}{4B5563}    % cool grey  — dates, orgs, sub-heads

%% \setaccentcolor{colour model}{spec}   e.g. \setaccentcolor{HTML}{2E4057}
\NewDocumentCommand{\setaccentcolor}{m m}{%
  \definecolor{ResonanceAccent}{#1}{#2}%
  \hypersetup{urlcolor=ResonanceAccent}%
}
%% \setmutedcolor{colour model}{spec}    e.g. \setmutedcolor{HTML}{6B7280}
\NewDocumentCommand{\setmutedcolor}{m m}{%
  \definecolor{ResonanceMuted}{#1}{#2}%
}

%% ── Hyperref ──────────────────────────────────────────────────────────────────
\hypersetup{
  colorlinks,
  citecolor = black,
  filecolor = black,
  linkcolor = black,
  urlcolor  = ResonanceAccent,
}

%% ── Global typography ────────────────────────────────────────────────────────
%% Single font family: Latin Modern Sans (sfdefault).
%% Typographic hierarchy is achieved with weight, size, and colour alone —
%% no font-family mixing inside the body column.
\renewcommand{\familydefault}{\sfdefault}
\urlstyle{same}                    % URLs match surrounding (sans-serif) text
\pagestyle{empty}                  % no running headers or page numbers
\setlength{\parindent}{0pt}        % no first-line indent anywhere
\setlength{\parskip}{0pt}          % no inter-paragraph space (macros own spacing)
\emergencystretch = 2em            % allows slight stretch to avoid overfull hboxes
\raggedbottom                      % don't stretch pages vertically
\clubpenalty         = 10000       % forbid orphan lines
\widowpenalty        = 10000       % forbid widow lines
\displaywidowpenalty = 10000

%% ── Layout dimensions ─────────────────────────────────────────────────────────
%% Adjust \setsectionwidth and \setdatewidth in your preamble if needed.
%%
%%  ┌── left margin ──┬─── gutter ───┬──── body / content ────┬─── dates ───┐
%%  │   (geometry)    │ sectionwidth │   (adjustwidth col)    │  datewidth  │
%%  └─────────────────┴──────────────┴────────────────────────┴─────────────┘
%%  ←─ bodyindent (sectionwidth + sectiongap) ─→←── linewidth (body total) ──→
%%                                              ←── contentwidth (computed) ─→
%%
\newlength{\resonance@sectionwidth}   % gutter column: holds section labels
\newlength{\resonance@sectiongap}     % gap between gutter edge and body text
\newlength{\resonance@bodyindent}     % = sectionwidth + sectiongap
\newlength{\resonance@dategap}        % gap between entry text and date
\newlength{\resonance@datewidth}      % right date column width
\newlength{\resonance@contentwidth}   % scratch: recomputed per macro call

\setlength{\resonance@sectionwidth}{0.95in}
\setlength{\resonance@sectiongap}    {0.08in}
\setlength{\resonance@datewidth}     {1.45in}
\setlength{\resonance@dategap}      {0.5em}
\setlength{\resonance@bodyindent}    {\resonance@sectionwidth + \resonance@sectiongap}

%% ── Font declarations ─────────────────────────────────────────────────────────
%% TYPE SCALE  (base = 10pt / normalsize)
%%
%%  18pt  \namefont        Header name (bold)
%%  10pt  \entrytitlefont  Entry / degree title (bold)
%%  10pt  \scholarlyfont   Publication / bibliography text (regular weight)
%%  10pt  \taglinefont     Header tagline (italic, muted)
%%   9pt  \entryorgfont    Institution / org line (italic, muted)
%%   9pt  \datefont        All date strings (bold, muted)
%%   9pt  \subheadingfont  In-body grouping labels (bold, muted)
%%   8pt  \sectionfont     Left-gutter section labels (bold, accent)
%%                         8pt is intentional: labels live in a narrow margin
%%                         column and must not compete with body text.
%%
\newcommand{\namefont}      {\fontsize{18}{20}\selectfont\bfseries}
\newcommand{\taglinefont}   {\normalsize\itshape\leavevmode\color{ResonanceMuted}}
\newcommand{\sectionfont}   {\normalfont\sffamily\bfseries\footnotesize\leavevmode\color{ResonanceAccent}}
\newcommand{\entrytitlefont}{\normalfont\bfseries}
\newcommand{\entryorgfont}  {\normalfont\small\itshape\leavevmode\color{ResonanceMuted}}
\newcommand{\datefont}      {\small\bfseries\leavevmode\color{ResonanceMuted}}
\newcommand{\subheadingfont}{\normalfont\bfseries\normalsize\leavevmode\color{ResonanceMuted}}
\newcommand{\scholarlyfont} {\normalsize}

%% ── Column types ─────────────────────────────────────────────────────────────
\newcolumntype{Y}{>{\RaggedRight\arraybackslash}X}        % stretchy, left-aligned
\newcolumntype{R}[1]{>{\raggedleft\arraybackslash}p{#1}}  % fixed-width, right-aligned

%% ── Internal state ────────────────────────────────────────────────────────────
\newcommand{\resonance@name}    {}
\newcommand{\resonance@tagline} {}
\newcommand{\resonance@contacts}{}
\newcommand{\resonance@pdftitle}{Curriculum Vitae}
\newtoggle{resonance@aftersection}
\togglefalse{resonance@aftersection}

%% ── User configuration commands ───────────────────────────────────────────────
\NewDocumentCommand{\name}   {m}{\gdef\resonance@name{#1}}
\NewDocumentCommand{\tagline}{m}{\gdef\resonance@tagline{#1}}
\NewDocumentCommand{\cvtitle}{m}{\gdef\resonance@pdftitle{#1}}

%% Override the gutter width (also recalculates \resonance@bodyindent).
\NewDocumentCommand{\setsectionwidth}{m}{%
  \setlength{\resonance@sectionwidth}{#1}%
  \setlength{\resonance@bodyindent}{\resonance@sectionwidth + \resonance@sectiongap}%
}
%% Override the right date-column width.
\NewDocumentCommand{\setdatewidth}{m}{%
  \setlength{\resonance@datewidth}{#1}%
}

%% ── Contact system ────────────────────────────────────────────────────────────
%% \contactline{left text}{right text}
%% Appends one full-width tabularx row to the contact block rendered in the
%% header.  Left column is ragged-right and stretches; right column is
%% right-aligned and stretches equally.  Rows are collected and emitted together.
\newcommand{\resonance@contactrow}[2]{#1 & #2 \\}
\NewDocumentCommand{\contactline}{m m}{%
  \gappto\resonance@contacts{\resonance@contactrow{#1}{#2}}%
}

%% ── PDF metadata ──────────────────────────────────────────────────────────────
\AtBeginDocument{%
  \hypersetup{%
    pdftitle   = {\resonance@pdftitle},%
    pdfauthor  = {\resonance@name},%
    pdfsubject = {Curriculum Vitae},%
  }%
}
%% ── Header rendering ──────────────────────────────────────────────────────────
%% Called automatically at the start of the {resume} environment.
%%   line option:     name / tagline / contacts / horizontal rule
%%   centered option: centred name / tagline / contacts (no rule)
\newcommand{\resonance@makeheader}{%

  \ifresonance@lineheader
    {\namefont \resonance@name\par}%
    \ifstrempty{\resonance@tagline}{}{%
      \vspace{0.1em}{\taglinefont \resonance@tagline\par}%
    }%
    \vspace{0.25em}%
    \ifx\resonance@contacts\empty\else
      \noindent
      \begin{tabularx}{\linewidth}{@{} Y @{\hspace{1em}} >{\raggedleft\arraybackslash}X @{}}
        \resonance@contacts
      \end{tabularx}\par
    \fi
    \vspace{0.2em}\hrule height 0.4pt\vspace{0.45em}%
  \else
    \begin{center}
      {\namefont \resonance@name\par}%
      \ifstrempty{\resonance@tagline}{}{%
        \vspace{0.1em}{\taglinefont \resonance@tagline\par}%
      }%
    \end{center}%
    \vspace{0.25em}%
    \ifx\resonance@contacts\empty\else
      \noindent
      \begin{tabularx}{\linewidth}{@{} Y @{\hspace{1em}} >{\raggedleft\arraybackslash}X @{}}
        \resonance@contacts
      \end{tabularx}\par
    \fi
    \vspace{0.45em}%
  \fi
}

%% ── Resume environment ────────────────────────────────────────────────────────
%% Renders the header then opens an adjustwidth block indented by
%% \resonance@bodyindent, creating the left gutter space for section labels.
\newenvironment{resume}{%
  \resonance@makeheader
  \begin{adjustwidth}{\resonance@bodyindent}{0pt}%
  \RaggedRight%
}{%
  \end{adjustwidth}%
}

%% ── Section command ───────────────────────────────────────────────────────────
%% The label is placed in the left gutter via a zero-width \makebox.
%% The \parbox inside wraps at \resonance@sectionwidth so multi-word labels
%% wrap cleanly without affecting body content alignment.
%% \MakeUppercase keeps .tex source readable; PDF shows all-caps labels.
\renewcommand\section[1]{%
  \global\toggletrue{resonance@aftersection}%
  \phantomsection\addcontentsline{toc}{section}{#1}%
  \par\Needspace{3\baselineskip}\addvspace{0.45\baselineskip}%
  \noindent\leavevmode
  \makebox[0pt][r]{%
    \smash{\raisebox{0.25\baselineskip}[0pt][0pt]{\parbox[t]{\resonance@sectionwidth}{\raggedright\hyphenpenalty=10000\exhyphenpenalty=10000\sectionfont\MakeUppercase{#1}}}}%
    \hspace{\resonance@sectiongap}%
  }%
  \ignorespaces
}

%% ── List environments ─────────────────────────────────────────────────────────
%% cvitems: tight bulleted list for entry bodies.  Two indent levels supported.
%% list1 / list2: convenience aliases — both map to cvitems level 1.
\newlist{cvitems}{itemize}{2}
\setlist[cvitems,1]{%
  label      = \textbullet,
  leftmargin = *,
  itemsep    = 0pt,
  topsep     = 1.5pt,
  parsep     = 0pt,
  partopsep  = 0pt,
}
\setlist[cvitems,2]{%
  label      = \textendash,
  leftmargin = *,
  itemsep    = 0pt,
  topsep     = 1pt,
  parsep     = 0pt,
  partopsep  = 0pt,
}
\newenvironment{list1}{\begin{cvitems}}{\end{cvitems}}
\newenvironment{list2}{\begin{cvitems}}{\end{cvitems}}

%% publist: numbered bibliography list for Publications and Presentations.
%% Each \item is one standalone reference.  Use [resume] on a subsequent
%% \begin{publist}[resume] to continue numbering across \cvsubheading blocks.
%%
%% Each entry renders as:
%%   1. Author, A., \me{Ergin, E. K.} (\pubyear{2024}). Title, \emph{Journal}.
%%
%% Entries are spaced apart so they read as distinct items, not flowing prose.
\newlist{publist}{enumerate}{1}
\setlist[publist]{%
  label      = {\datefont\arabic*.},  %% muted bold number: "1.", "2.", ...
  leftmargin = *,
  labelsep   = 0.5em,
  itemsep    = 0.5em,    %% clear separation between entries
  topsep     = 0.05em,
  parsep     = 0pt,
  partopsep  = 0pt,
  before     = \RaggedRight\sloppy,  %% handles long author lists & URLs
}

%% \me{name}
%% Render your own name in accent-coloured bold inside publication entries.
%% Example: \me{Ergin, E. K.}, Lange, P. F. (\pubyear{2024}). Title...
\NewDocumentCommand{\me}{m}{\textbf{\color{ResonanceAccent}#1}}

%% \pubyear{YYYY}
%% Render a publication year in bold so it visually pops from surrounding text.
%% Example: Lange, P. F. (\pubyear{2022}). Title...
\NewDocumentCommand{\pubyear}{m}{\textbf{#1}}

%% ── Entry macros ──────────────────────────────────────────────────────────────
%% Visual grammar shared by all two-column entry macros:
%%
%%   [bold title / name ......................] [muted date (right-aligned)]
%%   [italic org / institution]
%%   [body text or list]
%%
%% The \ifhmode guard handles two calling contexts:
%%   • Right after \section{}: already in horizontal mode (\leavevmode +
%%     \ignorespaces); \unskip removes the trailing space, entry starts flush.
%%   • Mid-section (second or later entry): not in hmode; vspace is inserted
%%     to separate from the preceding entry.

%% \cventry{title}{org}{date}{body}
%% Full entry: title+date header row, italic org/institution, freeform body.
%% Use for: Experience, Teaching, Education (\degreeentry alias).
\NewDocumentCommand{\cventry}{m m m +m}{%
  \iftoggle{resonance@aftersection}{\global\togglefalse{resonance@aftersection}}{%
    \par\addvspace{0.35\baselineskip}\noindent
  }%
  \setlength{\resonance@contentwidth}{\dimexpr\linewidth - \resonance@datewidth - \resonance@dategap\relax}%
  \noindent\makebox[\linewidth][l]{%
    \parbox[t]{\resonance@contentwidth}{\strut\entrytitlefont #1}%
    \hfill
    \parbox[t]{\resonance@datewidth}{\strut\raggedleft\datefont\microtypesetup{protrusion=false}#3}%
  }\par
  \Needspace{4\baselineskip}%
  {\entryorgfont #2}\par
  #4\par
}

%% \degreeentry{degree}{university}{date}{notes}
%% Semantic alias for \cventry — identical layout, clearer intent for Education.
\let\degreeentry\cventry

%% \cvdateditem{title}{date}{body}
%% Entry with title+date header row and body; no org/institution line.
%% Use for: Software, Projects.
\NewDocumentCommand{\cvdateditem}{m m +m}{%
  \iftoggle{resonance@aftersection}{\global\togglefalse{resonance@aftersection}}{%
    \par\addvspace{0.35\baselineskip}\noindent
  }%
  \setlength{\resonance@contentwidth}{\dimexpr\linewidth - \resonance@datewidth - \resonance@dategap\relax}%
  \noindent\makebox[\linewidth][l]{%
    \parbox[t]{\resonance@contentwidth}{\strut\entrytitlefont #1}%
    \hfill
    \parbox[t]{\resonance@datewidth}{\strut\raggedleft\datefont\microtypesetup{protrusion=false}#2}%
  }\par
  \Needspace{3\baselineskip}%
  #3\par
}

%% \cvrow{text}{date}
%% Plain single-line entry: text left, date right.  No bullet, no body block.
\NewDocumentCommand{\cvrow}{m m}{%
  \iftoggle{resonance@aftersection}{\global\togglefalse{resonance@aftersection}}{%
    \par\addvspace{0.1\baselineskip}\noindent
  }%
  \setlength{\resonance@contentwidth}{\dimexpr\linewidth - \resonance@datewidth - \resonance@dategap\relax}%
  \noindent\makebox[\linewidth][l]{%
    \parbox[t]{\resonance@contentwidth}{\strut #1}%
    \hfill
    \parbox[t]{\resonance@datewidth}{\strut\raggedleft\datefont\microtypesetup{protrusion=false}#2}%
  }\par
}

%% \cvminorrow{text}{date}
%% Compact bulleted entry: bullet + text left, date right.
%% Use for: Awards, Memberships, Leadership, Certificates.
\NewDocumentCommand{\cvminorrow}{m m}{%
  \iftoggle{resonance@aftersection}{\global\togglefalse{resonance@aftersection}}{%
    \par\addvspace{0.1\baselineskip}\noindent
  }%
  \setlength{\resonance@contentwidth}{\dimexpr\linewidth - \resonance@datewidth - \resonance@dategap\relax}%
  \noindent\makebox[\linewidth][l]{%
    \parbox[t]{\resonance@contentwidth}{\strut\textit{\textbullet}\ #1}%
    \hfill
    \parbox[t]{\resonance@datewidth}{\strut\raggedleft\datefont\microtypesetup{protrusion=false}#2}%
  }\par
}

%% \cvskill{Category}{items}
%% Skill line: bold category label followed by item text.  No date column.
%% Example: \cvskill{Languages}{Python, R, Java, Bash}
\NewDocumentCommand{\cvskill}{m m}{%
  \iftoggle{resonance@aftersection}{\global\togglefalse{resonance@aftersection}}{%
    \par\addvspace{0.1\baselineskip}\noindent
  }%
  \textit{\textbullet}\ \textbf{#1:} #2\par
}

%% ── Sub-section label ─────────────────────────────────────────────────────────
%% \cvsubheading{text}
%% Bold muted label grouping related entries within a section
%% (e.g. "Oral Presentations", "Peer-Reviewed Articles").
%% \ifhmode: starts flush after \section{}; adds vspace between entry groups.
\newcommand{\cvsubheading}[1]{%
  \iftoggle{resonance@aftersection}{%
    \global\togglefalse{resonance@aftersection}%
  }{%
    \par\Needspace{2\baselineskip}\addvspace{0.35\baselineskip}\noindent
  }%
  {\subheadingfont #1\par}\vspace{0.05em}%
}

%% ── Scholarly / publication macros ────────────────────────────────────────────

%% \pubentry{full reference text}
%% Hanging-indent bibliographic entry.  The 1.2em hanging indent aligns
%% continuation lines past the opening character, giving a standard
%% bibliography appearance.  Use for Publications and Presentations.
\NewDocumentCommand{\pubentry}{+m}{%
  \iftoggle{resonance@aftersection}{%
    \global\togglefalse{resonance@aftersection}%
  }{%
    \par\Needspace{2\baselineskip}\addvspace{0.15\baselineskip}\noindent
  }%
  {\scholarlyfont\RaggedRight\sloppy
    \hangindent=1.2em\hangafter=1\noindent #1\par}%
}

%% \talkentry{venue}{date}{title}
%% Talk/presentation entry: venue + right-aligned date on the first row,
%% talk title on the line below.
\NewDocumentCommand{\talkentry}{m m m}{%
  \iftoggle{resonance@aftersection}{\global\togglefalse{resonance@aftersection}}{%
    \par\addvspace{0.3\baselineskip}\noindent
  }%
  \setlength{\resonance@contentwidth}{\dimexpr\linewidth - \resonance@datewidth - \resonance@dategap\relax}%
  \noindent\makebox[\linewidth][l]{%
    \parbox[t]{\resonance@contentwidth}{\strut\entryorgfont #1}%
    \hfill
    \parbox[t]{\resonance@datewidth}{\strut\raggedleft\datefont\microtypesetup{protrusion=false}#2}%
  }\par
  \Needspace{3\baselineskip}%
  {\scholarlyfont #3\par}%
}
