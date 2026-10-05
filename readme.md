# Themen für Plymouth

[🇩🇪 Deutsch](readme.md) | [🇬🇧 English](readme-en.md)

Ich veröffentliche meine eigene Sammlung von Plymouth Themes, die ich in Verwendung habe. Sie sind alle für eine Bildschirmauflösung in HD für 1920x1080px gebaut. 4K Monitore sollten dann auch hier vernünftig aussehen. Ich habe es - magels 4K Bildschirm - noch nicht getestet.

Der Start des Fortschrittsbalkens ist nicht dynamisch. Bevor man das Theme installiert, sollte der Bootvorgang einfach gestoppt werden. Denn diese Zeit sollte man dann im [name].script eintragen. Im Beispiel sind es 8 Sekunden. Dann passt der Bootvorgang mit dem Fortschrittsbalken so einigermaßen überein.

```bash
boot_duration_target = 8;
```

Zu jedem Thema existiert eine eigene readme.md. Diese informiert über eventuelle Besonderheiten oder Abweichungen.

## Installation:

Einfach ausführen von:
```bash
curl -fsSL https://raw.githubusercontent.com/Wutze/plymouth-themes/main/setup.sh | bash
```

Das Setup sollte dann automatisch starten. Das Theme mird nach /opt/plymouth-themes/ kopiert.

Wenn das Setup läuft, wozu root Rechte benötigt werden, wählt ihr aus, welches Theme aus dem Download ihr installiern wollt. Einfach den Anweisungen der Ausgaben folgen, es sollte alles so weit automatisch funktionieren.

Viel Spaß

```bash
## für mein internes git
curl -fsSL http://gitlab1.home/micro/plymouth-themes/-/raw/main/setup.sh | bash
```

## Selbstbau

Wer selbst seine Grafiken verändern möchte, dem habe ich unter ```/micro/``` die Datei "progress-glas.xcf" hinterlassen. Es handelt sich hierbei im eine Datei für GIMP. Die Datei "make-progress.py" zerschneidet dann die Progressbar in die jeweils gewünschten Teile und speichert diese entsprechend ab.

__Kleiner Hinweis:__ Jede noch so kleine Veränderung an den Dateien oder Einstellungen, bedarf immer ein:

```bash
update-initramfs -u
```

Es werden sonst keine Veränderungen übernommen.

Und noch ein Hinweis. Aufpassen mit den Bildgrößen. Es kann, so ihr größer als das hier dargestellte Orgiginal werdet, das Ladebalken nicht mehr im sichtbaren Bereich des Monitors erscheint. Am Ende funktioniert das Script zwar, aber man sucht sich dumm und dämlich, weil eben kein Ladebalken zu sehen ist. ;o)
