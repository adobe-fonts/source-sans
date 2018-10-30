# Source Sans Pro

Source Sans Pro is a set of OpenType fonts that have been designed to work well
in user interface (UI) environments.

## Download the fonts (OTF, TTF, WOFF, WOFF2)

* [Latest release](../../releases/latest)
* [All releases](../../releases)

## Font installation instructions

* [macOS](https://support.apple.com/en-us/HT201749)
* [Windows](https://www.microsoft.com/en-us/Typography/TrueTypeInstall.aspx)
* [Linux/Unix-based systems](https://github.com/adobe-fonts/source-code-pro/issues/17#issuecomment-8967116)
* Bower<br/>
	`bower install git://github.com/adobe-fonts/source-sans-pro.git#release`
* npm v2.x<br/>
	`npm install --fetch-only git://github.com/adobe-fonts/source-sans-pro.git#release`
* npm v3.x<br/>
	`npm install git://github.com/adobe-fonts/source-sans-pro.git#release`

## Building the fonts from source

### Requirements

To build the binary font files from source, you need to have installed the
[Adobe Font Development Kit for OpenType](https://github.com/adobe-type-tools/afdko/) (AFDKO).

### Building one font

The key to building the OTF fonts is `makeotf`, which is part of the AFDKO toolset.
Information and usage instructions can be found by executing `makeotf -h`. The TTFs
are generated with the `otf2ttf` and `ttfcomponentizer` tools.

Commands to build the Regular style OTF font:

```sh
$ cd Roman/Instances/Regular/
$ makeotf -r -gs -omitMacNames
```

Commands to generate the Regular style TTF font:

```sh
$ otf2ttf SourceSansPro-Regular.otf
$ ttfcomponentizer SourceSansPro-Regular.ttf
```

### Building all non-variable fonts

For convenience, a shell script named **build.sh** is provided in the root directory.
It builds all OTFs and TTFs, and can be executed by typing:

```sh
$ ./build.sh
```

or this on Windows:

```sh
> build.cmd
```

### Building the variable fonts

To build the variable TTFs you must install Adobe's **fontmake** fork using this command:

```sh
$ pip install git+https://github.com/adobe-type-tools/fontmake
```

A shell script named **buildVFs.sh** is provided in the root directory.
It generates four variable fonts (two CFF2-OTFs and two TTFs), and can be executed by typing:

```sh
$ ./buildVFs.sh
```

### Building with `make`

If you want to build directly from masters instead of the instances stored in
the repository, or to avoid building all files repetitively, run:

```sh
$ make
```

and it will get everything up to date. To generate only the font.ufo instances
from the masters, run:

```sh
$ make instances
```

_Note: because font.ufo instances are stored in the repository, you may have to
delete them first from your working tree before building from masters; see
below._

To clean up `makeotf`'s defaults and other log files, run:

```sh
$ make clean
```

or to remove all build artefacts, including target font binaries:

```sh
$ make cleanall
```

Because font.ufo instances are committed into the repository, they are not
removed on `make clean`. If that is necessary, run:

```sh
$ make cleaninstances
```

## Getting Involved

Send suggestions for changes to the Source Sans OpenType font project maintainer, [Paul D. Hunt](mailto:opensourcefonts@adobe.com?subject=[GitHub]%20Source%20Sans%20Pro), for consideration.
