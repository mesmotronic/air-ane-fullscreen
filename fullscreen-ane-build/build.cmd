@echo off

REM "C:\Program Files\Adobe\Adobe Flash Builder 4.7 (64 Bit)\sdks\4.6.0\bin\adt" ^

adt ^
 -package ^
 -target ane ./AndroidFullScreen.ane extension.xml ^
 -swc swc/fullscreen-ane-android.swc ^
 -platform Android-ARM -C android . ^
 -platform Android-x86 -C android . ^
 -platform default -C default . 
