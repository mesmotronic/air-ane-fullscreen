Full Screen ANE for Adobe AIR
=============================

One of the most common complaints you hear from Adobe AIR developers is that they can't get true full screen on Android devices that have an on-screen navigation bar (the one that contains the back, home and task buttons), with full screen usually meaning that the buttons are simply replaced with a series of grey dots. 

If you're one of those developers, then this AIR Native Extension (ANE) may be the solution you've been looking for. 

Released under BSD license and requires Adobe AIR 13+.

Just give me the ANE!
---------------------

If you don't care about the source code and just want to download the latest, ready-built ANE, click the [releases link](https://github.com/mesmotronic/air-fullscreen-ane/releases) at the top of this project's page on GitHub.

How does it work?
-----------------

This ANE enables developers to offer users a true full screen experience in the Adobe AIR apps for Android.

Using Android 4.0+, you can use true full screen in "lean mode", the way you see in apps like YouTube, expanding the app right to the edges of the screen, hiding the status and navigation bars until the user next interacts. This is ideally suited to video or cut-scene content.

In Android 4.4+, however, you can now enter true full screen, fully interactive immersive mode. In this mode, your app will remain in true full screen until you choose otherwise; users can swipe down from the top of the screen to temporarily display the system UI.

If you need to fix it, fork it!
-------------------------------

This is a free, open-source project, so if you find the ANE doesn't work as you might like with a specific device, configuration or library you're using: fork it, fix it, let us know.

stage.displayState
------------------

Ensure that `stage.displayState = StageDisplayState.NORMAL` when using any method of this ANE to prevent Sprites and other DisplayObjects being cropped in the area where the navigation bar used to be.

Code example
------------

Using the ANE in your app couldn't be easier:

```as3
import com.mesmotronic.ane.AndroidFullScreen;

AndroidFullScreen.isSupported; // Is this ANE supported?
AndroidFullScreen.isImmersiveModeSupported; // Is immersive mode supported?
AndroidFullScreen.immersiveWidth; // The width of the screen in immersive mode
AndroidFullScreen.immersiveHeight; // The height of the screen in immersive mode

AndroidFullScreen.hideSystemUI(); // Hide system UI until user interacts
AndroidFullScreen.showSystemUI(); // Show system UI
AndroidFullScreen.showUnderSystemUI(); // Extend your app underneath the system UI (Android 4.4+ only)
AndroidFullScreen.immersiveMode(); // Hide system UI and keep it hidden (Android 4.4+ only)
AndroidFullScreen.immersiveMode(false); // Hide system UI until user swipes from top (Android 4.4+ only)
```

All methods return Boolean values: *true* if the action was successful, *false* if it wasn't (or isn't supported); if you're using the ANE in an app for a platform other than Android, all properties and methods will return false.

The `immersiveWidth` and `immersiveHeight` properties return the screen width and height available in immersive mode (or with the system UI hidden), or 0 if the ANE isn't supported.

Therefore, the simplest way to give users the best possible interactive full screen experience in your app is:

```as3
if (AndroidFullScreen.immersiveMode())
{
    stage.displayState = StageDisplayState.NORMAL;
}
else
{
    stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
}
```

An easy way to extend your app underneath the status and navigation bars is:

```as3
if (AndroidFullScreen.showUnderSystemUI())
{
    stage.displayState = StageDisplayState.NORMAL;
}
else
{
    stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
}
```

And a great way to offer full screen video playback is:

```as3
if (AndroidFullScreen.hideSystemUI())
{
    stage.displayState = StageDisplayState.NORMAL;
}
else
{
    stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
}
```

Getting the immersive screen size
---------------------------------

You can use the `immersiveWidth` and `immersiveHeight` properties to find out the dimensions of the screen with the system UI hidden, regardless of the current screen state.

To find out the stage size after calling `immersiveMode()` or `hideSystemUI()`, you must wait until the next `RESIZE` event before the `stage.stageWidth` and `stage.stageHeight` properties are updated; the properties of the `Capabilities` object are not updated and are therefore incorrect.

Starling
--------

To use this ANE with Starling,  add `Starling.handleLostContext = true;` at the start of your ActionScript code to prevent Stage3D lost context errors breaking your app when switching between the normal app state and true full screen.

License
-------

This project has been released under BSD license; see LICENSE for details.
