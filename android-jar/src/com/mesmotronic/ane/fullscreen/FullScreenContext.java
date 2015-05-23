/*
Copyright (c) 2015, Mesmotronic Limited
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
	
  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
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

package com.mesmotronic.ane.fullscreen;

import java.util.HashMap;
import java.util.Map;

import android.view.ActionMode;
import android.view.ActionMode.Callback;
import android.view.KeyEvent;
import android.view.Menu;
import android.view.MenuItem;
import android.view.MotionEvent;
import android.view.View;
import android.view.View.OnFocusChangeListener;
import android.view.Window;
import android.view.WindowManager;
import android.view.WindowManager.LayoutParams;
import android.view.accessibility.AccessibilityEvent;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.mesmotronic.ane.fullscreen.functions.LeanModeFunction;
import com.mesmotronic.ane.fullscreen.functions.ImmersiveHeightFunction;
import com.mesmotronic.ane.fullscreen.functions.ImmersiveModeFunction;
import com.mesmotronic.ane.fullscreen.functions.ImmersiveWidthFunction;
import com.mesmotronic.ane.fullscreen.functions.InitFunction;
import com.mesmotronic.ane.fullscreen.functions.IsImmersiveModeSupportedFunction;
import com.mesmotronic.ane.fullscreen.functions.ShowSystemUiFunction;
import com.mesmotronic.ane.fullscreen.functions.ShowUnderSystemUiFunction;

public class FullScreenContext extends FREContext 
{
	private Window.Callback _windowCallback;
	private OnFocusChangeListener _onFocusChangeListener; 
	
	@Override
	public void dispose() 
	{
		// Not required
	}
	
	@Override
	public Map<String, FREFunction> getFunctions() 
	{
		Map<String, FREFunction> functions = new HashMap<String, FREFunction>();
		
		functions.put("init", new InitFunction());
		functions.put("leanMode", new LeanModeFunction());
		functions.put("immersiveMode", new ImmersiveModeFunction());
		functions.put("immersiveHeight", new ImmersiveHeightFunction());
		functions.put("immersiveWidth", new ImmersiveWidthFunction());
		functions.put("isImmersiveModeSupported", new IsImmersiveModeSupportedFunction());
		functions.put("showSystemUI", new ShowSystemUiFunction());
		functions.put("showUnderSystemUI", new ShowUnderSystemUiFunction());
		
		return functions;
	}
	
	public Window getWindow()
	{
		return getActivity().getWindow();
	}
	
	public Window.Callback getWindowCallback()
	{
		if (_windowCallback == null)
		{
			final Window.Callback windowCallback = getWindow().getCallback();
			
			_windowCallback = new Window.Callback()
			{
				@Override
				public ActionMode onWindowStartingActionMode(Callback callback) 
				{
					return windowCallback.onWindowStartingActionMode(callback);
				}
				
				@Override
				public void onWindowFocusChanged(boolean hasFocus) 
				{
					String type = hasFocus
						? "androidWindowFocusIn"
						: "androidWindowFocusOut";
					
					dispatchStatusEventAsync(type, "");
					
					windowCallback.onWindowFocusChanged(hasFocus);
				}
				
				@Override
				public void onWindowAttributesChanged(LayoutParams attrs) 
				{
					windowCallback.onWindowAttributesChanged(attrs);
				}
				
				@Override
				public boolean onSearchRequested() 
				{
					return windowCallback.onSearchRequested();
				}
				
				@Override
				public boolean onPreparePanel(int featureId, View view, Menu menu) 
				{
					return windowCallback.onPreparePanel(featureId, view, menu);
				}
				
				@Override
				public void onPanelClosed(int featureId, Menu menu)
				{
					windowCallback.onPanelClosed(featureId, menu);
				}
				
				@Override
				public boolean onMenuOpened(int featureId, Menu menu) 
				{
					return windowCallback.onMenuOpened(featureId, menu);
				}
				
				@Override
				public boolean onMenuItemSelected(int featureId, MenuItem item) 
				{
					return windowCallback.onMenuItemSelected(featureId, item);
				}
				
				@Override
				public void onDetachedFromWindow() 
				{
					windowCallback.onDetachedFromWindow();
				}
				
				@Override
				public View onCreatePanelView(int featureId) 
				{
					return windowCallback.onCreatePanelView(featureId);
				}
				
				@Override
				public boolean onCreatePanelMenu(int featureId, Menu menu) 
				{
					return windowCallback.onCreatePanelMenu(featureId, menu);
				}
				
				@Override
				public void onContentChanged()
				{
					windowCallback.onContentChanged();
				}
				
				@Override
				public void onAttachedToWindow() 
				{
					windowCallback.onAttachedToWindow();
				}
				
				@Override
				public void onActionModeStarted(ActionMode mode)
				{
					windowCallback.onActionModeStarted(mode);
				}
				
				@Override
				public void onActionModeFinished(ActionMode mode) 
				{
					windowCallback.onActionModeFinished(mode);
				}
				
				@Override
				public boolean dispatchTrackballEvent(MotionEvent event) 
				{
					return windowCallback.dispatchTrackballEvent(event);
				}
				
				@Override
				public boolean dispatchTouchEvent(MotionEvent event) 
				{
					return windowCallback.dispatchTouchEvent(event);
				}
				
				@Override
				public boolean dispatchPopulateAccessibilityEvent(AccessibilityEvent event) 
				{
					return windowCallback.dispatchPopulateAccessibilityEvent(event);
				}
				
				@Override
				public boolean dispatchKeyShortcutEvent(KeyEvent event) 
				{
					return windowCallback.dispatchKeyShortcutEvent(event);
				}
				
				@Override
				public boolean dispatchKeyEvent(KeyEvent event) 
				{
					return windowCallback.dispatchKeyEvent(event);
				}
				
				@Override
				public boolean dispatchGenericMotionEvent(MotionEvent event) 
				{
					return windowCallback.dispatchGenericMotionEvent(event);
				}
			};
		}
		
		return _windowCallback;
	}
	
	public View.OnFocusChangeListener getOnFocusChangeListener()
	{
		if (_onFocusChangeListener == null)
		{
			_onFocusChangeListener = getDecorView().getOnFocusChangeListener();
		}
		
		return _onFocusChangeListener; 
	}
	
	public View getDecorView()
	{
		return getWindow().getDecorView();
	}
	
	public void setSystemUiVisibility(int visibility)
	{
		getDecorView().setSystemUiVisibility(visibility);
	}
	
	public void init()
	{
		getWindow().setCallback(getWindowCallback()); 
	}
	
	/**
	 * Resets UI and window handlers to default state 
	 */
	public void resetUi()
	{
		final View decorView = getDecorView();
		
		decorView.setOnFocusChangeListener(getOnFocusChangeListener());
		decorView.setOnSystemUiVisibilityChangeListener(null);
		
		init(); 
		
		setSystemUiVisibility(View.SYSTEM_UI_FLAG_VISIBLE);
	}
}
