#!/usr/bin/env python3

from PIL import Image
from pathlib import Path

BASE = Path("/tmp/micro")
SOURCE = BASE / "boot-glas-progress2.png"
OUT = BASE / "micro-progress-frames"

OUT.mkdir(exist_ok=True)

src = Image.open(SOURCE).convert("RGBA")

width, height = src.size

# Sichtbarer Bereich des Progress-Balkens
for i in range(33):
    cut = round(width * i / 32)

    im = src.copy()
    pix = im.load()

    # Alles rechts vom aktuellen Fortschritt transparent machen.
    for y in range(height):
        for x in range(cut, width):
            r, g, b, a = pix[x, y]
            pix[x, y] = (r, g, b, 0)

    im.save(
        OUT / f"progress-{i:02d}.png",
        optimize=True
    )

print(f"Frames erzeugt: {len(list(OUT.glob('progress-*.png')))}")
print(f"Ausgabe: {OUT}")