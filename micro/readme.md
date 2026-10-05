# plymouth Theme mit Ladebalken
## benötigte Bibliotheken/Programme

```bash
apt install plymouth
```
**Hinweis**: Die tatsächliche Bootdauer kann je nach Hardware, angeschlossenen Geräten, Dateisystemen und gestarteten Diensten variieren. Der Wert ist daher nur ein Näherungswert.

Die Progress-Bar verwendet standardmäßig einen zeitgesteuerten Fortschritt. Die Dauer ist im Script über boot_duration_target festgelegt:

```bash
boot_duration_target = 8;
```

Dieser Wert sollte an die Dauer des eigenen Bootvorgangs angepasst werden. Dazu die Zeit vom Start des Plymouth-Splashscreens bis zum fertigen System messen und den gemessenen Wert hier eintragen. Auf schnellen Systemen kann ein geringerer Wert sinnvoll sein, auf langsameren Systemen ein höherer.

Der Wert stellt keinen echten prozentualen Bootfortschritt dar, sondern dient ausschließlich dazu, die Animation möglichst passend zur tatsächlichen Bootdauer laufen zu lassen.

Diese Dateien nach

/usr/share/plymouth/micro kopieren

```bash
micro
├── background.png
├── micro.plymouth
├── micro.script
├── progress-00.png
├── progress-01.png
├── progress-02.png
├── progress-03.png
├── progress-04.png
├── progress-05.png
├── progress-06.png
├── progress-07.png
├── progress-08.png
├── progress-09.png
├── progress-10.png
├── progress-11.png
├── progress-12.png
├── progress-13.png
├── progress-14.png
├── progress-15.png
├── progress-16.png
├── progress-17.png
├── progress-18.png
├── progress-19.png
├── progress-20.png
├── progress-21.png
├── progress-22.png
├── progress-23.png
├── progress-24.png
├── progress-25.png
├── progress-26.png
├── progress-27.png
├── progress-28.png
├── progress-29.png
├── progress-30.png
├── progress-31.png
└── progress-32.png
```

danach

```bash
sudo plymouth-set-default-theme micro
sudo update-initramfs -u
```

Fertig