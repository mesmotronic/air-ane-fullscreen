/*
Copyright (c) 2014, Mesmotronic Limited
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
	import flash.events.Event;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	public class AndroidFullScreen
	{
		static public const ANDROID_WINDOW_FOCUS_IN:String = 'androidWindowFocusIn';
		static public const ANDROID_WINDOW_FOCUS_OUT:String = 'androidWindowFocusOut';
		
		// Static initializer
		{
			init();
		}
		
		static private var context:ExtensionContext;
		
		static private function init():void
		{
			context = ExtensionContext.createExtensionContext('com.mesmotronic.ane.fullscreen', '');
			
			if (isSupported)
			{
				context.call('init');
				context.addEventListener(StatusEvent.STATUS, context_statusHandler);
			}
		}
		
		static public function get isSupported():Boolean
		{
			return !!context;
		}
		
		/**
		 * Hides the system status and navigation bars
		 * @return		Boolean		false if unsuccessful or not supported, otherwise true
		 */
		static public function leanMode():Boolean
		{
			if (!context) return false;
			return context.call('leanMode');
		}
		
		/**
		 * Puts your app into full screen immersive mode, hiding the system and 
		 * navigation bars. Users can show them by swiping from the top of the screen.
		 * 
		 * @return		Boolean		false if unsuccessful or not supported, otherwise true
		 */
		static public function immersiveMode(sticky:Boolean=true):Boolean
		{
			if (!context) return false;
			return context.call('immersiveMode', sticky);
		}
		
		/**
		 * The height of the screen in immersive mode, or 0 if immersive mode is not supported
		 * @return		int
		 */
		static public function get immersiveHeight():int
		{
			if (!context) return 0;
			return context.call('immersiveHeight') as int;
		}
		
		/**
		 * The width of the screen in immersive mode, or 0 if immersive mode is not supported
		 * @return		int
		 */
		static public function get immersiveWidth():int
		{
			if (!context) return 0;
			return context.call('immersiveWidth') as int;
		}
		
		/**
		 * Is immersive mode supported on this device? 
		 * 
		 * @return		Boolean		false if unsuccessful or not supported, otherwise true
		 */
		static public function get isImmersiveModeSupported():Boolean
		{
			if (!context) return false;
			return context.call('isImmersiveModeSupported');
		}
		
		/**
		 * Show the system status and navigation bars
		 * @return		Boolean		false if unsuccessful or not supported, otherwise true
		 */
		static public function showSystemUI():Boolean
		{
			if (!context) return false;
			return context.call('showSystemUI');
		}
		
		/**
		 * Extends your app underneath the status and navigation bar
		 * @return		Boolean		false if unsuccessful or not supported, otherwise true
		 */
		static public function showUnderSystemUI():Boolean
		{
			if (!context) return false;
			return context.call('showUnderSystemUI');
		}
		
		/**
		 * Dispatch status events from the ANE via the NativeApplication object
		 */
		private static function context_statusHandler(event:StatusEvent):void
		{
			NativeApplication.nativeApplication.dispatchEvent(new Event(event.code));
		}
	}
}
