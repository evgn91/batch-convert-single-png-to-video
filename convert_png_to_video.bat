::Warning! ffmpeg is required for this script to work
@ echo off
setlocal enabledelayedexpansion

chcp 65001

set width=1
set height=1
set duration=5
set fps=25
set bitrate=4000
set ext=mp4

echo width:%width%

for /r %%F in (*.png) do (
   call :ProcessFile %%~nF
   echo width: !width!
   echo height: !height!
   echo duration: !duration:~0,-1!
   echo fps: !fps:~0,-3!
   echo bitrate: !bitrate:~0,-4!
   echo ext: !ext!
   ffmpeg -loop 1 -i "%%~dF%%~pF%%~nF%%~xF" -c:v libx264 -t !duration:~0,-1! -pix_fmt yuv420p -vf scale=!width!:!height! -r !fps:~0,-3! -b:v !bitrate:~0,-4!k  "%%~dF%%~pF%%~nF.!ext!"
)
goto :End

:ProcessFile
set filename="%1"
echo file:%filename%
for /F "tokens=1,2,3,4,5,6 delims=-" %%i in (%filename%) do (
   echo title:%%i
   set duration=%%k
   set fps=%%l
   set bitrate=%%m
   set ext=%%n
   call :ProcessTitle %%j
)
goto:eof

:ProcessTitle
set size="%1"
for /F "tokens=1,2 delims=x" %%i in (%size%) do (
   echo w:%%i
   echo h:%%j
   set width=%%i
   set height=%%j
)
goto:eof

:End