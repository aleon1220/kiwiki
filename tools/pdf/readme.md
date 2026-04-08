# PDF Operations Tools

### PDF tool kit pdftk
[pdftk page](https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/)

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

#### Find string *InfoValue* in the metadata of a pdf

```bash
pdftk in_pdf_file.pdf dump_data_utf8 | grep InfoValue:
```

#### Extract a range of pages from a PDF file

```bash
pdftk source.pdf cat 5-10 output extracted-output_pages5-10.pdf verbose
```

#### Split specific pages from source file 3 pages
for example page 5, page 6, and page 10

```bash
pdftk source.pdf cat 5 6 10 output split-output.pdf verbose
```

#### Join PDFs

```bash
pdftk file01.pdf file02.pdf cat output out.pdf verbose
```

#### rotate PDF 90° clockwise or **east**

```bash
pdftk in.pdf cat 1-endeast output out.pdf verbose
```

##### Success rotation

```bash
Command Line Data is valid.

Input PDF Filenames & Passwords in Order
( <filename>[, <password>] )
   in.pdf

The operation to be performed:
   cat - Catenate given page ranges into a new PDF.

The output file will be named:
   out.pdf

Output PDF encryption settings:
   Output PDF will not be encrypted.

No compression or uncompression being performed on output.

Creating Output ...
   Adding page 1 XEASTX  from in.pdf
   Adding page 2 XEASTX  from in.pdf
```
