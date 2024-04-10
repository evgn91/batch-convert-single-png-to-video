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

for /r %%F in (*.png) do (
   call :ProcessFile %%~nF
   if !ext! == mpg ( 
      call :mpeg2 "%%F"
   ) else if !ext! == mp4 ( 
      call :mp4 "%%F"
   ) else if !ext! == avi (
      call :avi "%%F"
   )
)
goto :End

:ProcessFile
set filename="%1"
for /F "tokens=1,2,3,4,5,6 delims=-" %%i in (%filename%) do (
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
   set width=%%i
   set height=%%j
)
goto:eof

:mpeg2
ffmpeg -loop 1 -i "%~d1%~p1%~n1%~x1" -t !duration:~0,-1! -pix_fmt yuv420p -vf scale=!width!:!height! -r !fps:~0,-3! -b:v !bitrate:~0,-4!k -c:v mpeg2video -qscale:v 2 "%~d1%~p1%~n1.mpg"
goto:eof

:mp4
ffmpeg -loop 1 -i "%~d1%~p1%~n1%~x1" -c:v libx264 -t !duration:~0,-1! -pix_fmt yuv420p -vf scale=!width!:!height! -r !fps:~0,-3! -b:v !bitrate:~0,-4!k  "%~d1%~p1%~n1.mp4"
goto:eof

:avi
ffmpeg -loop 1 -i "%~d1%~p1%~n1%~x1" -c:v libx264 -t !duration:~0,-1! -pix_fmt yuv420p -vf scale=!width!:!height! -r !fps:~0,-3! -b:v !bitrate:~0,-4!k  "%~d1%~p1%~n1.avi"
goto:eof

:End