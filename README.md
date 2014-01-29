Full Screen ANE for Adobe AIR
=============================

One of the most common complaints you hear from Adobe AIR developers is that they can't get true full screen on Android devices that use the on-screen navigation bar (the one that contains the back, home and task buttons), with full screen usually means that the buttons are simply replaced with a series of grey dots. 

If you're one of those developers, then this AIR Native Extension (ANE) may be the solution you've been looking for. 

How does it work?
-----------------

This ANE enables developers to offer the same true full screen experience you see in apps like YouTube in their own Adobe AIR apps, expanding the app right to the edges of the screen, hiding the status and navigation bars until the user next interacts.

This is ideally suited to video or cut-scene content.

Code example
------------

Using the ANE in your app couldn't be easier:

```as3
import com.mesmotronic.ane.fullscreen.AndroidFullScreen;

AndroidFullScreen.hideSystemUI();
```

If you want to include the ANE in a cross-platform app, you have two options for implementation:

```as3
if (!AndroidFullScreen.hideSystemUI())
{
    stage.displayMode = StageDisplayMode.FULL_SCREEN_INTERACTIVE;
}
```

or

```as3
if (AndroidFullScreen.isSupported)
{
    AndroidFullScreen.hideSystemUI();
}
else
{
    stage.displayMode = StageDisplayMode.FULL_SCREEN_INTERACTIVE;
}
```

What's next?
------------

In the future, we'll probably add more of Android's ImmersiveMode features, like enabling your app to appear behind the user's status and/or navigation bar.

License
-------

This project has been released under BSD license; see LICENSE for details.
