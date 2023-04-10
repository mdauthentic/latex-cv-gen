\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2022/04/24 Resume Class]
\LoadClass[letterpaper,10pt]{article}
\RequirePackage[xetex]{hyperref}
\RequirePackage[empty]{fullpage}
% ------------------- Fonts & Layout -------------------
\RequirePackage{fontspec}
\RequirePackage[sfdefault,light]{FiraSans}

\newfontfamily{\trocchi}{Trocchi}[%
  Path = fonts/trocchi/,
  Extension = .ttf,
  UprightFont={*-Regular}
]

\RequirePackage{fontawesome5}
\RequirePackage{anyfontsize}

\RequirePackage{tabularx}
\RequirePackage{ragged2e}
% Needed to handle list environment
\RequirePackage{enumitem}
\RequirePackage{environ}
\RequirePackage{booktabs}

% ------------------- Graphics -------------------
\RequirePackage{tikz}
\RequirePackage{smartdiagram}
\RequirePackage{graphicx}

% ------------------- Bibliography -------------------
\RequirePackage[bibstyle=publist, backend=biber]{biblatex}
\addbibresource{ref.bib}

% ------------------- Page Margin -------------------
% \RequirePackage[top=-1.8mm, bottom=0mm, left=0mm, right=5mm]{geometry}
% Adjust margins
\addtolength{\oddsidemargin}{-0.55in}
\addtolength{\evensidemargin}{-0.55in}
\addtolength{\textwidth}{1.1in}
\addtolength{\topmargin}{-0.7in}
\addtolength{\textheight}{1.1in}

% Define the link colours
\hypersetup{
    colorlinks=true,
    urlcolor=links,
}

% Set the margin alignment 
\raggedbottom
\raggedright
\setlength{\tabcolsep}{0in}

% ------------------- Colors -------------------
\definecolor{primary}{HTML}{37352f}
\definecolor{secondary}{HTML}{37352f}
% \definecolor{secondary}{HTML}{161618}
\definecolor{accent}{HTML}{263238}
\definecolor{links}{HTML}{723cdc}
\definecolor{agreen}{HTML}{ffffff}
% Tech tag color
\definecolor{darkGrey}{HTML}{989898}


% ------------------- Header settings -------------------

% \def\bulletstyle{\faAngleRight}
\def\bulletstyle{\guilsinglright}

\newcommand*{\name}[1]{\def\@fullname{#1}}
\newcommand*{\subtitle}[1]{\def\@position{#1}}


% ---------------------- Contact Info ------------------------
% Email
\def\emailicon{\faEnvelope}
\newcommand*{\setemail}[1]{\def\@email{#1}}
\def\emaillink{mailto:\@email}
\def\emailtext{\@email}
\def\email{\emailicon\hspace{3pt}\href{\emaillink}{\emailtext}}

% LinkedIn
\def\linkedinicon{\faLinkedin}
\newcommand*{\setlinkedin}[1]{\def\@linkedintext{#1}}
\def\linkedinlink{https://linkedin.com/in/\@linkedintext}
\def\linkedin{\linkedinicon\hspace{3pt}\href{\linkedinlink}{\@linkedintext}}

% Github
\def\githubicon{\faGithub}
\newcommand*{\setgithub}[1]{\def\@github{#1}}
\def\githublink{https://github.com/\@github}
\def\githubtext{/\@github}
\def\github{\githubicon\hspace{3pt}\href{\githublink}{\githubtext}}

% Phone
\def\phoneicon{\faMobile}
\newcommand*{\setphone}[1]{\def\@phone{#1}}
\def\phonetext{\@phone}
\def\phone{\phoneicon\hspace{3pt}{\phonetext}}



\def\headertype{\doublecol} % \singlecol or \doublecol


% ------------------------- Double column header -------------------------
\newcommand{\doublecol}[6]{
  \begin{tabularx}{\textwidth}{Xr}
    {
      \begin{tabular}[c]{l}
        \fontsize{18}{20}\selectfont{\color{primary}{{\textbf{\trocchi\@fullname} }}} \\
        {\textit{\trocchi\@position}} % You could add a subtitle here
      \end{tabular}
    } & {
      \begin{tabular}[c]{l@{\hspace{1.5em}}l}
        {\small\trocchi#2} & {\small\trocchi#1} \\
        {\small\trocchi#4} & {\small\trocchi#3}
      \end{tabular}
    }
  \end{tabularx}
}


% ------------------------- Custom commands -------------------------

% Spacing
\def\entryspacing{-0pt}

% Sections
\renewcommand{\section}[2]{\vspace{5pt}
  \colorbox{secondary}{\color{agreen}\raggedbottom\normalsize\textbf{{#1}{\hspace{7pt}\textsc{#2}}}}
}


% ---------------------------- cvblock ----------------------------
% Usage:
% \begin{cvblock} <definitions> \end{cvblock}
\newenvironment{cvblock}{
  \begin{itemize}[leftmargin=2.5mm]
}{%
  \end{itemize}\vspace{\entryspacing}
}

% ---------------------------- entrysimple ----------------------------
% Usage:
%  \entryhead{<Singe line description>}
\newcommand{\entrysimple}[1]{
  \vspace{-5pt}\item[]
    \begin{tabularx}{0.97\textwidth}{X@{\hspace{60pt}}}
      \textbf{\trocchi\color{primary}#1} \\
    \end{tabularx}\vspace{-1pt}
}

% ---------------------------- entryhead ----------------------------
% Usage:
%  \entryhead{<Company>}{<Date>}{<Position>}{<City, Country>}
\newcommand{\entryhead}[3]{
  \vspace{-5pt}\item[]
    \begin{tabularx}{0.97\textwidth}{X@{\hspace{60pt}}r}
      \textbf{\color{primary}\trocchi#1} & {\color{accent}\footnotesize#2} \\
      \textit{\color{accent}\small#3} &  \\
    \end{tabularx}\vspace{-1pt}
}


% ---------------------------- itemdetailed ----------------------------
% Usage:
%  \itemdetailed{<Item>}{<Date/City/Country>}
\newcommand{\itemdetailed}[2]{
  \vspace{-1pt}\item[]
    \begin{tabularx}{0.97\textwidth}{X@{\hspace{60pt}}r}
      \bulletstyle \ \color{primary}#1 & {\color{accent}\small#2} \\
    \end{tabularx}\vspace{-6pt}
}

% ---------------------------- Tech Tag ----------------------------
% Create a tag
\newcommand{\techtag}[1]{%
  \tikz[baseline]\node[anchor=base,draw=darkGrey!70,rounded corners=0.5ex,inner xsep=1ex,inner ysep =0.55ex,text height=1.3ex,text depth=.25ex]{#1};
}
% Usage in body: \tagline{<tag label>}
\newcommand{\tagline}[1]{\hspace{0.4cm}\footnotesize{\foreach \n in {#1}{\techtag{\n}}}\vspace{-7pt}}

% ---------------------------- Set item bullet style ----------------------------
\setlist[itemize]{label=\bulletstyle}
% Resume item
\renewcommand{\labelitemii}{\bulletstyle}
\newcommand{\entryitem}[1]{
  \item\small{
    {#1 \vspace{-2pt}}
  }
}

% ---------------------------- cventrylist ----------------------------
% Usage:
% \begin{cventrylist}
%   entryitem{<job description line1>}
% \end{cventrylist}
\newenvironment{cventrylist}{
  \vspace{-5pt}\item[]
  \begin{itemize}[leftmargin=4.5mm]
}{%
  \end{itemize}
}

% ---------------------------- Skills ----------------------------
\newcommand{\skillsentry}[2]{
  \item[]\small{
    \textbf{\trocchi\color{primary}#1 }{#2 \vspace{-5pt}}
  }
}

