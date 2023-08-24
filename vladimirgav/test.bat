@echo off

goto start
--------------------------------------
VladimirGav
GitHub Website: https://vladimirgav.github.io/
GitHub: https://github.com/VladimirGav
Source https://github.com/VladimirGav/text-to-audio-vg
Copyright (c)
--------------------------------------
:start

REM path
set vladimirgav=%cd%
set sdvenv_path=%vladimirgav%\programs\sdvenv

set py_path=%vladimirgav%\programs\python\
set PATH=%py_path%;%PATH%

REM check python version
set "required_version=3.10.0"
set "PYTHON_MAJOR_VERSION=0"
for /f %%i in ('python -c "import sys; print(str(sys.version_info[0])+str('.')+str(sys.version_info[1])+str('.')+str(sys.version_info[2]))"') do set PYTHON_MAJOR_VERSION=%%i
if "%required_version%" NEQ "%PYTHON_MAJOR_VERSION%" (
    echo Error: Python version required: %required_version%, Installed Python version: %PYTHON_MAJOR_VERSION%. Try removing Python from environment variables or install the correct version.
    pause
	exit /b 1
)

REM activate sdvenv
call %sdvenv_path%/Scripts/activate.bat

REM Home models cache
set XDG_CACHE_HOME=%sdvenv_path%\cache

python --version
pip list
python %vladimirgav%\scripts\test_torch.py

pause