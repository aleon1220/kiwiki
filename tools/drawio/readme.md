# Draw.io (diagrams.net)

CLI operations for exporting and managing diagrams.

* check version

```bash
drawio --version
```

* recursively export all diagrams in a directory to PNG

```bash
drawio --export --format png --recursive docs/diagrams/
```

* export a single `.drawio` file to PNG

```bash
drawio -x -f png --output devops-continuous-delivery-framework.png devops-continuous-delivery-framework.drawio
```

* export a diagram to PNG with custom scaling

```bash
drawio -x -f png --scale 2.5 -o devops-loop.png devops-loop.drawio
```

* export a specific `.drawio` diagram to an output PNG file

```bash
drawio -x -f png --output tooling-map.png tooling-map.drawio
```

* recursively export diagrams to SVG with verbose Electron logging enabled

```bash
ELECTRON_ENABLE_LOGGING=1 drawio --export --format svg --recursive --output docs/diagrams/imgs/svgs/ ./docs/diagrams/
```

