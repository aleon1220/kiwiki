# Python Language

[PEP 8 -- Style Guide for Python Code](https://www.python.org/dev/peps/pep-0008/)

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
```bash
python3 -c 'import sysconfig; print(sysconfig.get_paths()["purelib"])'
```

## Upgrading Python 
> tested on Ubuntu WSL

- Update your package list
```bash
sudo apt update && sudo apt upgrade -y
```
- Install the required prerequisite packages
```bash
sudo apt install software-properties-common --yes
```

- Add repository deadsnakes PPA.
This repository is the standard and most reliable way to get newer Python releases that aren't yet in Ubuntu's default repositories.
```bash
sudo add-apt-repository ppa:deadsnakes/ppa -y
```
- Update your package list
```bash
sudo apt update
```

- Install the new Python version:
```bash
sudo apt install python3.14 -y
```
- Verify the installation:
```bash
python3.14 --version
```
- set the default `python3` command to point to this newly installed version
```bash
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.14 1
```

# python package managers
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

## uv
I learned about https://docs.astral.sh/uv/ 
written in Rust might be nice to take a look at that.
---


[Back to top](#)

[Kiwiki Home](/../../)
