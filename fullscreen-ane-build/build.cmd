@echo off

adt -package -target ane ../AndroidFullScreen.ane extension.xml -swc ../fullscreen-ane-andoid/bin/fullscreen-ane-andoid.swc -platform Android-ARM -C android . -platform default -C default . 
