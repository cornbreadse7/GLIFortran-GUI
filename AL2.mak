# Microsoft Developer Studio Generated NMAKE File, Format Version 4.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

!IF "$(CFG)" == ""
CFG=AL2 - Win32 Debug
!MESSAGE No configuration specified.  Defaulting to AL2 - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "AL2 - Win32 Release" && "$(CFG)" != "AL2 - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE on this makefile
!MESSAGE by defining the macro CFG on the command line.  For example:
!MESSAGE 
!MESSAGE NMAKE /f "AL2.mak" CFG="AL2 - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "AL2 - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "AL2 - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE 
!ERROR An invalid configuration is specified.
!ENDIF 

!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 
################################################################################
# Begin Project
# PROP Target_Last_Scanned "AL2 - Win32 Debug"
RSC=rc.exe
F90=fl32.exe

!IF  "$(CFG)" == "AL2 - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Target_Dir ""
OUTDIR=.\Release
INTDIR=.\Release

ALL : "$(OUTDIR)\AL2.exe"

CLEAN : 
	-@erase ".\Release\AL2.exe"
	-@erase ".\Release\MATRIG.obj"
	-@erase ".\Release\LECDAT.obj"
	-@erase ".\Release\FRECUENCIAS.obj"
	-@erase ".\Release\JACOBI.obj"
	-@erase ".\Release\SOLUELA.obj"
	-@erase ".\Release\DISCOR.obj"
	-@erase ".\Release\MatMasa.obj"
	-@erase ".\Release\CHOLES.obj"
	-@erase ".\Release\DESCOM.obj"
	-@erase ".\Release\DATOS.obj"
	-@erase ".\Release\MultiMa.obj"
	-@erase ".\Release\LINEAL.obj"
	-@erase ".\Release\SUSAD.obj"
	-@erase ".\Release\SUSAT.obj"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

# ADD BASE F90 /Ox /I "Release/" /c /nologo
# ADD F90 /Ox /I "Release/" /c /nologo
F90_PROJ=/Ox /I "Release/" /c /nologo /Fo"Release/" 
F90_OBJS=.\Release/
# ADD BASE RSC /l 0x80a /d "NDEBUG"
# ADD RSC /l 0x80a /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
BSC32_FLAGS=/nologo /o"$(OUTDIR)/AL2.bsc" 
BSC32_SBRS=
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib /nologo /subsystem:console /machine:I386
# ADD LINK32 kernel32.lib /nologo /subsystem:console /machine:I386
LINK32_FLAGS=kernel32.lib /nologo /subsystem:console /incremental:no\
 /pdb:"$(OUTDIR)/AL2.pdb" /machine:I386 /out:"$(OUTDIR)/AL2.exe" 
LINK32_OBJS= \
	"$(INTDIR)/MATRIG.obj" \
	"$(INTDIR)/LECDAT.obj" \
	"$(INTDIR)/FRECUENCIAS.obj" \
	"$(INTDIR)/JACOBI.obj" \
	"$(INTDIR)/SOLUELA.obj" \
	"$(INTDIR)/DISCOR.obj" \
	"$(INTDIR)/MatMasa.obj" \
	"$(INTDIR)/CHOLES.obj" \
	"$(INTDIR)/DESCOM.obj" \
	"$(INTDIR)/DATOS.obj" \
	"$(INTDIR)/MultiMa.obj" \
	"$(INTDIR)/LINEAL.obj" \
	"$(INTDIR)/SUSAD.obj" \
	"$(INTDIR)/SUSAT.obj"

"$(OUTDIR)\AL2.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "AL2 - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Target_Dir ""
OUTDIR=.\Debug
INTDIR=.\Debug

ALL : "$(OUTDIR)\AL2.exe"

CLEAN : 
	-@erase ".\Debug\AL2.exe"
	-@erase ".\Debug\MultiMa.obj"
	-@erase ".\Debug\MATRIG.obj"
	-@erase ".\Debug\JACOBI.obj"
	-@erase ".\Debug\FRECUENCIAS.obj"
	-@erase ".\Debug\DISCOR.obj"
	-@erase ".\Debug\DATOS.obj"
	-@erase ".\Debug\CHOLES.obj"
	-@erase ".\Debug\SOLUELA.obj"
	-@erase ".\Debug\DESCOM.obj"
	-@erase ".\Debug\LINEAL.obj"
	-@erase ".\Debug\LECDAT.obj"
	-@erase ".\Debug\MatMasa.obj"
	-@erase ".\Debug\SUSAD.obj"
	-@erase ".\Debug\SUSAT.obj"
	-@erase ".\Debug\AL2.ilk"
	-@erase ".\Debug\AL2.pdb"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

# ADD BASE F90 /Zi /I "Debug/" /c /nologo
# ADD F90 /Zi /I "Debug/" /c /nologo
F90_PROJ=/Zi /I "Debug/" /c /nologo /Fo"Debug/" /Fd"Debug/AL2.pdb" 
F90_OBJS=.\Debug/
# ADD BASE RSC /l 0x80a /d "_DEBUG"
# ADD RSC /l 0x80a /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
BSC32_FLAGS=/nologo /o"$(OUTDIR)/AL2.bsc" 
BSC32_SBRS=
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib /nologo /subsystem:console /debug /machine:I386
# ADD LINK32 kernel32.lib /nologo /subsystem:console /debug /machine:I386
LINK32_FLAGS=kernel32.lib /nologo /subsystem:console /incremental:yes\
 /pdb:"$(OUTDIR)/AL2.pdb" /debug /machine:I386 /out:"$(OUTDIR)/AL2.exe" 
LINK32_OBJS= \
	"$(INTDIR)/MultiMa.obj" \
	"$(INTDIR)/MATRIG.obj" \
	"$(INTDIR)/JACOBI.obj" \
	"$(INTDIR)/FRECUENCIAS.obj" \
	"$(INTDIR)/DISCOR.obj" \
	"$(INTDIR)/DATOS.obj" \
	"$(INTDIR)/CHOLES.obj" \
	"$(INTDIR)/SOLUELA.obj" \
	"$(INTDIR)/DESCOM.obj" \
	"$(INTDIR)/LINEAL.obj" \
	"$(INTDIR)/LECDAT.obj" \
	"$(INTDIR)/MatMasa.obj" \
	"$(INTDIR)/SUSAD.obj" \
	"$(INTDIR)/SUSAT.obj"

"$(OUTDIR)\AL2.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ENDIF 

.for{$(F90_OBJS)}.obj:
   $(F90) $(F90_PROJ) $<  

.f{$(F90_OBJS)}.obj:
   $(F90) $(F90_PROJ) $<  

.f90{$(F90_OBJS)}.obj:
   $(F90) $(F90_PROJ) $<  

################################################################################
# Begin Target

# Name "AL2 - Win32 Release"
# Name "AL2 - Win32 Debug"

!IF  "$(CFG)" == "AL2 - Win32 Release"

!ELSEIF  "$(CFG)" == "AL2 - Win32 Debug"

!ENDIF 

################################################################################
# Begin Source File

SOURCE=.\LINEAL.f90

"$(INTDIR)\LINEAL.obj" : $(SOURCE) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\DATOS.f90

"$(INTDIR)\DATOS.obj" : $(SOURCE) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\LECDAT.f90

"$(INTDIR)\LECDAT.obj" : $(SOURCE) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\MatMasa.f90

"$(INTDIR)\MatMasa.obj" : $(SOURCE) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\MATRIG.f90

"$(INTDIR)\MATRIG.obj" : $(SOURCE) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\DISCOR.f90

"$(INTDIR)\DISCOR.obj" : $(SOURCE) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\FRECUENCIAS.f90

"$(INTDIR)\FRECUENCIAS.obj" : $(SOURCE) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\DESCOM.f90

"$(INTDIR)\DESCOM.obj" : $(SOURCE) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\MultiMa.f90

"$(INTDIR)\MultiMa.obj" : $(SOURCE) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\JACOBI.f90

"$(INTDIR)\JACOBI.obj" : $(SOURCE) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\SOLUELA.f90

"$(INTDIR)\SOLUELA.obj" : $(SOURCE) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\CHOLES.f90

"$(INTDIR)\CHOLES.obj" : $(SOURCE) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\SUSAD.f90

"$(INTDIR)\SUSAD.obj" : $(SOURCE) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\SUSAT.f90

"$(INTDIR)\SUSAT.obj" : $(SOURCE) "$(INTDIR)"


# End Source File
# End Target
# End Project
################################################################################
