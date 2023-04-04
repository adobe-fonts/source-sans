# Source Sans Pro

[Source Sans Pro](http://adobe-fonts.github.io/source-sans/)
is a set of OpenType fonts that have been designed to work well
in user interface (UI) environments.

## Getting involved

[Open an issue](https://github.com/adobe-fonts/source-sans/issues) or send a suggestion to Source Sans' designer [Paul D. Hunt](mailto:opensourcefonts@adobe.com?subject=[GitHub]%20Source%20Sans%20Pro), for consideration.

## Releases

* [Latest release](../../releases/latest)
* [All releases](../../releases)

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
$ cd Upright/Instances/Regular/
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

To build the variable TTFs you must install **fontmake** using this command:

```sh
$ pip install fontmake
```

A shell script named **buildVFs.sh** is provided in the root directory.
It generates four variable fonts (two CFF2-OTFs and two TTFs), and can be executed by typing:

```sh
$ ./buildVFs.sh
```

### Building with `make`

If you want to build directly from poles instead of the instances stored in
the repository, or to avoid building all files repetitively, run:

```sh
$ make
```

and it will get everything up to date. To generate only the font.ufo instances
from the poles, run:

```sh
$ make instances
```

_Note: because font.ufo instances are stored in the repository, you may have to
delete them first from your working tree before building from poles; see
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
