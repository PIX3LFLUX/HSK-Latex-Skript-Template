<div align="center">

<img src="https://www.h-ka.de/_assets/a92153751098915699a1afa17e77f864/Images/Icons/Favicons/favicon-256x256.png" width="96" alt="HKA">

# HKA LaTeX-Vorlage

**Skript, Abschlussarbeit, Projektbericht — und die passende Präsentation gleich dazu.**
Im Corporate Design der Hochschule Karlsruhe, geprüft und freigegeben von der Abteilung Presse und Kommunikation der HKA.

[![License: CC BY-NC-SA 3.0](https://img.shields.io/badge/License-CC%20BY--NC--SA%203.0-lightgrey.svg)](LICENSE)
[![LaTeX](https://img.shields.io/badge/LaTeX-pdfLaTeX-008080.svg)](https://www.latex-project.org/)
[![Beamer](https://img.shields.io/badge/Beamer-16%3A9-blue.svg)](https://ctan.org/pkg/beamer)
[![HKA Corporate Design](https://img.shields.io/badge/HKA%20CD-freigegeben-brightgreen.svg)](https://www.h-ka.de)

[Schnellstart](#-in-fünf-minuten-zum-ersten-pdf) ·
[Projektstruktur](#-projektstruktur) ·
[Alle Stellschrauben](#-alle-stellschrauben) ·
[Kompilieren](#-kompilieren) ·
[Troubleshooting](#-troubleshooting) ·
[Checkliste vor der Abgabe](#-checkliste-vor-der-abgabe)

</div>

---

## ⚡ In fünf Minuten zum ersten PDF

```bash
git clone https://github.com/PIX3LFLUX/HSK-Latex-Skript-Template.git
cd HSK-Latex-Skript-Template/Document
latexmk -pdf document.tex
```

Fertig — `document.pdf` liegt daneben. Das gleiche Spiel für die Folien:

```bash
cd ../Presentation
latexmk -pdf presentation.tex
```

> [!IMPORTANT]
> **Immer aus dem jeweiligen Ordner heraus kompilieren.** Die Vorlage arbeitet
> mit relativen Pfaden (`../Pictures/`, `../bibliography.bib`). Ein Aufruf aus
> dem Repo-Wurzelverzeichnis findet die Bilder und die Literaturdatei nicht.
> In TeXstudio, VS Code & Co. heißt das: das jeweilige `document.tex` bzw.
> `presentation.tex` als **Hauptdokument / Root-Dokument** setzen.

Danach: in `Document/document.tex` den Block **ZENTRALE ANGABEN** ausfüllen (Titel,
Autor, Fakultät) und in `Document/01_einleitung.tex` mit dem Schreiben anfangen.
Alles Weitere steht unten.

<details>
<summary><b>Was brauche ich installiert?</b></summary>

<br>

Eine **vollständige** TeX-Distribution. Die Vorlage nutzt u. a. `plex-sans`,
`avant`, `biblatex`, `glossaries`, `circuitikz`, `siunitx`, `cleveref`,
`microtype` und `mdframed` — bei minimalen Installationen fehlt davon
erfahrungsgemäß die Hälfte.

| System | Empfehlung |
| --- | --- |
| Windows | [TeX Live](https://tug.org/texlive/) (Schema *full*) oder [MiKTeX](https://miktex.org/) mit Auto-Install |
| macOS | [MacTeX](https://tug.org/mactex/) |
| Linux | `texlive-full` (Debian/Ubuntu) bzw. `texlive-scheme-full` |
| Kein Setup gewünscht | [Overleaf](https://www.overleaf.com/) — Repo als ZIP hochladen |

**Editoren**, die sich hier bewährt haben:
[TeXstudio](https://www.texstudio.org/) (der Klassiker, gute Fehlermeldungen),
[VS Code](https://code.visualstudio.com/) mit
[LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop),
oder Overleaf im Browser.

Zusätzlich sehr empfohlen: **[JabRef](https://www.jabref.org/)** für die
Literaturverwaltung → [eigener Abschnitt](#-literatur-mit-jabref).

</details>

---

## 📂 Projektstruktur

```
HSK-Latex-Skript-Template/
│
├── Document/                    ← das Skript / die Arbeit
│   ├── document.tex             ← HAUPTDATEI: Metadaten, Farbe, Kapitelreihenfolge
│   ├── structure_document.tex   ← Layout, Schriften, Boxen  (normalerweise nicht anfassen)
│   ├── customcommands.tex       ← eigene Makros: \ofig, \pfig, Titelseite
│   ├── acronyms.tex             ← Abkürzungen und Glossareinträge
│   ├── 01_einleitung.tex        ← dein erstes Kapitel (Gerüst zum Überschreiben)
│   └── 99_example.tex           ← Schaufenster aller Formatierungen (vor Abgabe raus)
│
├── Presentation/                ← die Folien  (nicht gebraucht? Ordner einfach löschen)
│   ├── presentation.tex         ← HAUPTDATEI: Metadaten, Farbe, Folienreihenfolge
│   ├── structure_presentation.tex ← Folienlayout, \EIT…-Befehle
│   ├── 99_example.tex           ← Beispielfolien für jeden Baustein
│   ├── Templates/               ← die vier Hintergrund-PDFs des HKA-CD  (Pflicht!)
│   └── Demo/                    ← fertiges Beispiel-PDF + Beamer-Cheatsheet
│
├── Pictures/                    ← GETEILT: alle Bilder für Skript UND Folien
├── bibliography.bib             ← GETEILT: eine Literaturdatenbank für beides
│
├── Makefile                     ← Komfort-Build für beide Dokumente
├── LICENSE                      ← CC BY-NC-SA 3.0
└── README.md
```

### Warum zwei Ordner — und was in der Mitte liegt

Das ist die zentrale Designentscheidung dieser Vorlage:

* **`Document/` und `Presentation/` sind sauber getrennt.** Zwei Hauptdateien,
  zwei Layout-Dateien, keine gegenseitigen Abhängigkeiten. Beide Dokumente lassen
  sich unabhängig voneinander bearbeiten und kompilieren, ohne dass sich Pakete
  oder Definitionen in die Quere kommen.
* **`Pictures/` und `bibliography.bib` liegen bewusst eine Ebene höher** und
  werden von *beiden* Seiten genutzt (`\graphicspath{{../Pictures/}}`,
  `\addbibresource{../bibliography.bib}`). Eine Abbildung, die im Skript steht,
  landet mit demselben Dateinamen auf der Folie. Eine Quelle, die einmal in
  JabRef gepflegt wurde, ist an beiden Stellen zitierbar. **Keine Doppelarbeit,
  keine auseinanderlaufenden Versionen.**
* **Wer keine Präsentation braucht, löscht schlicht den Ordner `Presentation/`.**
  Das Skript kompiliert danach unverändert weiter — es gibt keinen einzigen
  Verweis darauf. Umgekehrt funktioniert es genauso: Nur Folien gewünscht?
  `Document/` löschen, `Pictures/` und `bibliography.bib` behalten.

---

## 🎨 Alle Stellschrauben

Beide Hauptdateien sind gleich aufgebaut: Oben steht ein klar abgegrenzter Block
**ZENTRALE ANGABEN — HIER ANPASSEN**, darunter beginnt der Bereich
*AB HIER NORMALERWEISE NICHTS ÄNDERN*. Wenn du dich an diese Trennung hältst,
bleibt das Corporate Design intakt und Updates der Vorlage lassen sich später
leichter einspielen.

<details>
<summary><b>🎓 Fakultätsfarbe — die eine Zeile, die fast jeder ändern muss</b></summary>

<br>

Alle sechs Hausfarben sind vordefiniert. Gewechselt wird über **eine einzige
Zeile** — identisch in `document.tex` und `presentation.tex`:

```latex
\colorlet{ThemeColor}{HKA@eit}   % <<<<< HIER Fakultät wählen
```

| Kürzel | Fakultät | RGB |
| --- | --- | --- |
| `HKA@eit` | Elektro- und Informationstechnik | 40, 135, 50 |
| `HKA@ab` | Architektur und Bauwesen | 25, 130, 130 |
| `HKA@mmt` | Maschinenbau und Mechatronik | 40, 105, 175 |
| `HKA@w` | Wirtschaftswissenschaften | 30, 70, 150 |
| `HKA@iwi` | Informatik und Wirtschaftsinformatik | 100, 55, 140 |
| `HKA@imm` | Informationsmanagement und Medien | 140, 45, 130 |

Die Farbe zieht sich automatisch durch Titelseite, Kapitelköpfe, Überschriften,
Boxen, Links und Folienelemente.

> [!WARNING]
> Eigene Farben statt der sechs Hausfarben brechen das freigegebene Corporate
> Design. Für interne Dokumente ist das dein Bier — für alles, was die Hochschule
> nach außen repräsentiert, bitte bei den Vorgaben bleiben.

</details>

<details>
<summary><b>📄 Skript: Metadaten, Titelseite, Verzeichnisse</b></summary>

<br>

**Angaben zum Dokument** (`Document/document.tex`):

```latex
\newcommand{\scriptTitle}   {Titel des Skripts}
\newcommand{\scriptSubject} {Thema des Skripts}
\newcommand{\scriptAuthor}  {Autorenname}
\newcommand{\scriptFaculty} {Elektro- und \\ Informationstechnik}  % \\ = Zeilenumbruch
\newcommand{\scriptCourse}  {Vorlesung XYZ}
\newcommand{\scriptKeywords}{Keyword1, Keyword2, Keyword3}
```

Diese Werte landen gleichzeitig in den **PDF-Metadaten** (Titel, Autor,
Schlagwörter, Sprache) — gut für Auffindbarkeit und Barrierefreiheit.

**Angaben zur Veröffentlichung** (Impressumsseite hinter dem Titel):

```latex
\newcommand{\scriptPublisher}{NAME}
\newcommand{\scriptWebsite}  {https://book-website.com}
\newcommand{\scriptLicense}  {CC BY-NC-SA 3.0 (...)}
\newcommand{\scriptEdition}  {Erste Ausgabe, Stand: \today}
\newcommand{\scriptYear}     {2026}
```

**Titelbild und Farbbalken** (`Document/customcommands.tex`):

```latex
\newcommand{\hkaCoverImage}{cover_image.jpg}  % leer lassen => kein Titelbild
\setlength{\hkaColorBlockHeight}{3cm}         % Höhe des farbigen Balkens unten
```

Die Bildhöhe wird aus der Seitenhöhe berechnet, die Titelseite stimmt daher auch
bei anderem Papierformat als A4.

**Zusätzliche Verzeichnisse** sind vorbereitet, aber auskommentiert. Wer ein
Abbildungs- oder Tabellenverzeichnis braucht, entfernt in `document.tex` die
Kommentarzeichen:

```latex
%\cleardoublepage
%\addcontentsline{toc}{chapter}{Abbildungsverzeichnis}
%\listoffigures
```

Literaturverzeichnis, Abkürzungsverzeichnis, Glossar und Index sind bereits
aktiv und füllen sich von selbst.

</details>

<details>
<summary><b>🖼️ Kapitelbilder — der Schalter, der das Erscheinungsbild macht</b></summary>

<br>

Kapitelbilder sind kein Deko-Extra, sondern der prägende Bestandteil des Layouts.
**Ein Skript ohne Kapitelbilder sieht deutlich anders aus als vorgesehen.**

Pro Kapitel, jeweils am Anfang der Kapiteldatei:

```latex
\chapterimage{chapter_image_1.jpg}   % ohne "Pictures/", ohne Pfad
\chapter{Einleitung}
```

Für Inhaltsverzeichnis und die hinteren Verzeichnisse in `document.tex`:

```latex
\newcommand{\tocChapterImage} {chapter_image_1.jpg}
\newcommand{\backChapterImage}{chapter_image_2.jpg}
```

**Global abschalten** (Kopfbereich bleibt weiß) — Zeile in `document.tex` ergänzen:

```latex
\usechapterimagefalse
```

> [!TIP]
> **Seitenverhältnis 2:1**, z. B. 920 × 460 Pixel. Andere Formate werden auf
> Seitenbreite skaliert und der Kapitelkopf verrutscht.
> Keine passenden Bilder zur Hand? Generative KI liefert brauchbare,
> rechtlich unbedenkliche Kapitelbilder in Sekunden — Prompt-Idee: abstrakte,
> technische Motive in der Fakultätsfarbe.

</details>

<details>
<summary><b>🔧 Skript: eigene Befehle für den Alltag</b></summary>

<br>

**Abbildungen** — `\ofig` ("one figure") spart die komplette `figure`-Umgebung:

```latex
\ofig{Bildunterschrift}{dateiname}{0.6\linewidth}
\ofig[eigenesLabel]{Bildunterschrift}{dateiname}{\linewidth}
```

Verweis darauf mit `\cref{fig:dateiname}` bzw. `\cref{fig:eigenesLabel}`.
Dateiname **ohne** Endung und **ohne** `Pictures/`.

> [!CAUTION]
> Ohne optionales Label wird der Dateiname als Label benutzt. Sobald der
> Dateiname **Unterstriche oder Punkte** enthält, geht das schief — dann
> zwingend das optionale Argument setzen: `\ofig[messung1]{...}{mess_reihe_1}{...}`.

**Platzhalter**, solange das echte Bild noch fehlt (Umbruch und Nummerierung
stimmen schon):

```latex
\pfig{Hier kommt noch die Messkurve hin}
```

**Querverweise** immer mit `\cref` — das Wort davor kommt automatisch mit:

```latex
\cref{ch:einleitung}   →  "Kapitel 1"
\cref{fig:beispiel}    →  "Abbildung 1.2"
```
Ein zusätzlich getipptes "Kapitel" davor wäre also doppelt.

**Einheiten** mit `siunitx` — im Quelltext immer Punkt schreiben, das Komma
macht das Paket:

```latex
\SI{12345.67}{\metre\per\second}   →  12 345,67 m/s
```

**Anführungszeichen** mit `\enquote{...}` (sprachrichtig, auch verschachtelt).

**Abkürzungen und Glossar** — Einträge in `Document/acronyms.tex`:

```latex
\newacronym{gcd}{GCD}{Greatest Common Divisor}
\newglossaryentry{latexg}{name=latex, description={...}}
```
Im Text: `\acrfull{gcd}` (erste Nennung, schreibt aus), danach `\acrshort{gcd}`.
Das Verzeichnis am Ende füllt sich automatisch.

**Index**: `\index{Stichwort}` an beliebiger Stelle setzen.

**Gleitobjekte**: Abbildungen und Tabellen werden durch `placins` gezwungen, vor
dem nächsten `\section` zu erscheinen. Innerhalb von `\subsection` wirkt das
nicht — dort bei Bedarf `\FloatBarrier` von Hand setzen.

</details>

<details>
<summary><b>📽️ Präsentation: Metadaten und Folienbausteine</b></summary>

<br>

**Angaben** (`Presentation/presentation.tex`):

```latex
\newcommand{\talkTitle}     {Willkommen}
\newcommand{\talkSubtitle}  {Einführung: Präsentationen mit \LaTeX{} erstellen}
\newcommand{\talkAuthor}    {Vorname Nachname}
\newcommand{\talkKeywords}  {Keyword1, Keyword2, Keyword3}
\newcommand{\talkCoverImage}{chapter_image_1.jpg}
```

**Die Folienbausteine** — mehr braucht es für 95 % aller Vorträge nicht:

| Befehl | Zweck |
| --- | --- |
| `\EITCoverVI{Titel}{Autor}{Bild}` | Eröffnungsfolie |
| `\EITCoverSubtitleVI{Titel}{Untertitel}{Autor}{Bild}` | Eröffnungsfolie mit Untertitel |
| `\EITTableOfContent{Inhaltsverzeichnis}{2}` | Agenda; 2. Argument = Zeilenabstand |
| `\EITHeadlineFT{Titel}{Inhalt}` | **die Standardfolie** |
| `\placetextbox{x}{y}{breite}{Inhalt}` | frei positionierter Textblock |
| `\placepictureandtext{...}` | Bild mit Beschriftung darunter |
| `\picdims[opt]{breite}{höhe}{...}` | Bild auf feste Maße zuschneiden |

Gegliedert wird mit `\section{...}` — daraus baut sich die Agenda.

**Zwei Spalten** entstehen aus zwei `\placetextbox`-Aufrufen mit den
vordefinierten Maßen:

```latex
\EITHeadlineFT{Folie mit zwei Spalten}{
  \placetextbox{\leftmarginpos}{\topmargincontent}{\columnmaxwidth}{ ... }
  \placetextbox{\secondcolumnstart}{\topmargincontent}{\columnmaxwidth}{ ... }
}
```

Die Maße lassen sich als Ausdruck schreiben, TikZ rechnet das aus:
`{\leftmarginpos + 3cm}`.

**Verfügbare Maße** (alle in `presentation.tex` definiert und anpassbar):
`\leftmarginpos`, `\topmargintitle`, `\topmargincontent`, `\maximumwidth`,
`\maximumheight`, `\columnmaxwidth`, `\secondcolumnstart` sowie die Schriftgrößen
`\covertextsize`, `\coversubtitlesize`, `\titletextsize`, `\contenttextsize`.

**Fußzeile** — Standard ist links Hochschule, Datum und Foliennummer. Mit
definiertem `\foottext` erscheint stattdessen eine zentrierte Zeile:

```latex
% global: in presentation.tex einkommentieren
\newcommand{\foottext}{Hochschule Karlsruhe --- Fakultät für ... --- Name}
```
Für **einzelne** Folien reicht eine Gruppe — die Wirkung endet mit der Klammer:

```latex
{
\newcommand{\foottext}{Nur auf dieser Folie}
\EITHeadlineFT{...}{...}
}
```

**Handout ohne `\pause`-Schritte** — Zeile in `presentation.tex` tauschen:

```latex
\documentclass[handout, 17pt, t, aspectratio=169, xcolor=table]{beamer}
```

**Hintergrund-PDFs**: Der Ordner `Presentation/Templates/` muss die vier
CD-Hintergründe enthalten (`HKA-Opening`, `HKA-Normal`, `HKA_Opening_KA_text`,
`HKA_Slide_KA_text`). Ohne sie bricht der Lauf ab. Der Pfad hängt an einer
einzigen Stelle in `structure_presentation.tex`:

```latex
\newcommand{\hkaTemplatePath}{Templates/}
```

**Nachschlagen**: `Presentation/99_example.tex` zeigt jeden Baustein einmal
durch — Text, Formeln, Spalten, Tabellen, Abbildungen, Bildfolien, Quellen.
Dazu gibt es ein fertiges [Demo-PDF](Presentation/Demo/02_presentation.pdf) und
ein [Beamer-Cheatsheet](Presentation/Demo/presentation_cheatsheet.pdf).

</details>

<details>
<summary><b>🌍 Sprache umstellen (Deutsch → Englisch)</b></summary>

<br>

Die Vorlage ist auf Deutsch eingestellt (`babel`, `cleveref`, Verzeichnistitel).
Für ein englisches Dokument in `Document/structure_document.tex`:

```latex
\usepackage[english]{babel}
\usepackage[english,capitalise]{cleveref}
```

Für ein **mehrsprachiges** Dokument beide Sprachen laden, die zuletzt genannte
ist die Hauptsprache:

```latex
\usepackage[english,ngerman]{babel}
```

Anschließend in `document.tex` die deutschen Verzeichnistitel
(`Literaturverzeichnis`, `Abkürzungsverzeichnis`, `Glossar`) anpassen und
`pdflang = {de-DE}` auf `{en-US}` ändern.

</details>

---

## 📚 Literatur mit JabRef

Beide Dokumente ziehen ihre Quellen aus **einer** Datei: `bibliography.bib` im
Wurzelverzeichnis. Diese Datei lässt sich hervorragend mit
**[JabRef](https://www.jabref.org/)** pflegen — einem kostenlosen,
plattformübergreifenden Open-Source-Literaturverwaltungsprogramm, das direkt auf
dem `.bib`-Format arbeitet. Kein Export, kein Zwischenformat, keine Datenbank
im Hintergrund: **JabRef bearbeitet genau die Datei, die LaTeX auch liest.**

Warum sich das lohnt:

* **Import per Klick** — DOI, ISBN, arXiv-ID oder PubMed-ID eingeben, JabRef holt
  die vollständigen Metadaten. Auch PDFs lassen sich einlesen, JabRef zieht die
  Angaben heraus.
* **Browser-Extension** für Chrome und Firefox: Quelle beim Lesen direkt in die
  Bibliothek übernehmen.
* **Saubere Zitierschlüssel** nach frei definierbarem Muster
  (z. B. `Autor2024Titelwort`) — statt handgetippter Kürzel, die man nach drei
  Wochen nicht mehr zuordnen kann.
* **Konsistenzprüfung**: JabRef meldet fehlende Pflichtfelder, Dubletten und
  kaputte Einträge, bevor `bibtex` es tut.
* **Git-freundlich**, weil die `.bib` eine reine Textdatei bleibt — Änderungen
  sind im Diff nachvollziehbar.

**Im Text zitieren:**

```latex
\cite{schlüssel}          % [1]
\parencite{schlüssel}     % [1] in Klammern
\textcite{schlüssel}      % Autor [1]
```

Konfiguriert ist `biblatex` mit numerischem Stil, Sortierung in Zitierreihenfolge
(`sorting=none`) und Rückverweisen (`backref=true`) — im Literaturverzeichnis
steht also, auf welcher Seite die Quelle zitiert wurde.

> [!NOTE]
> Das Backend ist **`bibtex`**, nicht `biber`. Wer von Hand kompiliert, ruft also
> `bibtex document` auf. `latexmk` erkennt das selbst.

---

## 🔨 Kompilieren

<details open>
<summary><b>Empfohlen: latexmk</b></summary>

<br>

`latexmk` ruft `pdflatex`, `bibtex` und `makeindex` in der richtigen Reihenfolge
und so oft auf, wie nötig — genau das, was ein Dokument mit Literaturverzeichnis,
Index und Querverweisen braucht.

```bash
cd Document && latexmk -pdf document.tex        # Skript
cd Presentation && latexmk -pdf presentation.tex # Folien

latexmk -c    # Hilfsdateien aufräumen, PDF behalten
latexmk -C    # alles aufräumen, inklusive PDF
```

Praktisch beim Schreiben — kompiliert bei jedem Speichern neu und aktualisiert
den Viewer:

```bash
latexmk -pdf -pvc document.tex
```

</details>

<details>
<summary><b>Von Hand (wenn latexmk nicht verfügbar ist)</b></summary>

<br>

Die Reihenfolge ist nicht optional — ohne die Zwischenschritte bleiben
Literaturverzeichnis, Glossar und Index leer:

```bash
cd Document
pdflatex document.tex
bibtex document          # Literaturverzeichnis
makeglossaries document  # Abkürzungsverzeichnis + Glossar
makeindex document       # Index
pdflatex document.tex
pdflatex document.tex    # ja, wirklich zweimal — für Querverweise und Seitenzahlen
```

</details>

<details>
<summary><b>Makefile</b></summary>

<br>

Im Wurzelverzeichnis liegt ein `Makefile` für beide Dokumente:

```bash
make            # beides bauen
make document   # nur das Skript
make presentation
make clean
```

</details>

<details>
<summary><b>TeXstudio</b></summary>

<br>

1. `Document/document.tex` öffnen.
2. **Optionen → Konfiguriere TeXstudio → Erzeugen**: Standardcompiler auf
   `txs:///latexmk` stellen. Damit laufen Literaturverzeichnis, Index und
   Wiederholungsläufe automatisch.
3. Bei mehreren geöffneten Dateien: **Optionen → Root-Dokument → Aktuelles
   Dokument als expliziten Root setzen**, sonst versucht TeXstudio, ein
   eingebundenes Kapitel allein zu übersetzen.

</details>

<details>
<summary><b>VS Code (LaTeX Workshop)</b></summary>

<br>

In `.vscode/settings.json` im Projektverzeichnis:

```jsonc
{
  "latex-workshop.latex.rootFile.useSubFile": true,
  "latex-workshop.latex.recipe.default": "latexmk",
  "latex-workshop.latex.autoBuild.run": "onSave"
}
```

Alternativ das jeweilige Hauptdokument über den Befehl
*LaTeX Workshop: Set LaTeX root file* explizit festlegen.

</details>

<details>
<summary><b>Overleaf</b></summary>

<br>

1. Repo als ZIP herunterladen (**Code → Download ZIP**) und in Overleaf als neues
   Projekt hochladen.
2. **Menu → Main document** auf `Document/document.tex` setzen.
3. **Menu → Compiler**: `pdfLaTeX`.

Overleaf legt für jedes Projekt nur *ein* Hauptdokument fest. Für Skript **und**
Folien lohnen sich zwei getrennte Projekte — oder das Hauptdokument je nach
Bedarf umstellen.

</details>

---

## 🧯 Troubleshooting

| Symptom | Ursache | Lösung |
| --- | --- | --- |
| `File 'plex-sans.sty' not found` (o. ä.) | unvollständige TeX-Installation | Vollinstallation nachziehen (`texlive-full`) oder in MiKTeX Auto-Install aktivieren |
| `File 'placeholder' not found` | aus dem falschen Verzeichnis kompiliert | aus `Document/` bzw. `Presentation/` heraus starten, Root-Dokument im Editor setzen |
| `Templates/HKA-Normal.pdf not found` | Ordner `Presentation/Templates/` fehlt oder verschoben | Ordner wiederherstellen oder `\hkaTemplatePath` in `structure_presentation.tex` anpassen |
| Literaturverzeichnis bleibt leer | `bibtex`-Lauf fehlt | `latexmk` verwenden, oder `bibtex document` und danach zweimal `pdflatex` |
| Abkürzungsverzeichnis / Glossar bleibt leer | `makeglossaries` wird von `latexmk` **nicht** automatisch aufgerufen | einmal `makeglossaries document` von Hand ausführen, danach erneut `pdflatex` — oder eine `.latexmkrc` mit passender Custom-Dependency anlegen |
| `??` statt Nummer bei `\cref` | zu wenige Durchläufe | noch einmal kompilieren; `latexmk` erledigt das selbst |
| Label zeigt auf das falsche Objekt | `\label` steht vor der `\caption` | `\label` immer **nach** `\caption` setzen — bei `\ofig` ist das bereits richtig gelöst |
| Kapitelkopf verrutscht | Kapitelbild hat nicht 2:1 | Bild auf z. B. 920 × 460 px zuschneiden |
| Fehler mit Unterstrich im Bild-Label | `\ofig` ohne optionales Label bei Dateinamen mit `_` | `\ofig[eigenesLabel]{...}{mess_reihe}{...}` |
| Abbildung landet Seiten später | LaTeX-Gleitobjekt-Logik | `\FloatBarrier` an der gewünschten Stelle setzen |
| Merkwürdige Fehler nach größeren Änderungen | veraltete Hilfsdateien | `latexmk -C` und neu bauen |

Steckst du fest? Erst kurz suchen — und wenn du die Lösung hast, gerne als Pull
Request mit einem erklärenden Kommentar im Code zurückgeben. Genau davon lebt
diese Vorlage. Ansonsten:
[Issue eröffnen](https://github.com/PIX3LFLUX/HSK-Latex-Skript-Template/issues).

---

## ✅ Checkliste vor der Abgabe

- [ ] `\input{99_example.tex}` in `document.tex` entfernt (und die Datei gelöscht)
- [ ] `\input{99_example.tex}` in `presentation.tex` entfernt
- [ ] `\usepackage{lipsum}` in `customcommands.tex` entfernt, kein `\lipsum[...]` mehr im Text
- [ ] alle `\pfig`-Platzhalter durch echte Abbildungen ersetzt
- [ ] **ZENTRALE ANGABEN** vollständig ausgefüllt — Titel, Autor, Fakultät, Jahr
- [ ] Fakultätsfarbe gesetzt (in *beiden* Hauptdateien)
- [ ] Kapitelbilder für alle Kapitel vorhanden
- [ ] PDF-Metadaten geprüft (Dateieigenschaften: Titel und Autor korrekt?)
- [ ] Bibliografie durchgesehen — keine leeren Felder, keine Dubletten (JabRef hilft)
- [ ] Bildrechte geklärt für alles, was in `Pictures/` liegt
- [ ] `latexmk -C` und einmal komplett neu gebaut — läuft der Build von null durch?

---

## 🤝 Mitmachen

Diese Vorlage wird besser, je mehr Leute ihre Lösungen zurückgeben.
Verbesserungsvorschlag, Bugfix oder ein Kapitelbild-Set? Sehr willkommen.

1. Repo forken
2. Feature-Branch anlegen (`git checkout -b feature/tolle-idee`)
3. Änderungen committen (`git commit -m 'Tolle Idee ergänzt'`)
4. Branch pushen (`git push origin feature/tolle-idee`)
5. Pull Request eröffnen

Kleinere Sachen gerne direkt als
[Issue](https://github.com/PIX3LFLUX/HSK-Latex-Skript-Template/issues) mit dem
Label `enhancement`. Und wenn dir die Vorlage Arbeit erspart hat: ⭐ dalassen.

---

## 📜 Lizenz

Veröffentlicht unter **[CC BY-NC-SA 3.0](http://creativecommons.org/licenses/by-nc-sa/3.0/)**.
Details, Umfang und Hinweise zu Logo, Corporate Design und Bildmaterial stehen in
[`LICENSE`](LICENSE).

Kurz: Nutzen, verändern und weitergeben ist ausdrücklich erwünscht — mit
Namensnennung, nicht-kommerziell und unter denselben Bedingungen. Die
NC-Klausel stammt aus der Ursprungsvorlage und lässt sich nicht einseitig
entfernen.

---

## 🙏 Danksagung

* **[The Legrand Orange Book](http://www.latextemplates.com/template/the-legrand-orange-book)**
  — die Grundlage des Skript-Layouts.
  Mathias Legrand, mit Änderungen von Vel (`vel@latextemplates.com`),
  CC BY-NC-SA 3.0.
* **Hao Truong** (`haotruongnhat@gmail.com`) — Beamer-Präsentationsteil.
* **Abteilung Presse und Kommunikation der HKA** — Prüfung und Freigabe des
  Corporate Designs. Hintergrund:
  [Neues Corporate Design der HKA](https://www.h-ka.de/en/die-hochschule-karlsruhe/aktuelles/news/2021/new-corporate-design-of-hka)
* **[JabRef](https://www.jabref.org/)** — Literaturverwaltung, die direkt auf
  `.bib`-Dateien arbeitet.
* Allen, die per Issue und Pull Request beigetragen haben. 💚

<div align="center">
<br>
<sub>Viel Erfolg mit deinem Skript, deiner Arbeit, deinem Vortrag.</sub>
</div>
