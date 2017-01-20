buildMasterOTFs RomanMasters/SourceSansPro.designspace
buildCFF2VF RomanMasters/SourceSansPro.designspace  RomanMasters/SourceSansPro-Variable.otf

buildMasterOTFs ItalicMasters/SourceSansPro-Italic.designspace
buildCFF2VF ItalicMasters/SourceSansPro-Italic.designspace  ItalicMasters/SourceSansPro-VariableItalic.otf

rm *Masters/master_*/current.fpr
rm *Masters/master_*/master.otf
