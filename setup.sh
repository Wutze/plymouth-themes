#!/bin/bash

set -e

# ================================================================
# Konfiguration
# ================================================================

GIT_URL="http://gitlab1.home/micro/plymouth.git"

INSTALL_ROOT="/opt"
REPO_DIR="${INSTALL_ROOT}/plymouth-themes"

PLYMOUTH_DIR="/usr/share/plymouth/themes"
GRUB_CONFIG="/etc/default/grub"


# ================================================================
# Root prüfen / Root werden
# ================================================================

if [ "$(id -u)" -ne 0 ]; then
    echo "Root-Rechte werden benötigt."
    sudo -v
    exec sudo "$0" "$@"
fi


# ================================================================
# Benötigte Programme prüfen
# ================================================================

for cmd in git whiptail plymouth-set-default-theme update-initramfs; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "Fehlendes Programm: $cmd"
        exit 1
    fi
done


# ================================================================
# Repository holen
# ================================================================

echo
echo "=========================================="
echo " Plymouth Themes herunterladen"
echo "=========================================="
echo

if [ -d "$REPO_DIR/.git" ]; then
    echo "Repository existiert bereits:"
    echo "  $REPO_DIR"
    echo
    echo "Aktualisiere Repository..."
    git -C "$REPO_DIR" pull
else
    echo "Repository wird nach $REPO_DIR geklont..."
    rm -rf "$REPO_DIR"
    git clone "$GIT_URL" "$REPO_DIR"
fi


# ================================================================
# Themes im Repository finden
# ================================================================

themes=()

while IFS= read -r -d '' dir; do
    theme_name="$(basename "$dir")"

    # Ein Theme muss mindestens eine .plymouth-Datei enthalten
    if find "$dir" -maxdepth 1 -type f -name "*.plymouth" \
        | grep -q .; then

        themes+=("$theme_name")
    fi

done < <(find "$REPO_DIR" -mindepth 1 -maxdepth 1 -type d -print0)


# ================================================================
# Prüfen, ob Themes gefunden wurden
# ================================================================

if [ "${#themes[@]}" -eq 0 ]; then
    whiptail \
        --title "Plymouth Themes" \
        --msgbox \
        "Im Repository wurden keine Plymouth Themes gefunden." \
        10 60

    exit 1
fi


# ================================================================
# Theme-Auswahl
# ================================================================

checklist_items=()

for theme in "${themes[@]}"; do

    if [ -d "$PLYMOUTH_DIR/$theme" ]; then
        status="ON"
        description="bereits installiert"
    else
        status="OFF"
        description="installieren"
    fi

    checklist_items+=(
        "$theme"
        "$description"
        "$status"
    )
done


selected_themes=$(
    whiptail \
        --title "Plymouth Themes installieren" \
        --checklist \
        "Welche Themes sollen installiert werden?" \
        20 70 10 \
        "${checklist_items[@]}" \
        --separate-output \
        3>&1 1>&2 2>&3
) || exit 0


# ================================================================
# Ausgewählte Themes installieren
# ================================================================

if [ -n "$selected_themes" ]; then

    while IFS= read -r theme; do

        [ -z "$theme" ] && continue

        source_dir="$REPO_DIR/$theme"
        target_dir="$PLYMOUTH_DIR/$theme"

        echo
        echo "Installiere Theme: $theme"

        mkdir -p "$target_dir"

        # Inhalt des Theme-Verzeichnisses kopieren
        cp -a "$source_dir/." "$target_dir/"

        echo "  -> $target_dir"

    done <<< "$selected_themes"

else

    whiptail \
        --title "Plymouth Themes" \
        --msgbox \
        "Es wurde kein Theme zur Installation ausgewählt." \
        10 60

    exit 0
fi


# ================================================================
# Theme auswählen, das aktiviert werden soll
# ================================================================

theme_items=()

while IFS= read -r -d '' dir; do

    theme_name="$(basename "$dir")"

    # Nur gültige Plymouth Themes anbieten
    if find "$dir" -maxdepth 1 -type f -name "*.plymouth" \
        | grep -q .; then

        theme_items+=(
            "$theme_name"
            "Theme aktivieren"
            "OFF"
        )

    fi

done < <(find "$PLYMOUTH_DIR" -mindepth 1 -maxdepth 1 -type d -print0)


selected_theme=$(
    whiptail \
        --title "Plymouth Theme aktivieren" \
        --radiolist \
        "Welches Theme soll verwendet werden?" \
        20 70 10 \
        "${theme_items[@]}" \
        3>&1 1>&2 2>&3
) || exit 0


# ================================================================
# Theme aktivieren
# ================================================================

if [ -z "$selected_theme" ]; then
    echo "Kein Theme ausgewählt."
    exit 1
fi

echo
echo "Aktiviere Plymouth Theme: $selected_theme"

plymouth-set-default-theme "$selected_theme"


# ================================================================
# GRUB_CMDLINE_LINUX_DEFAULT anpassen
# ================================================================

echo
echo "Prüfe GRUB-Konfiguration..."

if [ ! -f "$GRUB_CONFIG" ]; then
    echo "Fehler: $GRUB_CONFIG nicht gefunden."
    exit 1
fi


python3 <<'PY'
from pathlib import Path
import re

path = Path("/etc/default/grub")
text = path.read_text()

pattern = re.compile(
    r'^(GRUB_CMDLINE_LINUX_DEFAULT\s*=\s*)"([^"]*)"(.*)$',
    re.MULTILINE
)

match = pattern.search(text)

if not match:
    raise SystemExit(
        "GRUB_CMDLINE_LINUX_DEFAULT wurde in /etc/default/grub nicht gefunden."
    )

prefix = match.group(1)
value = match.group(2)
suffix = match.group(3)

# Nur hinzufügen, wenn splash noch nicht vorhanden ist.
options = value.split()

if "splash" not in options:
    options.append("splash")
    new_value = " ".join(options)

    replacement = prefix + '"' + new_value + '"' + suffix
    text = text[:match.start()] + replacement + text[match.end():]

    path.write_text(text)

    print("  splash wurde zu GRUB_CMDLINE_LINUX_DEFAULT hinzugefügt.")
else:
    print("  splash ist bereits vorhanden.")
PY


# ================================================================
# GRUB aktualisieren
# ================================================================

echo
echo "Aktualisiere GRUB..."

update-grub


# ================================================================
# Initramfs aktualisieren
# ================================================================

echo
echo "Aktualisiere Initramfs..."

update-initramfs -u


# ================================================================
# Fertig
# ================================================================

echo
echo "=========================================="
echo " Installation abgeschlossen"
echo "=========================================="
echo
echo "Installierte/ausgewählte Themes:"
echo "$selected_themes"
echo
echo "Aktives Theme:"
echo "  $selected_theme"
echo
echo "Plymouth-Konfiguration:"
plymouth-set-default-theme
echo
echo "Fertig."
