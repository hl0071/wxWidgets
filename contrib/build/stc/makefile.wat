# =========================================================================
#     This makefile was generated by
#     Bakefile 0.1.1 (http://bakefile.sourceforge.net)
#     Do not modify, all changes will be overwritten!
# =========================================================================

!include ../../../build/msw/config.wat

# -------------------------------------------------------------------------
# Do not modify the rest of this file!
# -------------------------------------------------------------------------

# Speed up compilation a bit:
!ifdef __LOADDLL__
!  loaddll wcc      wccd
!  loaddll wccaxp   wccdaxp
!  loaddll wcc386   wccd386
!  loaddll wpp      wppdi86
!  loaddll wppaxp   wppdaxp
!  loaddll wpp386   wppd386
!  loaddll wlink    wlink
!  loaddll wlib     wlibd
!endif

# We need these variables in some bakefile-made rules:
WATCOM_CWD = $+ $(%cdrive):$(%cwd) $-

### Conditionally set variables: ###

LIBDIRNAME =
!ifeq SHARED 0
LIBDIRNAME = ..\..\src\stc\..\..\..\lib\wat_lib$(CFG)
!endif
!ifeq SHARED 1
LIBDIRNAME = ..\..\src\stc\..\..\..\lib\wat_dll$(CFG)
!endif
PORTNAME =
!ifeq USE_GUI 0
PORTNAME = base
!endif
!ifeq USE_GUI 1
PORTNAME = msw
!endif
VENDORTAG =
!ifeq OFFICIAL_BUILD 0
VENDORTAG = _$(VENDOR)
!endif
!ifeq OFFICIAL_BUILD 1
VENDORTAG = 
!endif
WXDEBUGFLAG =
!ifeq BUILD debug
!ifeq DEBUG_FLAG default
WXDEBUGFLAG = d
!endif
!endif
!ifeq DEBUG_FLAG 1
WXDEBUGFLAG = d
!endif
WXDLLFLAG =
!ifeq SHARED 1
WXDLLFLAG = dll
!endif
WXUNICODEFLAG =
!ifeq UNICODE 1
WXUNICODEFLAG = u
!endif
WXUNIVNAME =
!ifeq WXUNIV 1
WXUNIVNAME = univ
!endif
__DEBUGINFO =
!ifeq BUILD debug
!ifeq DEBUG_INFO default
__DEBUGINFO = -d2
!endif
!endif
!ifeq BUILD release
!ifeq DEBUG_INFO default
__DEBUGINFO = -d0
!endif
!endif
!ifeq DEBUG_INFO 0
__DEBUGINFO = -d0
!endif
!ifeq DEBUG_INFO 1
__DEBUGINFO = -d2
!endif
__DEBUGINFO_1 =
!ifeq BUILD debug
!ifeq DEBUG_INFO default
__DEBUGINFO_1 = debug all
!endif
!endif
!ifeq BUILD release
!ifeq DEBUG_INFO default
__DEBUGINFO_1 = 
!endif
!endif
!ifeq DEBUG_INFO 0
__DEBUGINFO_1 = 
!endif
!ifeq DEBUG_INFO 1
__DEBUGINFO_1 = debug all
!endif
__DEBUG_DEFINE_p =
!ifeq BUILD debug
!ifeq DEBUG_FLAG default
__DEBUG_DEFINE_p = -d__WXDEBUG__
!endif
!endif
!ifeq DEBUG_FLAG 1
__DEBUG_DEFINE_p = -d__WXDEBUG__
!endif
__LIB_JPEG_p =
!ifeq USE_GUI 1
__LIB_JPEG_p = wxjpeg$(WXDEBUGFLAG).lib
!endif
__LIB_PNG_p =
!ifeq USE_GUI 1
__LIB_PNG_p = wxpng$(WXDEBUGFLAG).lib
!endif
__LIB_TIFF_p =
!ifeq USE_GUI 1
__LIB_TIFF_p = wxtiff$(WXDEBUGFLAG).lib
!endif
__OPTIMIZEFLAG =
!ifeq BUILD debug
__OPTIMIZEFLAG = -od
!endif
!ifeq BUILD release
__OPTIMIZEFLAG = -ot -ox
!endif
__RUNTIME_LIBS =
!ifeq RUNTIME_LIBS dynamic
__RUNTIME_LIBS = -br
!endif
!ifeq RUNTIME_LIBS static
__RUNTIME_LIBS = 
!endif
__UNICODE_DEFINE_p =
!ifeq UNICODE 1
__UNICODE_DEFINE_p = -d_UNICODE
!endif
__WXLIB_BASE_p =
!ifeq MONOLITHIC 0
__WXLIB_BASE_p = wxbase25$(WXUNICODEFLAG)$(WXDEBUGFLAG).lib
!endif
__WXLIB_CORE_p =
!ifeq MONOLITHIC 0
__WXLIB_CORE_p = &
	wx$(PORTNAME)$(WXUNIVNAME)25$(WXUNICODEFLAG)$(WXDEBUGFLAG)_core.lib
!endif
__WXLIB_MONO_p =
!ifeq MONOLITHIC 1
__WXLIB_MONO_p = &
	wx$(PORTNAME)$(WXUNIVNAME)25$(WXUNICODEFLAG)$(WXDEBUGFLAG).lib
!endif
__WXUNIV_DEFINE_p =
!ifeq WXUNIV 1
__WXUNIV_DEFINE_p = -d__WXUNIVERSAL__
!endif
__stcdll___depname =
!ifeq SHARED 1
__stcdll___depname = &
	$(LIBDIRNAME)\wx$(PORTNAME)$(WXUNIVNAME)251$(WXUNICODEFLAG)$(WXDEBUGFLAG)_stc_wat$(VENDORTAG).dll
!endif
__stclib___depname =
!ifeq SHARED 0
__stclib___depname = &
	$(LIBDIRNAME)\wx$(PORTNAME)$(WXUNIVNAME)25$(WXUNICODEFLAG)$(WXDEBUGFLAG)_stc.lib
!endif

### Variables: ###

OBJS = &
	wat_$(PORTNAME)$(WXUNIVNAME)$(WXUNICODEFLAG)$(WXDEBUGFLAG)$(WXDLLFLAG)$(CFG)
SETUPHDIR = &
	$(LIBDIRNAME)\$(PORTNAME)$(WXUNIVNAME)$(WXUNICODEFLAG)$(WXDEBUGFLAG)
STCDLL_CXXFLAGS = $(CPPFLAGS) -bd $(__DEBUGINFO) $(__OPTIMIZEFLAG) -bm &
	$(__RUNTIME_LIBS) -d__WXMSW__ $(__WXUNIV_DEFINE_p) $(__DEBUG_DEFINE_p) &
	$(__UNICODE_DEFINE_p) -i=..\..\src\stc\..\..\..\include -i=$(SETUPHDIR) &
	-i=..\..\src\stc\..\..\include -i=..\..\src\stc\scintilla\include &
	-i=..\..\src\stc\scintilla\src -d__WX__ -dSCI_LEXER -dLINK_LEXERS &
	-dWXUSINGDLL -dWXMAKINGDLL_STC $(CXXFLAGS)
STCDLL_OBJECTS =  &
	$(OBJS)\stcdll_PlatWX.obj &
	$(OBJS)\stcdll_ScintillaWX.obj &
	$(OBJS)\stcdll_stc.obj &
	$(OBJS)\stcdll_AutoComplete.obj &
	$(OBJS)\stcdll_CallTip.obj &
	$(OBJS)\stcdll_CellBuffer.obj &
	$(OBJS)\stcdll_ContractionState.obj &
	$(OBJS)\stcdll_Document.obj &
	$(OBJS)\stcdll_DocumentAccessor.obj &
	$(OBJS)\stcdll_Editor.obj &
	$(OBJS)\stcdll_ExternalLexer.obj &
	$(OBJS)\stcdll_Indicator.obj &
	$(OBJS)\stcdll_KeyMap.obj &
	$(OBJS)\stcdll_KeyWords.obj &
	$(OBJS)\stcdll_LexAVE.obj &
	$(OBJS)\stcdll_LexAda.obj &
	$(OBJS)\stcdll_LexAsm.obj &
	$(OBJS)\stcdll_LexBaan.obj &
	$(OBJS)\stcdll_LexBullant.obj &
	$(OBJS)\stcdll_LexCPP.obj &
	$(OBJS)\stcdll_LexCSS.obj &
	$(OBJS)\stcdll_LexConf.obj &
	$(OBJS)\stcdll_LexCrontab.obj &
	$(OBJS)\stcdll_LexEiffel.obj &
	$(OBJS)\stcdll_LexEScript.obj &
	$(OBJS)\stcdll_LexFortran.obj &
	$(OBJS)\stcdll_LexHTML.obj &
	$(OBJS)\stcdll_LexLisp.obj &
	$(OBJS)\stcdll_LexLout.obj &
	$(OBJS)\stcdll_LexLua.obj &
	$(OBJS)\stcdll_LexMatlab.obj &
	$(OBJS)\stcdll_LexOthers.obj &
	$(OBJS)\stcdll_LexPOV.obj &
	$(OBJS)\stcdll_LexPascal.obj &
	$(OBJS)\stcdll_LexPerl.obj &
	$(OBJS)\stcdll_LexPython.obj &
	$(OBJS)\stcdll_LexRuby.obj &
	$(OBJS)\stcdll_LexSQL.obj &
	$(OBJS)\stcdll_LexVB.obj &
	$(OBJS)\stcdll_LineMarker.obj &
	$(OBJS)\stcdll_PropSet.obj &
	$(OBJS)\stcdll_RESearch.obj &
	$(OBJS)\stcdll_ScintillaBase.obj &
	$(OBJS)\stcdll_Style.obj &
	$(OBJS)\stcdll_StyleContext.obj &
	$(OBJS)\stcdll_UniConversion.obj &
	$(OBJS)\stcdll_ViewStyle.obj &
	$(OBJS)\stcdll_WindowAccessor.obj &
	$(OBJS)\stcdll_XPM.obj
STCLIB_CXXFLAGS = $(CPPFLAGS) $(__DEBUGINFO) $(__OPTIMIZEFLAG) -bm &
	$(__RUNTIME_LIBS) -d__WXMSW__ $(__WXUNIV_DEFINE_p) $(__DEBUG_DEFINE_p) &
	$(__UNICODE_DEFINE_p) -i=..\..\src\stc\..\..\..\include -i=$(SETUPHDIR) &
	-i=..\..\src\stc\..\..\include -i=..\..\src\stc\scintilla\include &
	-i=..\..\src\stc\scintilla\src -d__WX__ -dSCI_LEXER -dLINK_LEXERS &
	$(CXXFLAGS)
STCLIB_OBJECTS =  &
	$(OBJS)\stclib_PlatWX.obj &
	$(OBJS)\stclib_ScintillaWX.obj &
	$(OBJS)\stclib_stc.obj &
	$(OBJS)\stclib_AutoComplete.obj &
	$(OBJS)\stclib_CallTip.obj &
	$(OBJS)\stclib_CellBuffer.obj &
	$(OBJS)\stclib_ContractionState.obj &
	$(OBJS)\stclib_Document.obj &
	$(OBJS)\stclib_DocumentAccessor.obj &
	$(OBJS)\stclib_Editor.obj &
	$(OBJS)\stclib_ExternalLexer.obj &
	$(OBJS)\stclib_Indicator.obj &
	$(OBJS)\stclib_KeyMap.obj &
	$(OBJS)\stclib_KeyWords.obj &
	$(OBJS)\stclib_LexAVE.obj &
	$(OBJS)\stclib_LexAda.obj &
	$(OBJS)\stclib_LexAsm.obj &
	$(OBJS)\stclib_LexBaan.obj &
	$(OBJS)\stclib_LexBullant.obj &
	$(OBJS)\stclib_LexCPP.obj &
	$(OBJS)\stclib_LexCSS.obj &
	$(OBJS)\stclib_LexConf.obj &
	$(OBJS)\stclib_LexCrontab.obj &
	$(OBJS)\stclib_LexEiffel.obj &
	$(OBJS)\stclib_LexEScript.obj &
	$(OBJS)\stclib_LexFortran.obj &
	$(OBJS)\stclib_LexHTML.obj &
	$(OBJS)\stclib_LexLisp.obj &
	$(OBJS)\stclib_LexLout.obj &
	$(OBJS)\stclib_LexLua.obj &
	$(OBJS)\stclib_LexMatlab.obj &
	$(OBJS)\stclib_LexOthers.obj &
	$(OBJS)\stclib_LexPOV.obj &
	$(OBJS)\stclib_LexPascal.obj &
	$(OBJS)\stclib_LexPerl.obj &
	$(OBJS)\stclib_LexPython.obj &
	$(OBJS)\stclib_LexRuby.obj &
	$(OBJS)\stclib_LexSQL.obj &
	$(OBJS)\stclib_LexVB.obj &
	$(OBJS)\stclib_LineMarker.obj &
	$(OBJS)\stclib_PropSet.obj &
	$(OBJS)\stclib_RESearch.obj &
	$(OBJS)\stclib_ScintillaBase.obj &
	$(OBJS)\stclib_Style.obj &
	$(OBJS)\stclib_StyleContext.obj &
	$(OBJS)\stclib_UniConversion.obj &
	$(OBJS)\stclib_ViewStyle.obj &
	$(OBJS)\stclib_WindowAccessor.obj &
	$(OBJS)\stclib_XPM.obj


all : $(OBJS)
$(OBJS) :
	-if not exist $(OBJS) mkdir $(OBJS)

### Targets: ###

all : .SYMBOLIC $(__stcdll___depname) $(__stclib___depname)

$(OBJS)\stcdll_AutoComplete.obj :  .AUTODEPEND ../../src/stc\scintilla\src\AutoComplete.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_CallTip.obj :  .AUTODEPEND ../../src/stc\scintilla\src\CallTip.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_CellBuffer.obj :  .AUTODEPEND ../../src/stc\scintilla\src\CellBuffer.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_ContractionState.obj :  .AUTODEPEND ../../src/stc\scintilla\src\ContractionState.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_Document.obj :  .AUTODEPEND ../../src/stc\scintilla\src\Document.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_DocumentAccessor.obj :  .AUTODEPEND ../../src/stc\scintilla\src\DocumentAccessor.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_Editor.obj :  .AUTODEPEND ../../src/stc\scintilla\src\Editor.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_ExternalLexer.obj :  .AUTODEPEND ../../src/stc\scintilla\src\ExternalLexer.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_Indicator.obj :  .AUTODEPEND ../../src/stc\scintilla\src\Indicator.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_KeyMap.obj :  .AUTODEPEND ../../src/stc\scintilla\src\KeyMap.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_KeyWords.obj :  .AUTODEPEND ../../src/stc\scintilla\src\KeyWords.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_LexAVE.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexAVE.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_LexAda.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexAda.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_LexAsm.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexAsm.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_LexBaan.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexBaan.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_LexBullant.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexBullant.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_LexCPP.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexCPP.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_LexCSS.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexCSS.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_LexConf.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexConf.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_LexCrontab.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexCrontab.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_LexEScript.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexEScript.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_LexEiffel.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexEiffel.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_LexFortran.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexFortran.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_LexHTML.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexHTML.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_LexLisp.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexLisp.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_LexLout.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexLout.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_LexLua.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexLua.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_LexMatlab.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexMatlab.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_LexOthers.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexOthers.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_LexPOV.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexPOV.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_LexPascal.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexPascal.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_LexPerl.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexPerl.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_LexPython.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexPython.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_LexRuby.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexRuby.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_LexSQL.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexSQL.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_LexVB.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexVB.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_LineMarker.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LineMarker.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_PlatWX.obj :  .AUTODEPEND ../../src/stc\PlatWX.cpp
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_PropSet.obj :  .AUTODEPEND ../../src/stc\scintilla\src\PropSet.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_RESearch.obj :  .AUTODEPEND ../../src/stc\scintilla\src\RESearch.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_ScintillaBase.obj :  .AUTODEPEND ../../src/stc\scintilla\src\ScintillaBase.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_ScintillaWX.obj :  .AUTODEPEND ../../src/stc\ScintillaWX.cpp
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_Style.obj :  .AUTODEPEND ../../src/stc\scintilla\src\Style.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_StyleContext.obj :  .AUTODEPEND ../../src/stc\scintilla\src\StyleContext.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_UniConversion.obj :  .AUTODEPEND ../../src/stc\scintilla\src\UniConversion.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_ViewStyle.obj :  .AUTODEPEND ../../src/stc\scintilla\src\ViewStyle.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_WindowAccessor.obj :  .AUTODEPEND ../../src/stc\scintilla\src\WindowAccessor.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_XPM.obj :  .AUTODEPEND ../../src/stc\scintilla\src\XPM.cxx
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stcdll_stc.obj :  .AUTODEPEND ../../src/stc\stc.cpp
	$(CXX) -zq -fo=$^@ $(STCDLL_CXXFLAGS) $<

$(OBJS)\stclib_AutoComplete.obj :  .AUTODEPEND ../../src/stc\scintilla\src\AutoComplete.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_CallTip.obj :  .AUTODEPEND ../../src/stc\scintilla\src\CallTip.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_CellBuffer.obj :  .AUTODEPEND ../../src/stc\scintilla\src\CellBuffer.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_ContractionState.obj :  .AUTODEPEND ../../src/stc\scintilla\src\ContractionState.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_Document.obj :  .AUTODEPEND ../../src/stc\scintilla\src\Document.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_DocumentAccessor.obj :  .AUTODEPEND ../../src/stc\scintilla\src\DocumentAccessor.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_Editor.obj :  .AUTODEPEND ../../src/stc\scintilla\src\Editor.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_ExternalLexer.obj :  .AUTODEPEND ../../src/stc\scintilla\src\ExternalLexer.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_Indicator.obj :  .AUTODEPEND ../../src/stc\scintilla\src\Indicator.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_KeyMap.obj :  .AUTODEPEND ../../src/stc\scintilla\src\KeyMap.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_KeyWords.obj :  .AUTODEPEND ../../src/stc\scintilla\src\KeyWords.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_LexAVE.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexAVE.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_LexAda.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexAda.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_LexAsm.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexAsm.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_LexBaan.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexBaan.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_LexBullant.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexBullant.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_LexCPP.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexCPP.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_LexCSS.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexCSS.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_LexConf.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexConf.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_LexCrontab.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexCrontab.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_LexEScript.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexEScript.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_LexEiffel.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexEiffel.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_LexFortran.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexFortran.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_LexHTML.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexHTML.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_LexLisp.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexLisp.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_LexLout.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexLout.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_LexLua.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexLua.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_LexMatlab.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexMatlab.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_LexOthers.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexOthers.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_LexPOV.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexPOV.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_LexPascal.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexPascal.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_LexPerl.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexPerl.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_LexPython.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexPython.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_LexRuby.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexRuby.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_LexSQL.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexSQL.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_LexVB.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LexVB.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_LineMarker.obj :  .AUTODEPEND ../../src/stc\scintilla\src\LineMarker.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_PlatWX.obj :  .AUTODEPEND ../../src/stc\PlatWX.cpp
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_PropSet.obj :  .AUTODEPEND ../../src/stc\scintilla\src\PropSet.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_RESearch.obj :  .AUTODEPEND ../../src/stc\scintilla\src\RESearch.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_ScintillaBase.obj :  .AUTODEPEND ../../src/stc\scintilla\src\ScintillaBase.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_ScintillaWX.obj :  .AUTODEPEND ../../src/stc\ScintillaWX.cpp
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_Style.obj :  .AUTODEPEND ../../src/stc\scintilla\src\Style.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_StyleContext.obj :  .AUTODEPEND ../../src/stc\scintilla\src\StyleContext.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_UniConversion.obj :  .AUTODEPEND ../../src/stc\scintilla\src\UniConversion.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_ViewStyle.obj :  .AUTODEPEND ../../src/stc\scintilla\src\ViewStyle.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_WindowAccessor.obj :  .AUTODEPEND ../../src/stc\scintilla\src\WindowAccessor.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_XPM.obj :  .AUTODEPEND ../../src/stc\scintilla\src\XPM.cxx
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

$(OBJS)\stclib_stc.obj :  .AUTODEPEND ../../src/stc\stc.cpp
	$(CXX) -zq -fo=$^@ $(STCLIB_CXXFLAGS) $<

clean : .SYMBOLIC 
	-if exist $(OBJS)\*.obj del $(OBJS)\*.obj
	-if exist $(OBJS)\*.res del $(OBJS)\*.res
	-if exist $(OBJS)\*.lbc del $(OBJS)\*.lbc
	-if exist $(OBJS)\*.ilk del $(OBJS)\*.ilk
	-if exist $(LIBDIRNAME)\wx$(PORTNAME)$(WXUNIVNAME)251$(WXUNICODEFLAG)$(WXDEBUGFLAG)_stc_wat$(VENDORTAG).dll del $(LIBDIRNAME)\wx$(PORTNAME)$(WXUNIVNAME)251$(WXUNICODEFLAG)$(WXDEBUGFLAG)_stc_wat$(VENDORTAG).dll
	-if exist $(LIBDIRNAME)\wx$(PORTNAME)$(WXUNIVNAME)25$(WXUNICODEFLAG)$(WXDEBUGFLAG)_stc.lib del $(LIBDIRNAME)\wx$(PORTNAME)$(WXUNIVNAME)25$(WXUNICODEFLAG)$(WXDEBUGFLAG)_stc.lib
	-if exist $(LIBDIRNAME)\wx$(PORTNAME)$(WXUNIVNAME)25$(WXUNICODEFLAG)$(WXDEBUGFLAG)_stc.lib del $(LIBDIRNAME)\wx$(PORTNAME)$(WXUNIVNAME)25$(WXUNICODEFLAG)$(WXDEBUGFLAG)_stc.lib

!ifeq SHARED 1
$(LIBDIRNAME)\wx$(PORTNAME)$(WXUNIVNAME)251$(WXUNICODEFLAG)$(WXDEBUGFLAG)_stc_wat$(VENDORTAG).dll :  $(STCDLL_OBJECTS)
	@%create $(OBJS)\stcdll.lbc
	@%append $(OBJS)\stcdll.lbc option quiet
	@%append $(OBJS)\stcdll.lbc name $^@
	@%append $(OBJS)\stcdll.lbc option caseexact
	@%append $(OBJS)\stcdll.lbc $(LDFLAGS) $(__DEBUGINFO_1)  libpath $(LIBDIRNAME)
	@for %i in ($(STCDLL_OBJECTS)) do @%append $(OBJS)\stcdll.lbc file %i
	@for %i in ( $(__WXLIB_MONO_p) $(__LIB_TIFF_p) $(__LIB_JPEG_p) $(__LIB_PNG_p) wxzlib$(WXDEBUGFLAG).lib  wxregex$(WXDEBUGFLAG).lib wxexpat$(WXDEBUGFLAG).lib   kernel32.lib user32.lib gdi32.lib comdlg32.lib winspool.lib winmm.lib shell32.lib comctl32.lib odbc32.lib ole32.lib oleaut32.lib uuid.lib rpcrt4.lib advapi32.lib wsock32.lib  $(__WXLIB_CORE_p)  $(__WXLIB_BASE_p) ) do @%append $(OBJS)\stcdll.lbc library %i
	@%append $(OBJS)\stcdll.lbc
	@%append $(OBJS)\stcdll.lbc system nt_dll
	wlink @$(OBJS)\stcdll.lbc
	wlib -q -n -b $(LIBDIRNAME)\wx$(PORTNAME)$(WXUNIVNAME)25$(WXUNICODEFLAG)$(WXDEBUGFLAG)_stc.lib +$^@
!endif

!ifeq SHARED 0
$(LIBDIRNAME)\wx$(PORTNAME)$(WXUNIVNAME)25$(WXUNICODEFLAG)$(WXDEBUGFLAG)_stc.lib :  $(STCLIB_OBJECTS)
	@%create $(OBJS)\stclib.lbc
	@for %i in ($(STCLIB_OBJECTS)) do @%append $(OBJS)\stclib.lbc +%i
	wlib -q -p2048 -n -b $^@ @$(OBJS)\stclib.lbc
!endif
