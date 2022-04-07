% This class provides a template originally based on the TU Delft template.
% I tried to remove all direct references, but I likely missed it at least once.

%% Class is based on the default book class and options will be passed
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{layout/corbotics-report}[31-03-2022 v0.1 Corbotics Report Class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\LoadClass[10pt,oneside]{book}

%% Main packages in the document
\RequirePackage{amsmath}    % Mathematics
\RequirePackage{amssymb}    % Symbols
\RequirePackage{siunitx}    % Various functions, e.g. \num{}

\RequirePackage{tabularx}   % Additional functions to tables
\RequirePackage{booktabs}   % Adds more line functionality to tables
\RequirePackage{longtable}  % Lets tables break over page
\RequirePackage{multirow}   % Counterpart of multi columns
\RequirePackage{enumitem}   % Customise the list spacing

\RequirePackage{geometry}   % Document geometry
\RequirePackage{titlesec}   % Custom titles
\RequirePackage{titletoc}   % Custom table of contents
\RequirePackage{fancyhdr}   % Custom header/footer
\RequirePackage[colorlinks]{hyperref} % Improved referencing/links

\RequirePackage{graphicx}   % Adding images
\RequirePackage{float}      % Additional float parameters
\RequirePackage[labelfont=bf,justification=centering,footnotesize]{caption} % Captions
\RequirePackage{subcaption} % Subfigures and subcaptions
\RequirePackage{xcolor}     % Using colours in documents
\RequirePackage{tikz}       % Create graphic elements

% -> BibLaTeX moved to report.tex ->
\RequirePackage{datetime}   % Used in preface for monthname
\RequirePackage{microtype}  % Refinements towards typographical perfection
\RequirePackage[nottoc]{tocbibind} % Add the lists to the table of contents
\RequirePackage{xspace}     % Ensures correct spacing after macros like \deg
\RequirePackage{etoolbox}   % General toolbox (e.g. \ifdefvoid)
\RequirePackage{algpseudocode}   % For algorithmic 
\RequirePackage{pdfpages}   % Insert .pdf directly as pages

%% References
\usepackage[capitalise]{cleveref} % Smart referencing
\crefname{lstlisting}{Listing}{Listings} % No Listing references in cref
\Crefname{lstlisting}{Listing}{Listings}

%% Code formatting
\usepackage{listings}
\usepackage{xcolor}

\definecolor{codegreen}{rgb}{0,0.6,0}
\definecolor{codegray}{rgb}{0.5,0.5,0.5}
\definecolor{codepurple}{rgb}{0.58,0,0.82}

\lstdefinestyle{codestyle}{   
    commentstyle=\color{codegreen},
    keywordstyle=\color{magenta},
    numberstyle=\tiny\color{codegray},
    stringstyle=\color{codepurple},
    basicstyle=\ttfamily\footnotesize,
    breakatwhitespace=false,         
    breaklines=true,                 
    captionpos=b,                    
    keepspaces=true,                 
    numbers=left,                    
    numbersep=5pt,                  
    showspaces=false,                
    showstringspaces=false,
    showtabs=false,                  
    tabsize=2
}

\lstset{style=codestyle}

%% General definitions
\def\Company{Corbotics}
\def\Product{BBE}
\def\Version{V3}

%PACKAGE FOR CELL COLOR
\usepackage{colortbl}

%%%%% 1. General Definitions for the Document and Bibliography %%%%%
\newcommand{\tabitem}{~~\llap{\textbullet}~~}

%% Commands to define the title, author, etc
\renewcommand{\title}[1]{%
    \def\@title{#1}%
    \hypersetup{pdftitle=#1}} % Adding to metadata

\renewcommand*{\author}[2][]{%
    \def\@author{#2}%
    \def\@author@short{#1}%
    \hypersetup{pdfauthor=\ifdefvoid{\@author@short}{#2}{#1}}} % Adding to metadata

\newcommand*\subtitle[1]{\def\@subtitle{#1}}
\newcommand*\coverimage[1]{\def\@cover@image{#1}}
\newcommand\subject[1]{\def\@subject{#1}}

%% Some of the TU Delft house style colours
\definecolor{corbotics-blue}{cmyk}{0.98,0.4,0,0}
\definecolor{corbotics-green}{cmyk}{0.72,0,0.24,0}
\definecolor{corbotics-black}{cmyk}{0,0,0,1}
\definecolor{corbotics-white}{cmyk}{0,0,0,0}

%% Scaling the margins to be slightly smaller than default (.7)
\geometry{a4paper,hscale=0.75,vscale=0.75}

%% Reducing white space in lists slightly (both enumerate and itemize)
\setlist{itemsep=-2pt}

%% Setting up \autoref to use uppercase
\def\sectionautorefname{Section}
\def\chapterautorefname{Chapter}
\let\subsectionautorefname\sectionautorefname
\let\subsubsectionautorefname\sectionautorefname

%%%%% 2. Loading all the Fonts (Supports pdfLaTeX, XeLaTeX and LuaLaTeX) %%%%%

\RequirePackage{iftex} % Adds if-else statements to support multiple compilers

\ifPDFTeX
    %% pdfLaTeX is only available for compatibility, but not recommended.
    \RequirePackage[T1]{fontenc} % Fixes possible encoding issues

    %% Defining commands to be used in layout
    \renewcommand{\rmdefault}{phv}
    \renewcommand{\sfdefault}{phv}
    \def\largetitlestyle{}
    \def\titlestyle{}

    %% Warning when using pdfLaTeX
    \@latex@warning@no@line{You are using pdfLaTeX as compiler. Consider changing the compiler to XeLaTeX or LuaLaTeX to adhere to the Corbotics house style}
\else
    %% If XeLaTeX or LuaLaTeX is set as the compiler, the Corbotics house style fonts are used
    \RequirePackage{fontspec} % Custom fonts

    %% Adding the various fonts
    % \setmainfont{Arial}
    % \setmathsf{Arial}
    % \setmathtt{Arial}

    \newfontfamily\corboticstitlefamily[Path=layout/corbotics/]{Corbotics-UltraLight.ttf}
    % \newfontfamily\quotefont{Georgia}

    %% Defining commands to be used in layout
    \def\largetitlestyle{\corboticstitlefamily}
    \def\titlestyle{\normalfont}

    %% Changing the quote environment to use Georgia
    \AtBeginEnvironment{quote}{\quotefont}
\fi

%%%%% 3. Adjusting the Titles in Text and Table of Contents %%%%%

%% Formatting chapter titles and spacing
\titleformat{\chapter}[hang]
    {\flushleft}
    {\fontsize{25}{0}\LARGE \bfseries Chapter \thechapter : }
    {0pt}
    {\LARGE \titlestyle\bfseries}
\titlespacing*{\chapter}{0pt}{0pt}{\baselineskip}

%% Formatting section titles and spacing
% New section on new page
\AddToHook{cmd/section/before}{\clearpage}

\titleformat{\section}
    {\Large\titlestyle\bfseries}
    {Section \thesection:}
    {5pt}
    {}
\titlespacing*{\section}{0pt}{\baselineskip}{0pt}

%% Formatting subsections titles and spacing
\titleformat{\subsection}
    {\large\titlestyle\bfseries}
    {Section \thesubsection:}
    {5pt}
    {}
\titlespacing*{\subsection}{0pt}{\baselineskip}{0pt}

%% Formatting subsubsections titles and spacing
\titleformat{\subsubsection}
    {\titlestyle\bfseries}
    {}
    {0pt}
    {}
\titlespacing*{\subsubsection}{0pt}{\bigskipamount}{0pt}

%% Changing font and spacing in the table of contents
\dottedcontents{chapter}[1.5em]{\vspace{0.5\baselineskip}\titlestyle\bfseries}{1.5em}{0pc}
\dottedcontents{section}[3.8em]{\titlestyle}{2.3em}{8pt}
\dottedcontents{subsection}[7em]{\titlestyle}{3.2em}{8pt}

%%%%% 4. Adjusting the Header and Footer %%%%%

%% Adding a head rule to pages
%\renewcommand{\headrulewidth}{0.0pt}
\renewcommand*\headrule{%
    {\hrule\@height\headrulewidth\@width\headwidth}%
    \vskip-\headrulewidth}

%% Page style for title pages
\fancypagestyle{plain}{%
    \fancyhf{}
    \renewcommand*\headrulewidth{0pt}
    \fancyfoot[C]{\thepage}}

%% Fancy style for the main matter, depends on oneside/twoside option
\if@twoside%
    \fancyhf{}
    \fancyhead[LE,RO]{\titlestyle\thepage}
    \fancyhead[RE]{\titlestyle\nouppercase{\leftmark}}
    \fancyhead[LO]{\titlestyle\nouppercase{\rightmark}}
    \RequirePackage{emptypage} % Clears empty pages
\else%
    \fancyhf{}
    \fancyhead[R]{\titlestyle\thepage}
    \fancyhead[L]{\titlestyle\nouppercase{\rightmark}}
\fi

\pagestyle{fancy} % Setting it to default

%%%%% 5. Cover Page %%%%%

\newcommand*\makecover{
    % Clearing the page and removing page number
    \clearpage
    \thispagestyle{empty}

    %% Use the Tikz library positioning
    \usetikzlibrary{positioning}

    % Defining where everything needs to go
    \begin{tikzpicture}[overlay,remember picture]

    \node[above=0,inner sep=0] at (current page.south) {\includegraphics[width=\paperwidth]{\@cover@image}};

    %CORBOTICS LOGO
    \node[above right=0.2cm and 0.6cm] at (current page.south west) {%
        \includegraphics[width=0.35\linewidth]{figures/FrontPage/Corbotics logo.png}};
    
    %TODOS LOGO    

    \node[below=1cm,minimum width={\paperwidth},inner ysep=25pt,opacity=0.0,text opacity=1] at (current page.north) {%
        \begin{minipage}{1\paperwidth}
            % \largetitlestyle\fontsize{50}{50}\selectfont\color{title}\@title \\[0.5ex]
            % \ifdefvoid{\@subtitle}{}{\titlestyle\fontsize{22}{22}\selectfont\color{white}\@subtitle \\[2.5ex]}
            \centering
            \ifdefvoid{\@subject}{}{\titlestyle\fontsize{35}{35}\selectfont\color{corbotics-white}\@subject \\[0.5ex]}
            \ifdefvoid{\Subtitle{}}{}{\titlestyle\fontsize{15}{15}\selectfont\color{corbotics-white}\Subtitle{}} 
        \end{minipage}};

    \end{tikzpicture}
    \newpage
}
