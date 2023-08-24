@echo off

goto start
--------------------------------------
VladimirGav
GitHub Website: https://vladimirgav.github.io/
GitHub: https://github.com/VladimirGav
Source https://github.com/VladimirGav/ai-audio-vg
Copyright (c)
--------------------------------------
:start

REM path
set stable_diffusio_root=%cd%\..
set vladimirgav=%stable_diffusio_root%\vladimirgav
set sdvenv_path=%vladimirgav%\programs\sdvenv

set programsFolder=%vladimirgav%\programs
set pythonFolder=%vladimirgav%\programs\python
set pythonV=%vladimirgav%\programs\python\python
set pipPy=%vladimirgav%\programs\python\get-pip.py

REM set python_zip_url=https://www.python.org/ftp/python/3.10.0/python-3.10.0-embed-amd64.zip
set python_zip_url=https://vladimirgav.github.io/files/python/python-3.10.0-embed-amd64.zip
set python_archive_name=%vladimirgav%\programs\python-3.10.0-embed-amd64.zip

REM set pip_url=https://bootstrap.pypa.io/get-pip.py
set pip_url=https://vladimirgav.github.io/files/pip/get-pip.py

REM Create folder if it doesn't exist
if exist %programsFolder% (
    echo To reinstall, you need to delete the program folder
	pause
	exit /b 1
) else (
    MD %programsFolder%
	echo programsFolder created
)

REM python zip python and unzip in ./python
curl -o %python_archive_name% %python_zip_url%
powershell -Command "Expand-Archive -Path %python_archive_name% -DestinationPath %pythonFolder%"
del %python_archive_name%

REM copy files
copy %vladimirgav%\programs\python\python310._pth %vladimirgav%\programs\python\python310.pth
del %vladimirgav%\programs\python\python310._pth

REM add python in PATH
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

REM install pip
curl -o %pipPy% %pip_url%
python %pipPy% --force-reinstall
python -m pip list

REM install venv
python -m pip install virtualenv

REM create sdvenv
python -m virtualenv %sdvenv_path%

REM activate sdvenv
call %sdvenv_path%/Scripts/activate.bat

REM Home models cache
set XDG_CACHE_HOME=%sdvenv_path%\cache

python -m pip list

REM pip install requirements
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu117
python -m pip list
pip install -r %vladimirgav%\pipinstall\requirements.txt
python -m pip list

python -V

REM Install Win Cuda 11.7.0 local https://developer.nvidia.com/cuda-11-7-0-download-archive
nvcc --version

REM Test
python %vladimirgav%\scripts\test_torch.py

REM Home models cache
set XDG_CACHE_HOME=%sdvenv_path%\cache

REM Create test
REM python %vladimirgav%\scripts\vgTxt2Audio.py

pause