@echo off

xcopy ..\jar\bin\fullscreen-ane-jar.jar android /Y

call "C:\Program Files\Adobe\Adobe Flash Builder 4.7 (64 Bit)\sdks\4.16.1 AIR33\bin\adt" ^
 -package ^
 -target ane ./AndroidFullScreen.ane extension.xml ^
 -swc ../swc/bin/fullscreen-ane-swc.swc ^
 -platform Android-ARM -C android . ^
 -platform Android-ARM64 -C android . ^
 -platform Android-x86 -C android . ^
 -platform default -C default . 
