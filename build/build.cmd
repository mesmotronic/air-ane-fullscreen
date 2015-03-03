@echo off

adt ^
 -package ^
 -target ane ./AndroidFullScreen.ane extension.xml ^
 -swc swc/fullscreen-ane-android.swc ^
 -platform Android-ARM -C android . ^
 -platform Android-x86 -C android . ^
 -platform default -C default . 
