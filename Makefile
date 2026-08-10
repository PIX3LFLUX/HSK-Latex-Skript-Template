# ------------------------------------------------------------------------------
# Variablen
# ------------------------------------------------------------------------------

# Input-Dateien (Pfad korrigiert basierend auf deiner Struktur)
INPUT_DOC          = Document/document.tex
INPUT_PRESENTATION = Presentation/presentation.tex

# Output-Dateien (Hier landen die PDFs)
OUTPUT_DOC          = Document/document.pdf
OUTPUT_PRESENTATION = Presentation/presentation.pdf

# Befehl zum generieren der PDFs
# .auxiliary Verzeichnis für Hilfsdateien (Vermeidet Chaos im Hauptordner)
BUILD_CMD = latexmk -pdf -auxdir=.auxiliary -cd

# Befehl zum Aufräumen
CLEAN_CMD = $(BUILD_CMD) -C

# ------------------------------------------------------------------------------
# Targets
# ------------------------------------------------------------------------------

# Standard-Ziel: Kompiliert beides
all: document presentation

# Kompilierung des Hauptdokuments
document: $(OUTPUT_DOC)

# Kompilierung der Präsentation
presentation: $(OUTPUT_PRESENTATION)

# Erstellung des PDFs für das Hauptdokument
$(OUTPUT_DOC): $(INPUT_DOC)
	@echo "--- Kompilierung Dokument: $(INPUT_DOC) ---"
	$(BUILD_CMD) $(INPUT_DOC) 

# Erstellung des PDFs für die Präsentation
$(OUTPUT_PRESENTATION): $(INPUT_PRESENTATION)
	@echo "--- Kompilierung Präsentation: $(INPUT_PRESENTATION) ---"
	$(BUILD_CMD) $(INPUT_PRESENTATION)

# Aufräumen: Löscht auxiliary Datein und generierte PDFs
clean:
	@echo "--- Aufräumen ---"
	$(CLEAN_CMD) $(INPUT_DOC)
	$(CLEAN_CMD) $(INPUT_PRESENTATION)

# Markiert die Targets als "nicht als Datei vorhanden"
.PHONY: all document presentation clean
