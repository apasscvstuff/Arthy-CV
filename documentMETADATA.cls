%% Copyright 2016 Christophe Roger
%
% Author: 
% Christophe Roger (Darwiin)
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3c
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
% 
% The Current Maintainer of this work is M. C. Roger.
%
% This work consists of the files awesome-source-cv.cls 

\ProvidesClass{documentMETADATA}[2018/07/19  v1.9.2 'YAAC: Another Awesome CV' Class]

\LoadClass[letterpaper]{article}

\newif\if@showLinks   \@showLinksfalse

\DeclareOption{green}{
  \def\@green{green}
}

\DeclareOption{red}{
  \def\@red{red}
}

\DeclareOption{indigo}{
  \def\@indigo{indigo}
}
\DeclareOption{orange}{
  \def\@orange{orange}
}

\DeclareOption{monochrome}{
  \def\@monochrome{monochrome}
}

\DeclareOption{localFont}{
  \def\@local{local}
}

\DeclareOption{alternative}{
  \def\@alternative{alternate}
}

\DeclareOption{showLinks}{ \@showLinkstrue}

\ProcessOptions

% Dependences
%A Few Useful Packages
\RequirePackage[english,french]{babel}
\RequirePackage[utf8]{luainputenc}
\RequirePackage{fontspec} 					                 % for loading fonts
\RequirePackage{url,parskip} 	    % other packages for formatting
\RequirePackage[usenames,dvipsnames]{xcolor}
\RequirePackage{fullpage}
\RequirePackage[margin=1.5cm]{geometry}
\RequirePackage{fontawesome}
\RequirePackage{hyperref}
\RequirePackage{titlesec}
\RequirePackage{array}
\RequirePackage{enumitem}
\RequirePackage{longtable} 	
\RequirePackage{etoolbox}
\RequirePackage{tikz}
\RequirePackage[skins]{tcolorbox}
\RequirePackage{fancyhdr}

% Conditional compilation system
\RequirePackage{xstring}

% Define all available toggles
% Role-based toggles
\newtoggle{firmware}
\newtoggle{ai}
\newtoggle{consulting}
\newtoggle{executive}
\newtoggle{general}

% Feature toggles
\newtoggle{technical}
\newtoggle{detailed}
\newtoggle{quantified}
\newtoggle{businessfocus}

% Length control toggles
\newtoggle{onepage}
\newtoggle{twopage}
\newtoggle{fullversion}

% Default all toggles to false
\togglefalse{firmware}
\togglefalse{ai}
\togglefalse{consulting}
\togglefalse{executive}
\togglefalse{general}
\togglefalse{technical}
\togglefalse{detailed}
\togglefalse{quantified}
\togglefalse{businessfocus}
\togglefalse{onepage}
\togglefalse{twopage}
\toggletrue{fullversion}

% Utility commands for conditional content
\newcommand{\whenrole}[2]{%
  \iftoggle{#1}{#2}{}%
}

\newcommand{\whennotrole}[2]{%
  \iftoggle{#1}{}{#2}%
}

\newcommand{\whenany}[2]{%
  % Usage: \whenany{role1,role2}{content}
  % Note: Simple implementation - for complex cases use nested conditions
  #2%
}

% Length-aware commands
\newcommand{\whenonepage}[1]{\iftoggle{onepage}{#1}{}}
\newcommand{\whentwopage}[1]{\iftoggle{twopage}{#1}{}}
\newcommand{\whenfull}[1]{\iftoggle{fullversion}{#1}{}}

% Enhanced quantification and metrics controls
\newcommand{\withmetric}[2]{%
  % Show metric if quantified toggle is true, otherwise show alternative
  \iftoggle{quantified}{#1}{#2}%
}

\newcommand{\metric}[1]{%
  % Show metric only if quantified toggle is true
  \iftoggle{quantified}{#1}{}%
}

\newcommand{\businessimpact}[1]{%
  % Show business impact if businessfocus toggle is true
  \iftoggle{businessfocus}{#1}{}%
}

% Progressive disclosure system based on priority levels
\newcommand{\priority}[2]{%
  % Priority 1: Always include (core achievements)
  % Priority 2: Include unless executive/onepage (standard details)  
  % Priority 3: Include only in fullversion (additional details)
  \ifnum#1=1 #2\fi
  \ifnum#1=2 \iftoggle{onepage}{}{#2}\fi
  \ifnum#1=3 \iftoggle{fullversion}{#2}{}\fi
}

% Role-specific metric display
\newcommand{\techmetric}[1]{%
  % Technical metrics for firmware/ai roles
  \iftoggle{firmware}{#1}{}%
  \iftoggle{ai}{#1}{}%
}

\newcommand{\leadmetric}[1]{%
  % Leadership metrics for consulting/executive roles
  \iftoggle{consulting}{#1}{}%
  \iftoggle{executive}{#1}{}%
}

% Combined conditional for common patterns
\newcommand{\detailedtech}[1]{%
  % Show detailed technical content unless executive
  \iftoggle{executive}{}{%
    \iftoggle{detailed}{#1}{}%
  }%
}

% Quantified achievement pattern: Action + Metric + Impact
\newcommand{\achievement}[3]{%
  % Usage: \achievement{action}{metric}{impact}
  % Shows: action + (metric if quantified) + (impact if businessfocus)
  #1\metric{ #2}\businessimpact{ #3}%
}

% Executive version space optimizations
\newcommand{\execspace}[1]{%
  % Reduce spacing in executive version
  \iftoggle{onepage}{\vspace{#1}}{}%
}

% Conditional section breaks for length control


% Compact list formatting for executive
\newcommand{\compactlist}[1]{%
  \iftoggle{onepage}{%
    \begin{itemize}[noitemsep,topsep=0pt,parsep=0pt,partopsep=0pt]
      #1
    \end{itemize}
  }{%
    \begin{itemize}
      #1
    \end{itemize}
  }%
}

\DeclareUnicodeCharacter{00E9}{\'{e}}
% Define default accent colors
\definecolor{basecolor}{HTML}{000066}       %BLUE

\ifundef{\@green} {
  \ifundef{\@red} {
    \ifundef{\@indigo}{
      \ifundef{\@orange} {
        \ifundef{\@monochrome} {}
        { \definecolor{basecolor}{HTML}{000000}}
      }
      { \definecolor{basecolor}{HTML}{e68a00} }
    }
    { \definecolor{basecolor}{rgb}{0.2, 0.07, 0.48} }
  }
  { \definecolor{basecolor}{HTML}{b30000} }     %RED
}
{ \definecolor{basecolor}{rgb}{0.0, 0.62, 0.38} }

    \definecolor{darkGrey}{HTML}{989898}

\colorlet{linkcolor}{basecolor}
\colorlet{accentcolor}{linkcolor!90}
\colorlet{symbolcolor}{linkcolor!85}

% Setup hyperref package, and colours for links
%\definecolor{linkcolour}{rgb}{0,0.2,0.6}

\if@showLinks
  \hypersetup{%
    breaklinks
  }%
\else
  \hypersetup{%
    pdfborder = {0 0 0},
    breaklinks
  }%
\fi

% Setup fancyhdr package
\fancyhf{}
\fancyhfoffset{0em}
% Remove head rule
\renewcommand{\headrulewidth}{0pt}
%\fancyfoot[C]{\thepage}
\pagestyle{fancy}

%\pagestyle{empty}                         % non-numbered pages
%\font\fb=''[cmr10]''                      % for use with \LaTeX command

% Setup CV sections
\titleformat{\section}{\Large\raggedright}{}{0em}{}[\titlerule]
\titlespacing{\section}{0pt}{2pt}{2pt}

% Configure list
\setlist[itemize,1]{label=\faAngleRight, nosep, leftmargin=2em} 
\setlist[itemize,2]{label=\faAngleRight, nosep, leftmargin=1.5em} 

% Setup Array : new column type
\newcolumntype{R}[1]{>{\hfill}m{#1}}

%Italian hyphenation for the word: ''corporations''
\hyphenation{im-pre-se}

% Setup fonts
\defaultfontfeatures{Mapping=tex-text}
%

% Define font to use according to localFont option
\ifundef{\@local}
{
  %\setmainfont[BoldFont = Helvetica Neue, ItalicFont=Helvetica Neue Thin Italic ,SmallCapsFont = Helvetica Neue Light]{Helvetica Neue Thin}
  \setmainfont{Source Sans Pro-Regular}[
    BoldFont = SourceSansPro-Semibold, 
    ItalicFont= Source Sans Pro Italic]
}
{
  \setmainfont{SourceSansPro-Regular}[
    Path = fonts/, 
    BoldFont = SourceSansPro-Semibold, 
    ItalicFont = SourceSansPro-It]
}

%New length definition
\newlength{\rightcolumnlength}
\setlength{\rightcolumnlength}{14.8cm}

\newlength{\leftcolumn}
\setlength{\leftcolumn}{2.5cm}

% Font Awesome icons aliases
\newcommand{\mailSymbol}{\faAt}
\newcommand{\locationSymbol}{\faMapMarker}
\newcommand{\infoSymbol}{\faInfo}
\newcommand{\linkedinSymbol}{\faLinkedin}
\newcommand{\viadeoSymbol}{\faViadeo}
\newcommand{\mobileSymbol}{\faMobilePhone}
\newcommand{\githubSymbol}{\faGithub}
\newcommand{\linkSymbol}{\faLink}

\newcommand\link[2]{\color{linkcolor}\href{#1}{#2}\color{Black} }
\newcommand\important[1]{\textbf #1}

% Create a tag
% Usage: \cvtag{<tag label>}
\newcommand{\cvtag}[1]{%
  \tikz[baseline]\node[anchor=base,draw=darkGrey!70,rounded corners=0.5ex,inner xsep=1ex,inner ysep =0.55ex,text height=1.3ex,text depth=.25ex]{#1};
}
 % Enhanced conditional-aware skills processor
  \newcommand{\processconditionalskills}[1]{%
    % Process conditionals and create clean comma-separated list
    \begingroup
    \makeatletter
    \def\@skillslist{}%
    \def\@firstskill{true}%
    % Expand the input to resolve all conditionals
    \edef\@expandedskills{#1}%
    % Parse the expanded result
    \foreach \@skill in \@expandedskills {%
      % Only process non-empty skills
      \expandafter\ifx\expandafter\relax\@skill\relax\else%
        \if\@skill\empty\else%
          \cvtag{\@skill}%
        \fi%
      \fi%
    }%
    \makeatother
    \endgroup
  }

   \newcommand{\processprojectskills}[1]{%
    \foreach \n in {#1}{%
      \ifx\n\empty\else\cvtag{\n}\fi%
    }%
  }

% Render author's name
% Usage: \user{<firstanme>}{<lastname>}
\newcommand\user[2]{\color{accentcolor}{\LARGE #1 \textsc{\textbf{#2}}}\color{Black}}

% Render a text with its symbol
% Usage; \socialtext{<icon>}{<label>}
\newcommand{\socialtext}[2]{\mbox{\textcolor{symbolcolor}{#1}\hspace{0.5em}#2\hspace{1em}}}

% Render a link with its symbol
% Usage; \sociallink{<icon>}{<label>}
\newcommand{\sociallink}[3]{\mbox{\textcolor{symbolcolor}{#1}\hspace{0.5em}\link{#2}{#3}\hspace{1em}}}

% Define author's name
% Usage: \name{<firstname>}{<lastname>}
% Usage: \firstname{<firstname>}
% Usage: \lastname{<lastname>}
% Usage: \familyname{<familyname>}
\newcommand*{\name}[2]{\def\@firstname{#1}\def\@lastname{#2}}
\newcommand*{\firstname}[1]{\def\@firstname{#1}}
\newcommand*{\lastname}[1]{\def\@lastname{#1}}
\newcommand*{\familyname}[1]{\def\@lastname{#1}}
\def\@familyname{\@lastname}

% Define author's tagline
% Usage: \tagline{<tag line>}
\newcommand*{\tagline}[1]{\def\@tagline{#1}}

% Define author's photo
% Usage \photo{<diameter>}{<photo>}
\newcommand{\photo}[2]{\def\@photo{#2}\def\@photodiameter{#1}}

% Render author's address
% Usage: \address{<address>}
\newcommand*{\address}[1]{\socialtext{\locationSymbol}{#1}}

% Render author's infos
% Usage: \infos{<infos>}
\newcommand*{\infos}[1]{\socialtext{\infoSymbol}{#1}}

% Render author's linked-in (optional)
% Usage: \linkedin{<linked-in-nick>}
\newcommand*{\linkedin}[1]{\sociallink{\linkedinSymbol}{http://www.linkedin.com/in/#1/fr}{linkedin.com/in/#1}}

% Render author's personal website (optional)
% Usage: \personalLink{<website-without-http://www.>}
\newcommand*{\personalLink}[1]{\sociallink{\linkSymbol}{http://www.#1}{#1}}


% Render author's viadeo(optional)
% Usage: \viadeo{<viadeo-nick>}
\newcommand*{\viadeo}[1]{\sociallink{\viadeoSymbol}{http://www.viadeo.com/fr/profile/#1}{viadeo.com/fr/profile/#1}} 

% Render author's github (optional)
% Usage: \github{<github-nick>}
\newcommand*{\github}[1]{\sociallink{\githubSymbol}{https://www.github.com/#1}{github.com/#1}}           % Github icon + URL

% Render author's email (optional)
% Usage: \email{<email adress>}
\newcommand*{\email}[1]{\sociallink{\mailSymbol}{mailto:#1}{#1}}

% Render a website link (optional)
% Usage: \email{<email adress>}
\newcommand*{\website}[2]{\sociallink{\faExternalLink}{#1}{#2}}

% Render author's mobile phone (optional)
% Usage: \smartphone{<mobile phone number>}
\newcommand*\smartphone[1]{\socialtext{\mobileSymbol}{#1}}    

% Render author's tagline
\newcommand\resumetitle[1]{
  \ifundef{\@alternative}{
	 \par{
	 	 \bigskip\center{\Large \color{accentcolor}\textbf{#1}\color{Black}}\par
	 }
	 \bigskip
  }{
    \color{accentcolor}\textbf{\large{#1}}\color{black}
  }
}

\newcommand\idphoto{
  \tikz\path[fill overzoom image={\@photo}]rectangle (\linewidth,1.2\linewidth);
  %  \tikz\path[fill overzoom image={\@photo}]circle(radius = 0.5\linewidth);
}

% Define social entries to print in header
\newcommand{\socialinfo}[1]{\def\@socialinfo{#1}}

% Render CV header
% Needs \@firstname, \@lastname and \@tagline to be defined
\newcommand*{\makecvheader}{
  \ifundef{\@alternative}{
    \ifundef{\@photodiameter}{
      \begin{minipage}{\linewidth}
    }{
      \begin{minipage}{\dimexpr\linewidth-\@photodiameter-2em}
    }
    \color{accentcolor}\user{\@firstname}{\@lastname}\color{black}\\
    \small{\@socialinfo}
    \end{minipage}
    \ifdef{\@photodiameter}{
      \begin{minipage}{\@photodiameter}
        \idphoto
      \end{minipage}
    }{}
    \resumetitle{\@tagline}
  }{
    \ifundef{\@photodiameter}{
      \begin{minipage}{\linewidth}
    }{
      \begin{minipage}{\dimexpr\linewidth-\@photodiameter-2em}
    }
    \user{\@firstname}{\@lastname}\\
    \resumetitle{\@tagline}
    \smallskip\\
    \small{\@socialinfo}
    \end{minipage}
    \ifdef{\@photodiameter}{
      \begin{minipage}{\@photodiameter}
        \idphoto
      \end{minipage}
    }{}
    \bigskip
  }
}

% Define a footer for CV
% Usage: \makecvfooter{<left>}{<center>}{<right>}
\newcommand*{\makecvfooter}[3]{%
  \fancyfoot{}
  \fancyfoot[L]{#1}
  \fancyfoot[C]{#2}
  \fancyfoot[R]{#3}
}

% Resume part title definition
\newcommand\sectionTitle[2]{\section{\texorpdfstring{\color{accentcolor}#2\enspace \textsc{#1}}{#1}}}

% Define the 'keywords' environment
\newenvironment{keywords}{%
  \renewcommand{\arraystretch}{1.1}

  \begin{tabular}{>{}r>{}p{12.3cm}} 
}{%
  \end{tabular}
}

% Render a scholarshipentry in the scolarship environment
% Usage: \scholarshipentry{<date>}{<description>}
\newcommand\keywordsentry[2]{
  \textbf{#1} &   #2\\ 
}

% Define a new column type for the scholarship environment
\newcolumntype{Y}{>{\raggedleft}p{\leftcolumn}}

% Define the 'scholarship' environment
\newenvironment{scholarship}{%
  \begin{tabular}{Y p{\rightcolumnlength}}
}{%
  \end{tabular}
}

% Render a scholarshipentry in the scolarship environment
% Usage: \scholarshipentry{<date>}{<description>}
\newcommand\scholarshipentry[2]{
  #1    &  #2 \\
}

% Define the 'skills' environment
\newenvironment{skills}{%
  \begin{longtable}{R{\leftcolumn}p{\rightcolumnlength}}
}{%
  \end{longtable}
}

% Render a skill in the skills environment
% Usage: \skill{<skill>}{<level>}
\newcommand\skill[3]{
  \textbf{#1}   & {#3} \\
}

\newcolumntype{E}{>{\raggedright\arraybackslash}p{\rightcolumnlength}}

% Define the 'experiences' environment
\newenvironment{experiences}{%
  \begin{longtable}{R{\leftcolumn}|E}
}{%
  \end{longtable}
}

% Render an experience in the experiences environment
% Usage: 
% \experience
%  {<End date>}      {<Title>}{<Enterprise>}{<Country>}
%  {<Start date}     {
%                      <Experience description (Could be a list)>
%                    }
%                    {<Technology list>}
\newcommand\experience[7]{
  \textbf{#1}    & \textbf{#2, \textsc{#3} #4}   								\\*
  \textbf{#5}    & \begin{minipage}[t]{\rightcolumnlength}
  					         #6
                   \end{minipage}										\\*
                 & \footnotesize{\processconditionalskills{#7}} 	\\
  }

% Render a consultant experience in the experiences environment
% Usage: 
% \consultantexperience
%  {<End date>}      {<Consultant title>}{<Consulting Enterprise>}{<Country>}
%  {<Start date}     {<Client title>}{<Client business unit>}
%                    {
%                      <Experience description (Could be a list)>
%                    }
%                    {<Technology list>}
\newcommand\consultantexperience[9]{
  \textbf{#1}    & \textbf{#2, \textsc{#3}, #4}   								\\*
  \textbf{#5}    & \emph{#6} pour \textsc{#7}                       				\\*
  				       & 	\begin{minipage}[t]{\rightcolumnlength}
  						        #8
                   	\end{minipage}										\\*
                 & \footnotesize{\foreach \n in {#9}{\cvtag{\n}}} 	\\
  }

\newcommand\emptySeparator{\multicolumn{2}{c}{}\\}

% Define the 'projects' environment
\newenvironment{projects}{%
  \begin{longtable}{l}
}{%
  \end{longtable}
}

% Define the 'project' entry in the 'projects' environment
% Usage:
% \project
%   {<Project name>}{<dates>}
%   {<link1> <link2>}
%   {<Project description>}
%   {<techno1>,<techno2>}
 \newcommand\project[5]{
    \begin{minipage}[t]{\dimexpr(\linewidth) - 1.5em}
      \textbf{\textsc{#1}} \hfill \textsc{#2}\smallskip\\
      #3\\
      \begin{minipage}[t]{\textwidth}
        #4
      \end{minipage}
      \smallskip\\
       \footnotesize{\processconditionalskills{#5}}\\
    \end{minipage}
    \\*
  }



\newcommand*\twocolumnsection[2]{
  \begin{minipage}[t]{\dimexpr(\linewidth/2) - 3em}
    #1
  \end{minipage}
  \hfill
  \begin{minipage}[t]{\dimexpr(\linewidth/2) - 3em}
    #2
  \end{minipage}
  }

  \newcommand*\threecolumnsection[3]{
  \begin{minipage}[t]{\dimexpr(\linewidth/4) - 3em}
    #1
  \end{minipage}
  \hfill
  \begin{minipage}[t]{\dimexpr(\linewidth/2) - 9em}
    #2
  \end{minipage}
  \hfill
  \begin{minipage}[t]{\dimexpr(\linewidth/2) - 5em}
    #3
  \end{minipage}
  }

% Define the 'referencees' environment
\newenvironment{referees}{%
}{%
  \hfill
  \bigskip
}

\newcommand*\referee[5]{
  \hspace{1em}
  \begin{minipage}[t]{\dimexpr(\linewidth/3) - 3em}
    \begin{tabular}{>{}l >{}l}
      \multicolumn{2}{l}{\textbf{#1}}\\
      \multicolumn{2}{l}{\emph{#2}, \textsc{#3}}\\
      \quad \mailSymbol & \href{mailto:#4}{#4} \\  
      \quad \faPhone & #5 \\
    \end{tabular}
  \end{minipage}%
}

