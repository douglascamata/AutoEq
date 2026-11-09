# AutoEq
AutoEq is a tool for automatically equalizing headphones.

Go to **[autoeq.app](https://autoeq.app)** to get started.

This Github repository now mainly serves developers. The contributions of this project are:
* Web application for easily equalize and tweak headphone frequency responses without needing to install anything
* Library for working with (headphone) frequency responses and optimizing parametric equalizers
* [PyPi package](https://pypi.org/project/autoeq/) for installing the library on your projects
* Collection of headphone [measurements](./measurements) as numerical data from
[oratory1990](https://www.reddit.com/r/oratory1990/wiki/index/list_of_presets/),
[crinacle](https://crinacle.com),
[Innerfidelity](https://www.stereophile.com/content/innerfidelity-headphone-measurements),
[Rtings](https://www.rtings.com/headphones/1-5/graph) and legacy
headphone.com measurements (which are not the same as what the company produces today).
* Collection of different headphone frequency response [targets](./targets) as numerical data
* Pre-computed equalizer settings in [results](./results), although these should not be used by normal users since
**[autoeq.app](https://autoeq.app)** exists

![Sennheiser HD 800](./results/oratory1990/over-ear/Sennheiser%20HD%20800/Sennheiser%20HD%20800.png)

*Sennheiser HD 800 equalization results plotted*

### Updates
**2023-10-29** AutoEq version 4.0.0. Improved and unified naming conventions across the project. Cleaned up obsolete
files and reorganized directory structure. Completely reworked database management tools.

**2022-05-14** Web application. Reorganized measurements and results.

**2022-10-30** Restructured the project and published in PyPi. Source code moved under [autoeq](./autoeq) directory and 
command line usage changed from `python autoeq.py` to `python -m autoeq` with underscores `_` replaced with hyphens `-`
in the parameter names. 

**2022-09-18** Parametric eq optimizer reworked. The new optimizer supports shelf filters, has a powerful configuration
system, run 10x faster, has limits for Fc, Q and gain value ranges and treats +10 kHz range as average value instead of
trying to fix it precisely.

## Usage
AutoEq produces settings for basically all types of equalizer apps but does not do the equalization itself. You'll need
a different app for that. Go to **[autoeq.app](https://autoeq.app)** and select your equalizer app of choice. Quick
instructions for importing the produced settings will be shown there.

## Command Line Use
In addition to the web application, AutoEq can be used from command line (terminal). This is advanced use mainly
intended for developers. The following instructions apply for command line and Python interface use.

### Installing
AutoEq uses [mise](https://mise.jdx.dev) to manage tool versions (Python, [uv](https://docs.astral.sh/uv/) and Node.js)
and uv to manage Python dependencies.

- Download and install Git: https://git-scm.com/downloads. When installing Git on Windows, use Windows SSL verification
instead of Open SSL or you might run into problems when installing project dependencies.
- Install mise: https://mise.jdx.dev/getting-started.html and
[activate it in your shell](https://mise.jdx.dev/getting-started.html#activate-mise).
- You may need to install [libsndfile](http://www.mega-nerd.com/libsndfile/) if you're having problems with `soundfile`
when installing and/or running AutoEq.
- On Windows you may need to install
[Microsoft Visual C++ Redistributable for Visual Studio 2015, 2017, and 2019](https://support.microsoft.com/en-us/help/2977003/the-latest-supported-visual-c-downloads)
- Open a terminal / command prompt. On Windows, search `cmd` in the start menu.
- Clone AutoEq and go to its location. The full history is several gigabytes, mostly old versions of the generated
results, so a partial clone is recommended. It downloads the full commit history but only the file contents of the
checked out version (about 550 MB); older file versions are fetched on demand if you ever need them.
```shell
git clone --filter=blob:none https://github.com/jaakkopasanen/AutoEq.git
cd AutoEq
```
If you only work on the code, crawlers or measurements and don't need the `results` directory, a sparse checkout
brings the download down to about 50 MB:
```shell
git clone --filter=blob:none --sparse https://github.com/jaakkopasanen/AutoEq.git
cd AutoEq
git sparse-checkout set --no-cone '/*' '!/results/'
```
Run `git sparse-checkout disable` later to get the `results` directory.
- Trust the project's `mise.toml` and install Python, uv and Node.js
```shell
mise trust
mise install
```
- Install dependencies. This creates a virtual environment in `.venv` with AutoEq installed in editable mode, plus the
webapp and database tool dependencies. mise activates `.venv` automatically whenever you `cd` into the project.
```shell
mise run install
```
If you only need the library and command line tool, `uv sync --no-default-groups` is enough.
- Verify installation. If everything went well, you'll see the list of command line parameters AutoEq accepts.
```shell
python -m autoeq --help
```

```shell
python -m autoeq --input-file="measurements/oratory1990/data/over-ear/Sennheiser HD 800.csv" --output-dir="my_results" --target="targets/harman_over-ear_2018_wo_bass.csv" --max-gain=24 --parametric-eq --parametric-eq-config=4_PEAKING_WITH_LOW_SHELF,4_PEAKING_WITH_HIGH_SHELF --bass-boost=6 --convolution-eq --fs=48000 --bit-depth=32 --f-res=16
```

Without mise shell activation, prefix commands with `uv run`, e.g. `uv run python -m autoeq --help`.

List the available project tasks (tests, webapp, database tools, building) with
```shell
mise tasks
```

#### Updating
AutoEq is in active development and gets new measurements, results and features all the time. You can get the latest
version from git
```shell
git pull
```

Dependencies may change from time to time, you can update to the locked versions with
```shell
mise install
uv sync
```

#### Checking Installation
This prints out CLI parameters if installation was successful.
```shell
python -m autoeq --help
```

### Example
Equalizing Sennheiser HD 650 and saving results to `my_results/`:
```shell
python -m autoeq --input-file="measurements/oratory1990/data/over-ear/Sennheiser HD 650.csv" --output-dir="my_results" --target="targets/harman_over-ear_2018.csv" --convolution-eq --parametric-eq --ten-band-eq --fs=44100,48000
```

### Building
Add changelog entry before building and update version number in pyproject.toml!

Add updates to `autoeq/README.md` before building!

Build PyPi package. This temporarily swaps `README.md` for `autoeq/README.md` while building.
```shell
mise run build
```

publish
```shell
uv publish dist/autoeq-<VERSION>*
```

Remember to add Git tag!

## Contact
[Issues](https://github.com/jaakkopasanen/AutoEq/issues) are the way to go if you are experiencing problems or have
ideas or feature requests. Issues are not the correct channel for headphone requests because this project sources the
measurements from other databases and a headphone missing from AutoEq means it has not been measured by any of the
supported sources.

You can find me in [Reddit](https://www.reddit.com/user/jaakkopasanen),
[Audio Science Review](https://www.audiosciencereview.com/forum/index.php?members/jaakkopasanen.17838/) and
[Head-fi](https://www.head-fi.org/members/jaakkopasanen.491235/) if you just want to say hello.
