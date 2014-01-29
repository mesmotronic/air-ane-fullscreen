Full Screen ANE for Adobe AIR
=============================

One of the most common complaints you hear from Adobe AIR developers is that they can't get true full screen on Android devices that use the on-screen navigation bar (the one that contains the back, home and task buttons), with full screen usually means that the buttons are simply replaced with a series of grey dots. 

If you're one of those developers, then this AIR Native Extension (ANE) may be the solution you've been looking for. 

How does it work?
-----------------

This ANE enables developers to offer the same true full screen experience you see in apps like YouTube in their Adobe AIR apps, expanding their app right to the edges of the screen by hiding the status and navigation bars until the user next interacts.

Code example
------------

```as3
import com.mesmotronic.ane.fullscreen.AndroidFullScreen;

AndroidFullScreen.hideSystemUI();
```

License
-------

This project has been released under BSD license; see LICENSE for details.
