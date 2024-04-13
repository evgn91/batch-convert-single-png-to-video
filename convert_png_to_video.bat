::Warning! ffmpeg is required for this script to work
@ echo off
setlocal enabledelayedexpansion

chcp 65001

set /P forceOverwrite=Do you wish to force overwrite existing video files (Y/[N])?

if !forceOverwrite! == Y set forceOverwrite=1
if !forceOverwrite! == y set forceOverwrite=1
if !forceOverwrite! == N set forceOverwrite=0
if !forceOverwrite! == n set forceOverwrite=0

set /P removePNG=Do you wish to remove png files after completion (Y/[N])?

if !removePNG! == Y set removePNG=1
if !removePNG! == y set removePNG=1
if !removePNG! == N set removePNG=0
if !removePNG! == n set removePNG=0

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
   ) else if !ext! == xvid (
      call :xvid "%%F"
   ) else if !ext! == mov (
      call :mov "%%F"
   )
   if !removePNG! == 1 del "%%F"
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
if !forceOverwrite! == 1 (ffmpeg -y -loop 1 -i "%~d1%~p1%~n1%~x1" -t !duration:~0,-1! -pix_fmt yuv420p -vf scale=!width!:!height! -r !fps:~0,-3! -b:v !bitrate:~0,-4!k -c:v mpeg2video -qscale:v 2 "%~d1%~p1%~n1.mpg") else (
   ffmpeg -loop 1 -i "%~d1%~p1%~n1%~x1" -t !duration:~0,-1! -pix_fmt yuv420p -vf scale=!width!:!height! -r !fps:~0,-3! -b:v !bitrate:~0,-4!k -c:v mpeg2video -qscale:v 2 "%~d1%~p1%~n1.mpg")
goto:eof

:mp4
if !forceOverwrite! == 1 (ffmpeg -y -loop 1 -i "%~d1%~p1%~n1%~x1" -c:v libx264 -t !duration:~0,-1! -pix_fmt yuv420p -vf scale=!width!:!height! -r !fps:~0,-3! -b:v !bitrate:~0,-4!k -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" "%~d1%~p1%~n1.mp4") else (
   ffmpeg -loop 1 -i "%~d1%~p1%~n1%~x1" -c:v libx264 -t !duration:~0,-1! -pix_fmt yuv420p -vf scale=!width!:!height! -r !fps:~0,-3! -b:v !bitrate:~0,-4!k -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" "%~d1%~p1%~n1.mp4")
goto:eof

:avi
if !forceOverwrite! == 1 (ffmpeg -y -loop 1 -i "%~d1%~p1%~n1%~x1" -c:v libx264 -t !duration:~0,-1! -pix_fmt yuv420p -vf scale=!width!:!height! -r !fps:~0,-3! -b:v !bitrate:~0,-4!k  "%~d1%~p1%~n1.avi") else (
   ffmpeg -loop 1 -i "%~d1%~p1%~n1%~x1" -c:v libx264 -t !duration:~0,-1! -pix_fmt yuv420p -vf scale=!width!:!height! -r !fps:~0,-3! -b:v !bitrate:~0,-4!k  "%~d1%~p1%~n1.avi")
goto:eof

:xvid
if !forceOverwrite! == 1 (ffmpeg -y -loop 1 -i "%~d1%~p1%~n1%~x1" -c:v mpeg4 -vtag xvid -t !duration:~0,-1! -pix_fmt yuv420p -vf scale=!width!:!height! -r !fps:~0,-3! -b:v !bitrate:~0,-4!k  "%~d1%~p1%~n1.avi") else (
   ffmpeg -loop 1 -i "%~d1%~p1%~n1%~x1" -c:v mpeg4 -vtag xvid -t !duration:~0,-1! -pix_fmt yuv420p -vf scale=!width!:!height! -r !fps:~0,-3! -b:v !bitrate:~0,-4!k  "%~d1%~p1%~n1.avi")
goto:eof

:mov
if !forceOverwrite! == 1 (ffmpeg -y -loop 1 -i "%~d1%~p1%~n1%~x1" -c:v libx264 -t !duration:~0,-1! -pix_fmt yuv420p -vf scale=!width!:!height! -r !fps:~0,-3! -b:v !bitrate:~0,-4!k -f mov  "%~d1%~p1%~n1.mov") else (
   ffmpeg -loop 1 -i "%~d1%~p1%~n1%~x1" -c:v libx264 -t !duration:~0,-1! -pix_fmt yuv420p -vf scale=!width!:!height! -r !fps:~0,-3! -b:v !bitrate:~0,-4!k -f mov  "%~d1%~p1%~n1.mov")
goto:eof

:End