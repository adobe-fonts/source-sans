#!/usr/bin/env sh

rom=Roman/Masters
itm=Italic/Masters

ro_name=SourceSansVariable-Roman
it_name=SourceSansVariable-Italic

# build variable OTFs
buildMasterOTFs $rom/$ro_name.designspace
buildCFF2VF -p $rom/$ro_name.designspace
buildMasterOTFs $itm/$it_name.designspace
buildCFF2VF -p $itm/$it_name.designspace

# extract and subroutinize the CFF2 table
echo 'Subroutinizing' $rom/$ro_name.otf
tx -cff2 +S +b -std $rom/$ro_name.otf $rom/.tb_cff2 2> /dev/null
echo 'Subroutinizing' $itm/$it_name.otf
tx -cff2 +S +b -std $itm/$it_name.otf $itm/.tb_cff2 2> /dev/null

# replace CFF2 table with subroutinized version
sfntedit -a CFF2=$rom/.tb_cff2 $rom/$ro_name.otf 1> /dev/null
sfntedit -a CFF2=$itm/.tb_cff2 $itm/$it_name.otf 1> /dev/null

# build variable TTFs
fontmake -m $rom/$ro_name.designspace -o variable --production-names
fontmake -m $itm/$it_name.designspace -o variable --production-names

# use DSIG, name, OS/2, hhea, post, and STAT tables from OTFs
sfntedit -x DSIG=$rom/.tb_DSIG,name=$rom/.tb_name,OS/2=$rom/.tb_os2,hhea=$rom/.tb_hhea,post=$rom/.tb_post,STAT=$rom/.tb_STAT $rom/$ro_name.otf 1> /dev/null
sfntedit -a DSIG=$rom/.tb_DSIG,name=$rom/.tb_name,OS/2=$rom/.tb_os2,hhea=$rom/.tb_hhea,post=$rom/.tb_post,STAT=$rom/.tb_STAT $rom/$ro_name.ttf 1> /dev/null
sfntedit -x DSIG=$itm/.tb_DSIG,name=$itm/.tb_name,OS/2=$itm/.tb_os2,hhea=$itm/.tb_hhea,post=$itm/.tb_post,STAT=$itm/.tb_STAT $itm/$it_name.otf 1> /dev/null
sfntedit -a DSIG=$itm/.tb_DSIG,name=$itm/.tb_name,OS/2=$itm/.tb_os2,hhea=$itm/.tb_hhea,post=$itm/.tb_post,STAT=$itm/.tb_STAT $itm/$it_name.ttf 1> /dev/null

# use cmap, GDEF, GPOS, and GSUB tables from TTFs
sfntedit -x cmap=$rom/.tb_cmap,GDEF=$rom/.tb_GDEF,GPOS=$rom/.tb_GPOS,GSUB=$rom/.tb_GSUB $rom/$ro_name.ttf 1> /dev/null
sfntedit -a cmap=$rom/.tb_cmap,GDEF=$rom/.tb_GDEF,GPOS=$rom/.tb_GPOS,GSUB=$rom/.tb_GSUB $rom/$ro_name.otf 1> /dev/null
sfntedit -x cmap=$itm/.tb_cmap,GDEF=$itm/.tb_GDEF,GPOS=$itm/.tb_GPOS,GSUB=$itm/.tb_GSUB $itm/$it_name.ttf 1> /dev/null
sfntedit -a cmap=$itm/.tb_cmap,GDEF=$itm/.tb_GDEF,GPOS=$itm/.tb_GPOS,GSUB=$itm/.tb_GSUB $itm/$it_name.otf 1> /dev/null

# delete build artifacts
rm */Masters/.tb_*
rm */Masters/master_*/*.*tf

echo "Done"
