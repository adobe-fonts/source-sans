#!/usr/bin/make
# -*- indent-tabs-mode: t; -*-
# by Al Nikolov <root@toor.fi.eu.org>

dnames = $(wildcard $(addsuffix /Instances/*,Roman Italic))
fnames = $(addsuffix .otf,$(addprefix /SourceSans3-,$(notdir $(dnames))))
wholenames = $(join $(dnames),$(fnames))
out_pat = -name \*.[ot]tf

all: $(wholenames)

clean:
	find $(out_pat) | xargs ${RM}

.PHONY: all clean

.SECONDEXPANSION:
%.otf: $$(shell find $$(@D) ! $(out_pat))
	cd $(@D) && makeotf -r -gs -omitMacNames
