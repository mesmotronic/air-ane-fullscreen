/*
Copyright (c) 2017, Mesmotronic Limited
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice, this
  list of conditions and the following disclaimer in the documentation and/or
  other materials provided with the distribution.
	
* Neither the name of the {organization} nor the names of its
  contributors may be used to endorse or promote products derived from
  this software without specific prior written permission.
	
  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 'AS IS' AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

package com.mesmotronic.ane
{
	import flash.desktop.NativeApplication;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	import flash.system.Capabilities;
	
	public class AndroidFullScreen
	{
		static public const ANDROID_WINDOW_FOCUS_IN:String = 'androidWindowFocusIn';
		static public const ANDROID_WINDOW_FOCUS_OUT:String = 'androidWindowFocusOut';
		
		static public const SYSTEM_UI_FLAG_FULLSCREEN:int = 4;
		static public const SYSTEM_UI_FLAG_HIDE_NAVIGATION:int = 2;
		static public const SYSTEM_UI_FLAG_IMMERSIVE:int = 2048;
		static public const SYSTEM_UI_FLAG_IMMERSIVE_STICKY:int = 4096;
		static public const SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN:int = 1024;
		static public const SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION:int = 512;
		static public const SYSTEM_UI_FLAG_LAYOUT_STABLE:int = 256;
		static public const SYSTEM_UI_FLAG_LIGHT_STATUS_BAR:int = 8192;
		static public const SYSTEM_UI_FLAG_LOW_PROFILE:int = 1;
		static public const SYSTEM_UI_FLAG_VISIBLE:int = 0;
		
		static public var stage:Stage;
		
		static private var context:ExtensionContext;
		
		// Static initializer
		{
			init();
		}
		
		static private function init():void
		{
			var isAndroid:Boolean = Capabilities.manufacturer.indexOf("Android")  > -1;
			
			if (isAndroid)
			{
				context = ExtensionContext.createExtensionContext('com.mesmotronic.ane.fullscreen', '');
				
				if (isSupported)
				{
					context.call('init');
					context.addEventListener(StatusEvent.STATUS, _statusHandler);
				}
				
			}
		}
		
		static public function get isSupported():Boolean
		{
			return !!context;
		}
		
		/**
		 * Switches to the best available full screen mode: immersive mode in Android 4.4+ or
		 * standard full screen mode for Android <4.4 or non-Android OS
		 * 
		 * @return		Boolean		true if the display state was changed, false if it wasn't
		 */
		static public function fullScreen():Boolean
		{
			if (!immersiveMode() || !_fullScreenDisplayState())
			{
				return false;
			}
			
			return true;
		}
		
		/**
		 * The width of the screen in the best available full screen mode
		 * @return		int
		 */
		static public function get fullScreenWidth():int
		{
			return immersiveWidth
				|| (stage ? stage.fullScreenWidth : Capabilities.screenResolutionX);
		}
		
		/**
		 * The height of the screen in the best available full screen mode
		 * @return		int
		 */
		static public function get fullScreenHeight():int
		{
			return immersiveHeight 
				|| (stage ? stage.fullScreenHeight : Capabilities.screenResolutionY);
		}
		
		/**
		 * Hides the system status and navigation bars
		 * @return		Boolean		false if unsuccessful or not supported, otherwise true
		 */
		static public function leanMode():Boolean
		{
			if (!isSupported) return false;
			
			_normalDisplayState();
			return context.call('leanMode');
		}
		
		/**
		 * Puts your app into full screen immersive mode, hiding the system and 
		 * navigation bars. Users can show them by swiping from the top of the screen.
		 * 
		 * @return		Boolean		false if unsuccessful or not supported, otherwise true
		 */
		static public function immersiveMode(sticky:Boolean=true, showUnderDisplayCutouts:Boolean=false):Boolean
		{
			if (!isImmersiveModeSupported) return false;
			
			_normalDisplayState();
			return context.call('immersiveMode', sticky, showUnderDisplayCutouts);
		}
		
		/**
		 * The width of the screen in immersive mode, or 0 if immersive mode is not supported
		 * @return		int
		 */
		static public function get immersiveWidth():int
		{
			if (!isSupported) return 0;
			return context.call('immersiveWidth') as int;
		}
		
		/**
		 * The height of the screen in immersive mode, or 0 if immersive mode is not supported
		 * @return		int
		 */
		static public function get immersiveHeight():int
		{
			if (!isSupported) return 0;
			return context.call('immersiveHeight') as int;
		}
		
		/**
		 * Is immersive mode supported on this device? 
		 * @return		Boolean		false if unsuccessful or not supported, otherwise true
		 */
		static public function get isImmersiveModeSupported():Boolean
		{
			if (!isSupported) return false;
			return context.call('isImmersiveModeSupported');
		}
		
		/**
		 * Proxy for Android's setSystemUiVisibility method
		 * @see			https://developer.android.com/reference/android/view/View.html#setSystemUiVisibility(int)
		 * @return		Boolean		false if unsuccessful or not supported, otherwise true
		 */
		static public function setSystemUiVisibility(visibility:int):Boolean
		{
			if (!isSupported) return false;
			return context.call('setSystemUiVisibility', visibility);
		}
		
		/**
		 * Show the system status and navigation bars
		 * @return		Boolean		false if unsuccessful or not supported, otherwise true
		 */
		static public function showSystemUI():Boolean
		{
			if (!isSupported)
			{
				return _normalDisplayState();
			}
			
			_normalDisplayState();
			return context.call('showSystemUI');
		}
		
		/**
		 * Extends your app underneath the status and navigation bar
		 * @return		Boolean		false if unsuccessful or not supported, otherwise true
		 */
		static public function showUnderSystemUI():Boolean
		{
			if (!isSupported) return false;
			
			_normalDisplayState();
			return context.call('showUnderSystemUI');
		}
		
		/**
		 * Dispatch status events from the ANE via the NativeApplication object
		 */
		private static function _statusHandler(event:StatusEvent):void
		{
			NativeApplication.nativeApplication.dispatchEvent(new Event(event.code));
		}
		
		/**
		 * Switches the app to NORMAL display state, primarily to resolve issues
		 * caused by users starting their app with <fullScreen>true</fullScreen>
		 * in app.xml 
		 */
		private static function _normalDisplayState():Boolean
		{
			if (stage.displayState != StageDisplayState.NORMAL)
			{
				if (stage) 
				{
					stage.displayState = StageDisplayState.NORMAL;
					return true;
				}
				
				return false;
			}
			
			return true;
		}
		
		/**
		 * Used as a fallback for Android <4.4 and non-Android apps
		 */
		private static function _fullScreenDisplayState():Boolean
		{
			if (stage.displayState == StageDisplayState.NORMAL)
			{
				if (stage) 
				{
					stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
					return true;
				}
				
				return false;
			}
			
			return true;
		}
	}
}
