Full Screen ANE for Adobe AIR
=============================

One of the most common complaints you hear from Adobe AIR developers is that they can't get true full screen on Android devices that have an on-screen navigation bar (the one that contains the back, home and task buttons), with full screen usually meaning that the buttons are simply replaced with a series of grey dots. 

If you're one of those developers, then this AIR Native Extension (ANE) may be the solution you've been looking for. 

Released under BSD license. Requires Adobe AIR 20+.

*If you only need immersive mode, we recommend using our [Immersive Mode ANE](https://github.com/mesmotronic/air-ane-immersivemode) instead.*

Just give me the ANE!
---------------------

If you don't care about the source code and just want to download the latest, ready-built ANE, click the [releases link](https://github.com/mesmotronic/air-ane-fullscreen/releases) at the top of this project's page on GitHub.

How does it work?
-----------------

This ANE enables developers to offer users a true full screen experience in the Adobe AIR apps for Android.

Using Android 4.0+, you can use true full screen in "lean mode", the way you see in apps like YouTube, expanding the app right to the edges of the screen, hiding the status and navigation bars until the user next interacts. This is ideally suited to video or cut-scene content.

In Android 4.4+, however, you can now enter true full screen, fully interactive immersive mode. In this mode, your app will remain in true full screen until you choose otherwise; users can swipe down from the top of the screen to temporarily display the system UI.

In addition, the `fullScreen()` method works on all mobile platforms supported by Adobe AIR, putting your app into the best available full screen mode: on Android 4.4+, it switches your app into [immersive mode](http://developer.android.com/training/system-ui/immersive.html), falling back to `FULL_SCREEN_INTERACTIVE` display state on earlier versions of Android and other mobile platforms.

Workaround for black bar on Android 6.0
---------------------------------------

A bug in Android 6.0 means some users see a black bar at the bottom of their screen when using this ANE. This issue is resolved in Android 6.0.1, but if you haven't received the upgrade yet, you can fix it by changing the stage orientation twice, for example:

```actionscript3
AndroidFullScreen.stage = stage;
AndroidFullScreen.fullScreen();
stage.setOrientation(StageOrientation.UPSIDE_DOWN);
stage.setOrientation(StageOrientation.UPSIDE_DOWN);
```

If you need to fix it, fork it!
-------------------------------

This is a free, open-source project, so if you find the ANE doesn't work as you might like with a specific device, configuration or library you're using: fork it, fix it, let us know.

Before you start
----------------

To avoid cropping, always ensure that you're using `<fullScreen>false</fullScreen>` in your `app.xml` and `stage.displayState` is set to `StageDisplayState.NORMAL` when using any of the full screen modes invoked by this ANE.

The examples below show how to achieve the best possible full screen experience.

Code example
------------

Using the ANE in your app couldn't be easier:

```as3
import com.mesmotronic.ane.AndroidFullScreen;

// Properties

AndroidFullScreen.stage = stage; // Set this to your app's stage

AndroidFullScreen.isSupported; // Is this ANE supported?
AndroidFullScreen.isImmersiveModeSupported; // Is immersive mode supported?
AndroidFullScreen.immersiveWidth; // The width of the screen in immersive mode
AndroidFullScreen.immersiveHeight; // The height of the screen in immersive mode
AndroidFullScreen.fullScreenWidth; // The width of the screen in the best available full screen mode
AndroidFullScreen.fullScreenHeight; // The height of the screen in the best available full screen mode

// Methods

AndroidFullScreen.fullScreen(); // Switch your app to the best available full screen mode
AndroidFullScreen.showSystemUI(); // Show system UI
AndroidFullScreen.leanMode(); // Hide system UI until user interacts
AndroidFullScreen.showUnderSystemUI(); // Extend your app underneath the system UI (Android 4.4+ only)
AndroidFullScreen.immersiveMode(); // Hide system UI and keep it hidden (Android 4.4+ only)
AndroidFullScreen.immersiveMode(false); // Hide system UI until user swipes from top (Android 4.4+ only)

// Example custom full screen mode

AndroidFullScreen.setSystemUiVisibility(AndroidFullScreen.SYSTEM_UI_FLAG_FULLSCREEN | AndroidFullScreen.SYSTEM_UI_FLAG_LOW_PROFILE);

// Events (will only work if ANE is supported)

NativeApplication.nativeApplication.addEventListener(AndroidFullScreen.ANDROID_WINDOW_FOCUS_IN, focusHandler);
NativeApplication.nativeApplication.addEventListene(AndroidFullScreen.ANDROID_WINDOW_FOCUS_OUT, focusHandler);

function focusHandler(event:Event):void
{
	trace(event.type);
} 

```

All methods return Boolean values: *true* if the action was successful, *false* if it wasn't (or isn't supported); if you're using the ANE in an app for a platform other than Android, all properties and methods will return false.

The `immersiveWidth` and `immersiveHeight` properties return the screen width and height available in immersive mode (or with the system UI hidden), or 0 if the ANE isn't supported.

Therefore, the simplest way to give users the best possible interactive full screen experience in your app is to start your app with `<fullScreen>false</fullScreen>` in your `app.xml` and use:

```as3
// ANE v1.4.0+ can automatically switch your app into the best available full screen mode

AndroidFullScreen.stage = stage;
AndroidFullScreen.fullScreen();

// ANE v1.3.x

if (!AndroidFullScreen.immersiveMode())
{
    stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
}
```

An easy way to extend your app underneath the status and navigation bars is:

```as3
if (!AndroidFullScreen.showUnderSystemUI())
{
    stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
}
```

And a great way to offer full screen video playback is:

```as3
if (!AndroidFullScreen.leanMode())
{
    stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
}
```

Getting the immersive screen size
---------------------------------

You can use the `immersiveWidth` and `immersiveHeight` properties to find out the dimensions of the screen with the system UI hidden, regardless of the current screen state.

To find out the stage size after calling `fullScreen()`, `immersiveMode()` or `leanMode()`, you must wait until the next `RESIZE` event before the `stage.stageWidth` and `stage.stageHeight` properties are updated; the properties of the `Capabilities` object are not updated and are therefore incorrect.

Starling
--------

To use this ANE with Starling,  add `Starling.handleLostContext = true;` at the start of your ActionScript code to prevent Stage3D lost context errors breaking your app when switching between the normal app state and true full screen.

License
-------

This project has been released under BSD license; see LICENSE for details.
