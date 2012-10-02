#!/bin/sh

family=SourceSansPro
romanWeights=('Black' 'Bold' 'ExtraLight' 'Light' 'Regular' 'Semibold')
italicWeights=('BlackIt' 'BoldIt' 'ExtraLightIt' 'LightIt' 'It' 'SemiboldIt')

# clean existing build artifacts
rm -rf target/
mkdir target/
mkdir target/OTF/
mkdir target/TTF/

for w in ${romanWeights[@]};
do
  makeotf -f Roman/$w/font.pfa -r -o target/OTF/$family-$w.otf
  makeotf -f Roman/$w/font.ttf -gf GlyphOrderAndAliasDB_TT -r -o target/TTF/$family-$w.ttf
  rm Roman/$w/current.fpr # remove default options file from the source tree after building
done

for w in ${italicWeights[@]};
do
  makeotf -f Italic/$w/font.pfa -r -o target/OTF/$family-$w.otf
  makeotf -f Italic/$w/font.ttf -gf GlyphOrderAndAliasDB_TT -r -o target/TTF/$family-$w.ttf
  rm Italic/$w/current.fpr # remove default options file from the source tree after building
done

