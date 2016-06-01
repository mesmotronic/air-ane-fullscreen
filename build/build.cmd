@echo off

xcopy ..\jar\bin\fullscreen-ane-jar.jar android /Y
xcopy ..\jar\res android\res /S /E /I /Y

call adt ^
 -package ^
 -target ane ./AndroidFullScreen.ane extension.xml ^
 -swc ../swc/bin/fullscreen-ane-swc.swc ^
 -platform Android-ARM -C android . ^
 -platform Android-x86 -C android . ^
 -platform default -C default . 
