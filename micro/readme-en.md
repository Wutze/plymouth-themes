# Plymouth theme with progress bar
## Required libraries/programmes

```bash
apt install plymouth
```
**Note**: The actual boot time may vary depending on the hardware, connected devices, file systems and services running. The value is therefore only an approximation.

By default, the progress bar uses time-based progression. The duration is set in the script via `boot_duration_target`:

```bash
boot_duration_target = 8;
```

This value should be adjusted to match the duration of your own boot process. To do this, measure the time from the start of the Plymouth splash screen until the system has fully booted, and enter the measured value here. On fast systems, a lower value may be appropriate, whilst on slower systems a higher value may be better.

This value does not represent the actual percentage of boot progress, but serves solely to ensure that the animation runs as closely as possible to the actual boot time.

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