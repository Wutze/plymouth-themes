
# Themes for Plymouth

[🇩🇪 Deutsch](readme.md) | [🇬🇧 English](readme-en.md)

I’m publishing my own collection of Plymouth themes that I’m currently using. They’re all designed for a 1920x1080px HD screen resolution. They should also look reasonable on 4K monitors. I haven’t tested them yet, as I don’t have a 4K screen.


The start of the progress bar is not dynamic. Before installing the theme, you should simply pause the boot process. This is because you’ll need to enter this time in [name].script. In the example, it’s 8 seconds. Then the boot process will more or less match the progress bar.

```bash
boot_duration_target = 8;
```
There is a separate readme.md file for each topic. This provides information on any specific features or deviations.

## Installation:

Simply run the following:
```bash
curl -fsSL https://raw.githubusercontent.com/Wutze/plymouth-themes/main/setup.sh | bash
```

The setup should then start automatically. The theme will be copied to /opt/plynouth-themes/.

Once the setup is running – which requires root privileges – select which theme from the download you wish to install. Simply follow the on-screen instructions; everything should work automatically at this stage.

Enjoy!

## Do-it-yourself

For those who wish to customise their own graphics, I have placed the file “progress-glas.xcf” in the ```/micro/``` directory. This is a GIMP file. The “make-progress.py” script then splits the progress bar into the desired sections and saves them accordingly.

__A quick note:__ Any change to the files or settings, however small, always requires the following command:

```bash
update-initramfs -u
```

Otherwise, the changes will not be applied.

And one more thing. Be careful with the image sizes. If you make it larger than the original shown here, the progress bar may no longer appear within the visible area of the monitor. The script will still work in the end, but you’ll be searching high and low because there’s no progress bar to be seen. ;o)
