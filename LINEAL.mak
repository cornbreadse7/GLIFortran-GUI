# Microsoft Developer Studio Generated NMAKE File, Format Version 4.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

!IF "$(CFG)" == ""
CFG=LINEAL - Win32 Debug
!MESSAGE No configuration specified.  Defaulting to LINEAL - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "LINEAL - Win32 Release" && "$(CFG)" != "LINEAL - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE on this makefile
!MESSAGE by defining the macro CFG on the command line.  For example:
!MESSAGE 
!MESSAGE NMAKE /f "LINEAL.mak" CFG="LINEAL - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "LINEAL - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "LINEAL - Win32 Debug" (based on "Win32 (x86) Console Application")
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
# PROP Target_Last_Scanned "LINEAL - Win32 Debug"
RSC=rc.exe
F90=fl32.exe

!IF  "$(CFG)" == "LINEAL - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
OUTDIR=.
INTDIR=.

ALL : "$(OUTDIR)\LINEAL.exe"

CLEAN : 
	-@erase ".\LINEAL.exe"
	-@erase ".\LINEAL.obj"
	-@erase ".\DATOS.obj"
	-@erase ".\LECDAT.obj"
	-@erase ".\MatMasa.obj"
	-@erase ".\MATRIG.obj"
	-@erase ".\DISCOR.obj"
	-@erase ".\FRECUENCIAS.obj"
	-@erase ".\SOLUELA.obj"
	-@erase ".\JACOBI.obj"
	-@erase ".\MultiMa.obj"
	-@erase ".\DESCOM.obj"

# ADD BASE F90 /Ox /c /nologo
# ADD F90 /Ox /c /nologo
F90_PROJ=/Ox /c /nologo 
# ADD BASE RSC /l 0x80a /d "NDEBUG"
# ADD RSC /l 0x80a /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
BSC32_FLAGS=/nologo /o"$(OUTDIR)/LINEAL.bsc" 
BSC32_SBRS=
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib /nologo /subsystem:console /machine:I386
# ADD LINK32 kernel32.lib /nologo /subsystem:console /machine:I386
LINK32_FLAGS=kernel32.lib /nologo /subsystem:console /incremental:no\
 /pdb:"$(OUTDIR)/LINEAL.pdb" /machine:I386 /out:"$(OUTDIR)/LINEAL.exe" 
LINK32_OBJS= \
	"$(INTDIR)/LINEAL.obj" \
	"$(INTDIR)/DATOS.obj" \
	"$(INTDIR)/LECDAT.obj" \
	"$(INTDIR)/MatMasa.obj" \
	"$(INTDIR)/MATRIG.obj" \
	"$(INTDIR)/DISCOR.obj" \
	"$(INTDIR)/FRECUENCIAS.obj" \
	"$(INTDIR)/SOLUELA.obj" \
	"$(INTDIR)/JACOBI.obj" \
	"$(INTDIR)/MultiMa.obj" \
	"$(INTDIR)/DESCOM.obj"

"$(OUTDIR)\LINEAL.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "LINEAL - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
OUTDIR=.
INTDIR=.

ALL : "$(OUTDIR)\LINEAL.exe"

CLEAN : 
	-@erase ".\LINEAL.exe"
	-@erase ".\LINEAL.obj"
	-@erase ".\DATOS.obj"
	-@erase ".\LECDAT.obj"
	-@erase ".\MatMasa.obj"
	-@erase ".\MATRIG.obj"
	-@erase ".\DISCOR.obj"
	-@erase ".\FRECUENCIAS.obj"
	-@erase ".\SOLUELA.obj"
	-@erase ".\JACOBI.obj"
	-@erase ".\MultiMa.obj"
	-@erase ".\DESCOM.obj"
	-@erase ".\LINEAL.ilk"
	-@erase ".\LINEAL.pdb"

# ADD BASE F90 /Zi /c /nologo
# ADD F90 /Zi /c /nologo
F90_PROJ=/Zi /c /nologo /Fd"LINEAL.pdb" 
# ADD BASE RSC /l 0x80a /d "_DEBUG"
# ADD RSC /l 0x80a /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
BSC32_FLAGS=/nologo /o"$(OUTDIR)/LINEAL.bsc" 
BSC32_SBRS=
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib /nologo /subsystem:console /debug /machine:I386
# ADD LINK32 kernel32.lib /nologo /subsystem:console /debug /machine:I386
LINK32_FLAGS=kernel32.lib /nologo /subsystem:console /incremental:yes\
 /pdb:"$(OUTDIR)/LINEAL.pdb" /debug /machine:I386 /out:"$(OUTDIR)/LINEAL.exe" 
LINK32_OBJS= \
	"$(INTDIR)/LINEAL.obj" \
	"$(INTDIR)/DATOS.obj" \
	"$(INTDIR)/LECDAT.obj" \
	"$(INTDIR)/MatMasa.obj" \
	"$(INTDIR)/MATRIG.obj" \
	"$(INTDIR)/DISCOR.obj" \
	"$(INTDIR)/FRECUENCIAS.obj" \
	"$(INTDIR)/SOLUELA.obj" \
	"$(INTDIR)/JACOBI.obj" \
	"$(INTDIR)/MultiMa.obj" \
	"$(INTDIR)/DESCOM.obj"

"$(OUTDIR)\LINEAL.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ENDIF 

.for.obj:
   $(F90) $(F90_PROJ) $<  

.f.obj:
   $(F90) $(F90_PROJ) $<  

.f90.obj:
   $(F90) $(F90_PROJ) $<  

################################################################################
# Begin Target

# Name "LINEAL - Win32 Release"
# Name "LINEAL - Win32 Debug"

!IF  "$(CFG)" == "LINEAL - Win32 Release"

!ELSEIF  "$(CFG)" == "LINEAL - Win32 Debug"

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

SOURCE=.\SOLUELA.f90

"$(INTDIR)\SOLUELA.obj" : $(SOURCE) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\JACOBI.f90

"$(INTDIR)\JACOBI.obj" : $(SOURCE) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\MultiMa.f90

"$(INTDIR)\MultiMa.obj" : $(SOURCE) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\DESCOM.f90

"$(INTDIR)\DESCOM.obj" : $(SOURCE) "$(INTDIR)"


# End Source File
# End Target
# End Project
################################################################################
