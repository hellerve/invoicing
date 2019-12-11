\ProvidesClass{invoice}

\LoadClass[12pt]{article}

\usepackage[letterpaper,hmargin=0.79in,vmargin=0.79in]{geometry}
\usepackage[english]{babel}
\usepackage[parfill]{parskip}
\usepackage{fp}
\usepackage{calc}
\usepackage{longtable}
\usepackage[table]{xcolor}

\usepackage{fontspec}
\setmainfont[Mapping=tex-text]{Charter}

\usepackage[gen]{eurosym}

\definecolor{lightgrey}{gray}{0.94}

\let\oldlongtable\longtable
\let\endoldlongtable\endlongtable
\renewenvironment{longtable}{\rowcolors{2}{lightgrey}{white}\oldlongtable} {
\endoldlongtable}

\pagestyle{empty}
\linespread{1.3}

\setlength{\doublerulesep}{\arrayrulewidth}

\newcommand{\feetype}[1]{
    \textbf{#1}
    \\
}

\newcounter{hours} \newcounter{subhours} \newcounter{cost} \newcounter{subcost}
\setcounter{hours}{0} \setcounter{subhours}{0} \setcounter{cost}{0} \setcounter{subcost}{0}

\newcommand*{\formatNumber}[1]{\FPround{\cost}{#1}{2}{\cost\thinspace \texteuro}} %

\newcommand*{\total}[1]{\FPdiv{\t}{\arabic{#1}}{1000}\formatNumber{\t}}
\newcommand*{\mwst}[1]{
  \FPmul{\t}{\arabic{#1}}{0.19}
  \FPdiv{\tx}{\t}{1000}\formatNumber{\tx}
}
\newcommand*{\totalpmwst}[1]{
  \FPmul{\t}{\arabic{#1}}{0.19}
  \FPdiv{\tx}{\t}{1000}
  \FPdiv{\ty}{\arabic{#1}}{1000}
  \FPadd{\tz}{\tx}{\ty}
  \formatNumber{\tz}
}

\newenvironment{invoiceTable}{
    % Create a new row from title, unit quantity, unit rate, and unit name
    \newcommand*{\unitrow}[4]{%
         \addtocounter{cost}{1000 * \real{##2} * \real{##3}}%
         \addtocounter{subcost}{1000 * \real{##2} * \real{##3}}%
         ##1 & ##2 ##4 & {\formatNumber{##3}} & \FPmul{\cost}{##2}{##3}{\formatNumber{\cost}} %
         \\
    }

    \renewcommand{\tabcolsep}{0.8ex}
    \setlength\LTleft{0pt}
    \setlength\LTright{0pt}
    \begin{longtable}{@{\extracolsep{\fill}\hspace{\tabcolsep}} p{8.5cm} r r r }
    {\bf Beschreibung} & {\bf Menge} & {\bf Einzelpreis} & {\bf Summe} \\*
    \hline
}{
    \hline
    \rowcolor{white}
    & & Net sum & {\bf \total{cost}} \\
    \rowcolor{white}
    & & 19\% VAT & {\bf \mwst{cost}} \\
    \rowcolor{white}
    & & {\bf Rechnungsbetrag } & {\bf \totalpmwst{cost}} \\
    \end{longtable}
}
