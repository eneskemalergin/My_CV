# My CV: Enes Kemal Ergin

LaTeX source files for my academic CV and job-specific resumes. Built on **resonancecv**, a LaTeX class I wrote from scratch.

---

## Repository structure

```bash
My_CV/
├── resonancecv.cls          # Custom LaTeX class (MIT, © 2026 Enes Kemal Ergin)
├── Academic_CV.tex/.pdf     # Full academic CV (resonancecv)
├── Full_CV_Resonance.tex/.pdf  # Comprehensive CV with all sections (resonancecv)
└── legacy/                  # Archived files using the old res.cls
    ├── res.cls              # © 1988–1989 Michael DeCorte (own license)
    ├── Academic_CV.tex/.pdf
    └── Full_CV.tex/.pdf
```

---

## resonancecv

`resonancecv.cls` is available under the **MIT License**.

### Design principles

- **Gutter layout.** Section labels sit in a narrow left-margin column; body content lives in a clean indented column.
- **Single font family.** Latin Modern Sans throughout. Hierarchy is expressed through weight, size, and colour only. No font-family mixing.
- **Consistent date column.** Every entry type shares a right-aligned date column at a fixed width.
- **Semantic macros.** The source reads like structured data, not raw formatting commands.

### Quick-reference: user commands

#### Preamble setup

| Command                     | Purpose                              |
| --------------------------- | ------------------------------------ |
| `\name{Full Name}`          | Name shown in the header             |
| `\tagline{text}`            | One-line descriptor below the name   |
| `\cvtitle{text}`            | Sets the PDF document title metadata |
| `\contactline{left}{right}` | Adds one two-column contact row      |

#### Layout & colour overrides _(call in preamble)_

| Command                         | Default   | Purpose                               |
| ------------------------------- | --------- | ------------------------------------- |
| `\setsectionwidth{0.95in}`      | `0.95in`  | Width of the left-margin gutter       |
| `\setdatewidth{1.45in}`         | `1.45in`  | Width of the right date column        |
| `\setaccentcolor{HTML}{1F4E79}` | deep navy | Accent colour (section labels, links) |
| `\setmutedcolor{HTML}{4B5563}`  | cool grey | Muted colour (dates, orgs, sub-heads) |

#### Entry macros _(inside `{resume}` environment)_

| Command                                 | Use for                                                 |
| --------------------------------------- | ------------------------------------------------------- |
| `\cventry{title}{org}{date}{body}`      | Work / research experience entries                      |
| `\degreeentry{degree}{uni}{date}{body}` | Education entries (semantic alias for `\cventry`)       |
| `\cvdateditem{title}{date}{body}`       | Projects, software releases                             |
| `\cvminorrow{text}{date}`               | Compact single-line entry with right-aligned date       |
| `\cvrow{text}{date}`                    | Plain text + right date (no bullet)                     |
| `\cvskill{Category}{items}`             | Skills: bold category label + item list                 |
| `\cvsubheading{text}`                   | In-body grouping label (e.g., "Peer-Reviewed Articles") |
| `\pubentry{full reference}`             | Hanging-indent bibliographic entry                      |
| `\talkentry{venue}{date}{title}`        | Talk/presentation entry                                 |

#### List environments

| Environment       | Use for                                               |
| ----------------- | ----------------------------------------------------- |
| `list1` / `list2` | Bulleted lists with tight spacing (two indent levels) |
| `publist`         | Publication list (numbered, hanging indent)           |

### Minimal example

```latex
\documentclass[line]{resonancecv}

\name{Jane Doe}
\tagline{Computational biologist}
\contactline{jane@example.com}{github.com/janedoe}

\begin{document}
\begin{resume}

\section{Education}
\degreeentry{PhD, Bioinformatics}{Some University}{2019 -- 2024}{Thesis title here.}

\section{Experience}
\cventry{Postdoctoral Fellow}{Research Institute}{Jan 2025 -- Present}{%
\begin{list2}
\item Built tools. Published papers.
\end{list2}}

\section{Skills}
\cvskill{Languages}{Python, R, Bash}

\end{resume}
\end{document}
```

---

## Building the PDFs

Any standard LaTeX distribution works. Run `pdflatex` twice to resolve cross-references:

```bash
# Full academic CV
pdflatex Academic_CV.tex && pdflatex Academic_CV.tex

# Full resonance CV
pdflatex Full_CV_Resonance.tex && pdflatex Full_CV_Resonance.tex

# A job-specific resume
cd job_specific
pdflatex YourResume.tex
```

Or use `latexmk` for automatic recompilation:

```bash
latexmk -pdf Academic_CV.tex
```

**Dependencies** (all standard in TeX Live / MiKTeX):  
`geometry`, `lmodern`, `hyperref`, `enumitem`, `xcolor`, `microtype`, `tabularx`, `ragged2e`, `needspace`, `xparse`, `etoolbox`, `changepage`

---

## License

`resonancecv.cls` and all `.tex` source files authored by Enes K. Ergin are released under the **MIT License**. See [LICENSE](LICENSE).

`legacy/res.cls` is the work of Michael DeCorte (1988–1989) and is governed by its own terms. See [legacy/LICENSE](legacy/LICENSE).

---

<div align="center">

_Gutter holds the breath,_
_Black type flows in silver space—_
_Life, compiled in ink._

</div>
