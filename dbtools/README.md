# DB Tools
This folder contains tools to crawl measurements from the supported databases, to process them, create results and
indexes of results.

The notebook `db.ipynb` should have everything you need and the instructions on running stuff

```shell
mise run dbtools
```

Dependencies are installed with `mise run install` from the repository root. The Oratory1990 crawler also needs the
Ghostscript library installed on the system, e.g. `brew install ghostscript` on macOS or `sudo apt install ghostscript`
on Ubuntu.
