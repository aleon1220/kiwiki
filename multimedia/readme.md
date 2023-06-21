## [Image Magick](https://imagemagick.org/index.php)

### Image operations with ImageMagick

#### Resize-images with percentage value

```bash
# percentage
convert -resize 50% source.png dest.jpg
```

#### Resize an image with a specific value

```bash
SIZE="1024X768"
convert -resize $SIZE source.png destination.jpg
```