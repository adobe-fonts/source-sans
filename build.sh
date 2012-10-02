#!/bin/sh

family=SourceSansPro
romanWeights=('Black' 'Bold' 'ExtraLight' 'Light' 'Regular' 'Semibold')
italicWeights=('BlackIt', 'BoldIt', 'ExtraLightIt', 'LightIt', 'It', 'SemiboldIt')

# clean existing build artifacts
rm -rf target/
mkdir target/

for w in ${romanWeights[@]};
do
  makeotf -sp target/$family-$w-otf.fpr -f Roman/$w/font.pfa -r -o target/$family-$w.otf
  makeotf -sp target/$family-$w-ttf.fpr -f Roman/$w/font.ttf -gf GlyphOrderAndAliasDB_TT -r -o target/$family-$w.ttf
  rm Roman/$w/current.fpr # remove default options file from the source tree after building
done

for w in ${italicWeights[@]};
do
  makeotf -sp target/$family-$w-otf.fpr -f Italic/$w/font.pfa -r -o target/$family-$w.otf
  makeotf -sp target/$family-$w-ttf.fpr -f Italic/$w/font.ttf -gf GlyphOrderAndAliasDB_TT -r -o target/$family-$w.ttf
  rm Italic/$w/current.fpr # remove default options file from the source tree after building
done

