@REM cd "C:\Users\joeku\OneDrive\Documents\GitHub\MPR\bin"

@ECHO $OFF 
set debug_mode=1
set make_prm_files=0    
set compile_exe=0       
set solve_model=1      
set create_results=1  
set src_folder=../src/fortran
set array_len = 10
set OMP_NUM_THREADS=8
set MKL_NUM_THREADS=1
set NAG_KUSARI_FILE=lic.txt

echo  "Set Intel Fortan Compiler vars."
call "C:/Program Files (x86)/Intel/oneAPI/setvars.bat" intel64 mod ilp64 || exit 1
echo  "DONE"
echo  ""
echo  "Set NAG vars."
call "C:\Program Files\NAG\NL28\nlw6i284el\batch\envvars.bat" || exit 1
echo  "DONE"
echo  ""

if %debug_mode%==0 (set fcompile = "nagfor -abi=32 -ieee=full -compatible -I ") else (set fcompile="ifort -mkl -O0 -init=snan -debug -traceback -check all,noarg_temp_created -nowarn -CB %NAGLIB_FFLAGS% %NAGLIB_FINCLUDE%")

if EXIST ..\output (rmdir /Q /S ..\output) else (echo "the file 'output' does not exist")
echo  "removed"
mkdir ..\output
mkdir ..\output\tmp

if %make_prm_files%==1 (echo  "Create parameter files."
if EXIST ..\src\params\*.csv (del /Q /S ..\src\params\*.csv) else (echo "the param csv files does not exist")
matlab -nojvm -nosplash -nodesktop "../src/params/create_param_files.m" || exit 1
echo  "DONE."
echo  "") 

if %compile_exe%==1 (
echo "Remove previous compilation files."
del  *.exe
del /Q /S .\*.o
del /Q /S .\*.mod
del /Q /S .\*_genmod.f90
echo  "DONE."
echo ""

echo "Compile executable."


ifort  /heap-arrays:50 %src_folder%/base_lib.f90 ^
%src_folder%/mod_smolyak.f90 %src_folder%/mod_param.f90 ^
%src_folder%/mod_calc.f90  %src_folder%/mod_results.f90 ^
%src_folder%/mod_decomp.f90 %src_folder%/main.f90 ^
nag_mkl_MT.lib mkl_rt.lib libiomp5md.lib user32.lib  -o main.exe   || exit 1
 
@REM ifort /iface:cvf %src_folder%/my.f90 -o my.exe || exit 1
 
echo "DONE."
echo ""
)

@REM if %solve_model% == 1 ( 
@REM echo "Run calibration"
@REM mkdir ..\output\tmp\res_1
@REM echo "hi" > ..\output\tmp\res_1\extra_data.csv
@REM call main.exe 1
@REM echo "DONE."
@REM )

@REM # get number of calibrations to run

set file="../output/tmp/n_comp.txt"
set n_comp = 1
if %solve_model% == 1 ( 
for %%i in (1, %n_comp%) do (
rmdir /Q /S ..\output\tmp\res_%%i
mkdir ..\output\tmp\res_%%i
echo "Run calibration %%i."
echo nul > ..\output\tmp\res_%%i\extra_data.csv
call main.exe %%i
del /Q /S output.txt
echo  "DONE."
))



echo "Remove compilation files."
rm *.exe
rm *.o
rm *.mod
rm *_genmod.f90

echo  "DONE."
echo ""

pause

