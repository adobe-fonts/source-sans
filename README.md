# Source Sans Pro

Source Sans Pro is a set of OpenType fonts that have been designed to work well
in user interface (UI) environments. In addition to a functional OpenType font, this open
source project provides all of the source files that were used to build this OpenType font
by using the AFDKO makeotf tool.

## Download the fonts (OTF, TTF, WOFF, WOFF2, EOT)

* [Latest release](../../releases/latest)
* [All releases](../../releases)

## Font installation instructions

* [macOS](http://support.apple.com/kb/HT2509)
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
[Adobe Font Development Kit for OpenType](http://www.adobe.com/devnet/opentype/afdko.html) (AFDKO). The AFDKO
tools are widely used for font development today, and are part of most font
editor applications.

### Building one font

The key to building OTF or TTF fonts is `makeotf`, which is part of the AFDKO toolset.
Information and usage instructions can be found by executing `makeotf -h`.

In this repository, all necessary files are in place for building the OTF and TTF fonts.
For example, build a binary OTF font for the Regular style like this:

```sh
$ cd Roman/Regular/
$ makeotf -r
```

### Building all fonts

For convenience, a shell script named **build** is provided in the root directory.
It builds all OTFs and TTFs, and can be executed by typing:

```sh
$ ./build.sh
```

or this on Windows:

```sh
> build.cmd
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

Note also that font.ttf instances stored in the repository are not generated
entirely automatically. These TrueType versions of the instances are produced in
a process that depends on manual workflow [described in detail by Frank
Grießhammer](https://github.com/adobe-type-tools/fontlab-scripts/tree/master/TrueType).
Because of that, `make` will build the target TTFs only if it finds those files already
in place.

## Getting Involved

Send suggestions for changes to the Source Sans OpenType font project maintainer, [Paul D. Hunt](mailto:opensourcefonts@adobe.com?subject=[GitHub] Source Sans Pro), for consideration.

## Further information

For information about the design and background of Source Sans, please refer to the [official font readme file](http://www.adobe.com/products/type/font-information/Source-Sans-Pro-Readme-file.html).

