@echo off

adt ^
 -package ^
 -target ane ./AndroidFullScreen.ane extension-x86.xml ^
 -swc ../fullscreen-ane-android/bin/fullscreen-ane-android.swc ^
 -platform Android-ARM -C android . ^
 -platform Android-x86 -C android . ^
 -platform default -C default . 
