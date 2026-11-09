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

## Avoiding churn in results
`update_results()` in the notebook uses `skip_unchanged=True`, so regenerating a database only rewrites the results
whose measurement, target or settings actually changed. The optimizers produce slightly different filters on different
machines and library versions, so regenerating everything would otherwise rewrite thousands of files (and add hundreds
of megabytes to the git history) without any meaningful change. When a change in AutoEq's processing should update all
results, bump `RESULTS_VERSION` in `autoeq/constants.py`.
