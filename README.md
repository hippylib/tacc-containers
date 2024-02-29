# FEniCS TACC Docker image (Python 3.12.2)

This image is available on DockerHub: [mvapich compiler](https://hub.docker.com/repository/docker/mathewgaohu/fenics-2019.1-tacc-mvapich2.3-ib/general)

I modify the Dockerfile from [FEniCS TACC Docker image](https://github.com/mathewgaohu/tacc-containers/tree/main), choosing package versions compatiable with Python 3.12.

For more information about how to build/test, please head to the upsteam repository [FEniCS TACC Docker image](https://github.com/mathewgaohu/tacc-containers/tree/main)

Packages and verions (Python 3.12.2):

```
Package                   Version
------------------------- ---------------
anyio                     4.3.0
argon2-cffi               23.1.0
argon2-cffi-bindings      21.2.0
arrow                     1.3.0
asttokens                 2.4.1
async-lru                 2.0.4
attrs                     23.2.0
Babel                     2.14.0
beautifulsoup4            4.12.3
bleach                    6.1.0
certifi                   2024.2.2
cffi                      1.16.0
charset-normalizer        3.3.2
comm                      0.2.1
contourpy                 1.2.0
cycler                    0.12.1
debugpy                   1.8.1
decorator                 5.1.1
defusedxml                0.7.1
executing                 2.0.1
fastjsonschema            2.19.1
fenics-dijitso            2019.2.0.dev0
fenics-dolfin             2019.2.0.dev0
fenics-ffc                2019.2.0.dev0
fenics-fiat               2019.2.0.dev0
fenics-ufl-legacy         2022.3.0
fonttools                 4.49.0
fqdn                      1.5.1
h11                       0.14.0
httpcore                  1.0.4
httpx                     0.27.0
idna                      3.6
ipykernel                 6.29.2
ipython                   8.22.1
ipywidgets                8.1.2
isoduration               20.11.0
jedi                      0.19.1
Jinja2                    3.1.3
json5                     0.9.17
jsonpointer               2.4
jsonschema                4.21.1
jsonschema-specifications 2023.12.1
jupyter                   1.0.0
jupyter_client            8.6.0
jupyter-console           6.6.3
jupyter_core              5.7.1
jupyter-events            0.9.0
jupyter-lsp               2.2.2
jupyter_server            2.12.5
jupyter_server_terminals  0.5.2
jupyterlab                4.1.2
jupyterlab_pygments       0.3.0
jupyterlab_server         2.25.3
jupyterlab_widgets        3.0.10
kiwisolver                1.4.5
MarkupSafe                2.1.5
matplotlib                3.8.3
matplotlib-inline         0.1.6
mistune                   3.0.2
mpi4py                    3.1.5
mpmath                    1.3.0
mshr                      2019.1.0
nbclient                  0.9.0
nbconvert                 7.16.1
nbformat                  5.9.2
nest-asyncio              1.6.0
notebook                  7.1.0
notebook_shim             0.2.4
numpy                     1.26.4
overrides                 7.7.0
packaging                 23.2
pandocfilters             1.5.1
parso                     0.8.3
petsc4py                  3.20.2
pexpect                   4.9.0
pillow                    10.2.0
pip                       24.0
pkgconfig                 1.5.5
platformdirs              4.2.0
prometheus_client         0.20.0
prompt-toolkit            3.0.43
psutil                    5.9.8
ptyprocess                0.7.0
pure-eval                 0.2.2
pybind11                  2.11.1
pycparser                 2.21
Pygments                  2.17.2
pyparsing                 3.1.1
python-dateutil           2.8.2
python-json-logger        2.0.7
PyYAML                    6.0.1
pyzmq                     25.1.2
qtconsole                 5.5.1
QtPy                      2.4.1
referencing               0.33.0
requests                  2.31.0
rfc3339-validator         0.1.4
rfc3986-validator         0.1.1
rpds-py                   0.18.0
scipy                     1.12.0
Send2Trash                1.8.2
setuptools                69.1.1
six                       1.16.0
slepc4py                  3.20.1
sniffio                   1.3.1
soupsieve                 2.5
stack-data                0.6.3
sympy                     1.12
terminado                 0.18.0
tinycss2                  1.2.1
tornado                   6.4
tqdm                      4.66.2
traitlets                 5.14.1
types-python-dateutil     2.8.19.20240106
uri-template              1.3.0
urllib3                   2.2.1
wcwidth                   0.2.13
webcolors                 1.13
webencodings              0.5.1
websocket-client          1.7.0
wheel                     0.42.0
widgetsnbextension        4.0.10
```