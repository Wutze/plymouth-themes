# Themen für Plymouth

Ich veröffentliche meine eigene Sammlung von Plymouth Themes, die ich in Verwendung habe. Sie sind alle für eine Bildschirmauflösung in HD für 1920x1080px gebaut. 4K Monitore sollten dann auch hier vernünftig aussehen. Habe es - magels 4K Bildschirm - noch nicht getestet.

Der Start des Fortschrittsbalkens ist nicht dynamisch. Bevor man das Theme installiert, sollte der Bootvorgang einfach gestoppt werden. Denn diese Zeit sollte man dann im [name].script eintragen. Im Beispiel sind es 8 Sekunden. Dann passt der Bootvorgang mit dem Fortschrittsbalken so einigermaßen überein.

```bash
boot_duration_target = 8;
```

Zu jedem Thema existiert eine eigene readme.md. Diese informiert über eventuelle Besonderheiten oder Abweichungen.

Start:
```bash
git clone https://github.com/Wutze/plymouth-themes.git
```

Nach dem Download könnt ihr
```bash
setup.sh
```
starten.

Dort wählt ihr aus, welches Theme installiert werden soll. Einfach den Anweisungen der Ausgaben folgen, es sollte alles so weit automatisch funktionieren.

Viel Spaß

