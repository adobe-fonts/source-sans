# Makefile for Source Sans Pro font project directory

family=SourceSansPro
romanWeights=Black Bold ExtraLight Light Regular Semibold
italicWeights=BlackIt BoldIt ExtraLightIt LightIt It SemiboldIt

OTF_DIR=target/OTF
TTF_DIR=target/TTF

OTFs:=$(foreach w,$(romanWeights) $(italicWeights),$(OTF_DIR)/$(family)-$w.otf)
TTFs:=$(subst OTF,TTF,$(OTFs:.otf=.ttf))

instancesRoman:=$(foreach w,$(romanWeights),Roman/$w/font.ufo)
instancesItalic:=$(foreach w,$(italicWeights),Italic/$w/font.ufo)

all: $(OTFs) $(TTFs)

# Rule below derives the prerequisites of appropriate style from the given
# target's weight. Paths of targets themselves, though, are more tricky, thus
# there are two separate rules for the two target formats:

.SECONDEXPANSION:
$(OTFs): $(OTF_DIR)/$(family)-%.otf: \
	$(addprefix $$(if $$(findstring It,%),Italic,Roman)/,\
		%/font.ufo %/fontinfo \
		%/features %/markclasses.fea %/mark.fea %/mkmk.fea %/kern.fea \
		GlyphOrderAndAliasDB family.fea) \
	FontMenuNameDB tables.fea | $(OTF_DIR)
	makeotf -ga -f $< -o $@

.SECONDEXPANSION:
$(TTFs): $(TTF_DIR)/$(family)-%.ttf: \
	$(addprefix $$(if $$(findstring It,%),Italic,Roman)/,\
		%/font.ttf %/fontinfo \
		%/features %/markclasses.fea %/mark.fea %/mkmk.fea %/kern.fea \
		GlyphOrderAndAliasDB family.fea) \
	FontMenuNameDB tables.fea | $(TTF_DIR)
	makeotf -ga -f $< -o $@

$(OTF_DIR) $(TTF_DIR):
	mkdir -p $@

instances: $(instancesRoman) $(instancesItalic)

.SECONDEXPANSION:
$(instancesRoman) $(instancesItalic): %/font.ufo: \
	$$(addprefix $$(subst /,,$$(dir %))Masters/,\
		$(addprefix $(family)$$(if $$(findstring Italic,%),-Italic),\
			.designspace _0.ufo _1.ufo))
	makeInstancesUFO -d $<

clean:
	@rm -f $(addsuffix /current.fpr,\
		$(addprefix Roman/,$(romanWeights)) \
		$(addprefix Italic/,$(italicWeights)))
	@rm -f $(addsuffix /MutatorMath.log,RomanMasters ItalicMasters)

cleanall: clean
	@rm -rf $(OTF_DIR) $(TTF_DIR)

cleaninstances:
	@rm -rf $(instancesRoman) $(instancesItalic)

