# Python Language
[PEP 8 -- Style Guide for Python Code](https://www.python.org/dev/peps/pep-0008/)
#### Check python versions in the system
``` bash
sudo apt list --installed | grep python*
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

sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python2.7 3
```
