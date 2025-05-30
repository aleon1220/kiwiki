[Kiwiki Home](/../../)
[Back to Main Page](./readme.md)

## PDF Operations Tools

### PDF tool kit

##### Recursively find inside PDFs

```bash
find . -iname '*.pdf' -exec pdfgrep "PDF text content to find " {} +
```

#### Using `pdfgrep`

```bash
pdfgrep -r "PDF text content to find"
```

#### Get info about the pdf toolkit

```bash
info pdftk
```

#### Find string *InfoValue* in the metadata of `PDF_FILE`

```bash
PDF_FILE="a_pdf_file.pdf"
pdftk $PDF_FILE.pdf dump_data_utf8 | grep InfoValue:
```

#### Extract a range of pages from a PDF file

```bash
pdftk source.pdf cat 5-10 output ExtractedOutput_p5-10.pdf
```

#### Split specific pages from source file 3 pages
for example page 5, page 6, and page 10

```bash
pdftk source.pdf cat 5 6 10 output SplittedOutput.pdf
```

#### Join PDFs unify in out1.pdf
```bash
pdftk in1.pdf in2.pdf cat output out1.pdf verbose
```

[Back to top](#)

[Kiwiki Home](/../../)