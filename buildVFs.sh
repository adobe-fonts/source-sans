#!/bin/env sh

rom=Roman/Masters
itm=Italic/Masters

# build variable OTFs
buildMasterOTFs $rom/SourceSansVariable-Roman.designspace
buildCFF2VF $rom/SourceSansVariable-Roman.designspace
buildMasterOTFs $itm/SourceSansVariable-Italic.designspace
buildCFF2VF $itm/SourceSansVariable-Italic.designspace

# extract and subroutinize the CFF2 table
tx -cff2 +S +b -std $rom/SourceSansVariable-Roman.otf $rom/.tb_cff2
tx -cff2 +S +b -std $itm/SourceSansVariable-Italic.otf $itm/.tb_cff2

# replace CFF2 table with subroutinized version
sfntedit -a CFF2=$rom/.tb_cff2 $rom/SourceSansVariable-Roman.otf
sfntedit -a CFF2=$itm/.tb_cff2 $itm/SourceSansVariable-Italic.otf

# build variable TTFs
fontmake -m $rom/SourceSansVariable-Roman.designspace -o variable --production-names
fontmake -m $itm/SourceSansVariable-Italic.designspace -o variable --production-names

# use DSIG, name, OS/2, hhea, and STAT tables from OTFs
sfntedit -x DSIG=$rom/.tb_DSIG,name=$rom/.tb_name,OS/2=$rom/.tb_os2,hhea=$rom/.tb_hhea,STAT=$rom/.tb_STAT $rom/SourceSansVariable-Roman.otf
sfntedit -a DSIG=$rom/.tb_DSIG,name=$rom/.tb_name,OS/2=$rom/.tb_os2,hhea=$rom/.tb_hhea,STAT=$rom/.tb_STAT $rom/SourceSansVariable-Roman.ttf
sfntedit -x DSIG=$itm/.tb_DSIG,name=$itm/.tb_name,OS/2=$itm/.tb_os2,hhea=$itm/.tb_hhea,STAT=$itm/.tb_STAT $itm/SourceSansVariable-Italic.otf
sfntedit -a DSIG=$itm/.tb_DSIG,name=$itm/.tb_name,OS/2=$itm/.tb_os2,hhea=$itm/.tb_hhea,STAT=$itm/.tb_STAT $itm/SourceSansVariable-Italic.ttf

# use cmap, GDEF, GPOS, and GSUB tables from TTFs
sfntedit -x cmap=$rom/.tb_cmap,GDEF=$rom/.tb_GDEF,GPOS=$rom/.tb_GPOS,GSUB=$rom/.tb_GSUB $rom/SourceSansVariable-Roman.ttf
sfntedit -a cmap=$rom/.tb_cmap,GDEF=$rom/.tb_GDEF,GPOS=$rom/.tb_GPOS,GSUB=$rom/.tb_GSUB $rom/SourceSansVariable-Roman.otf
sfntedit -x cmap=$itm/.tb_cmap,GDEF=$itm/.tb_GDEF,GPOS=$itm/.tb_GPOS,GSUB=$itm/.tb_GSUB $itm/SourceSansVariable-Italic.ttf
sfntedit -a cmap=$itm/.tb_cmap,GDEF=$itm/.tb_GDEF,GPOS=$itm/.tb_GPOS,GSUB=$itm/.tb_GSUB $itm/SourceSansVariable-Italic.otf

# delete build artifacts
rm */Masters/master_*/master.*tf
rm */Masters/.tb_*
