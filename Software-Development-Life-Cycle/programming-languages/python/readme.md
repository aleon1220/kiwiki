[Kiwiki Home](/../../)
[Back to Main Page](./readme.md)

# Python Language
[PEP 8 -- Style Guide for Python Code](https://www.python.org/dev/peps/pep-0008/)

[Kiwiki Home](/../../)

#### Check OS versions
``` bash
apt list --installed | grep python*
```

#### Find what is at `/usr/bin`
``` bash
ls -lha /usr/bin/python*
```

#### Set the `update-alternatives` command for python
``` bash
PYTHON_EXECUTABLE="python3"
PYTHON_EXECUTABLE_PATH="/usr/bin/python3.8"
PRIORITY="2"

sudo update-alternatives --install /usr/bin/python3 $PYTHON_EXECUTABLE $PYTHON_EXECUTABLE_PATH $PRIORITY

sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python2.7 2
```
## Python system settings
#### path installed packages
```bash
python -m site --user-site
```
#### list all user packages
```bash
ls $HOME/.local/lib/python3.10/site-packages
```
#### command to get path dist-packages
```
python3 -c 'import sysconfig; print(sysconfig.get_paths()["purelib"])'
```

## pip
pip installs packages

```bash
pip list --outdated
```

```bash
pip list --user
```
#### upgrade given package
```bash
pip install $PACKAGE_NAME --upgrade
```
---

[Back to top](#)

[Kiwiki Home](/../../)