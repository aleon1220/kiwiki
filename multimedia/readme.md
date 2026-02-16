[Kiwiki Home](/../../)

[Back to Main Page](./readme.md)

# Magick

[Image Magick](https://imagemagick.org/index.php)

```bash
Version: ImageMagick 7.1.2-13 Q16-HDRI x86_64 2fae24192:20260118 https://imagemagick.org
Copyright: (C) 1999 ImageMagick Studio LLC
License: https://imagemagick.org/license/
Features: Cipher DPC HDRI
Delegates (built-in): bzlib djvu fontconfig freetype heic jbig jng jp2 jpeg lcms lqr lzma openexr png raqm tiff webp x xml zlib
Compiler: clang (14.0.0)
```

### Image operations with ImageMagick

#### Resize-images with percentage value

```bash
magick source.jpg -resize 50%  destination.jpg
```
- older versions
`convert -resize 50% source.png dest.jpg`

#### Resize an image with a specific value

```bash
SIZE="1024X768"
convert -resize $SIZE source.png destination.jpg
```
[Back to top](#)

[Kiwiki Home](/../../)