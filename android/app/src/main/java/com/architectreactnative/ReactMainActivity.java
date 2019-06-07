package com.architectreactnative;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.util.Log;
import android.view.KeyEvent;

import com.facebook.react.ReactInstanceManager;
import com.facebook.react.ReactInstanceManagerBuilder;
import com.facebook.react.ReactRootView;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.common.LifecycleState;
import com.facebook.react.modules.core.DefaultHardwareBackBtnHandler;
import com.facebook.react.shell.MainReactPackage;
import com.learnium.RNDeviceInfo.RNDeviceInfo;
import com.oblador.vectoricons.VectorIconsPackage;
import com.swmansion.gesturehandler.react.RNGestureHandlerPackage;

import java.io.File;


public class ReactMainActivity extends Activity implements
        DefaultHardwareBackBtnHandler {

    private ReactRootView mReactRootView;
    private ReactInstanceManager mReactInstanceManager;
    private NativeEventEmitter mEmitter;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        Intent intent = getIntent();
        super.onCreate(savedInstanceState);
        Boolean Debug_mode = Boolean.parseBoolean(getString(R.string.debug_mode));

        boolean devMode = intent.getBooleanExtra("dev",false);

        mReactRootView = new ReactRootView(this);
        ReactInstanceManagerBuilder builder = ReactInstanceManager.builder()
                .setApplication(getApplication())
                .addPackage(new MainReactPackage())
                .addPackage(new PortalModules())
                .addPackage(new VectorIconsPackage())
                .addPackage(new RNGestureHandlerPackage())
                .addPackage(new RNDeviceInfo())
                .setUseDeveloperSupport(true)
                .setInitialLifecycleState(LifecycleState.RESUMED);

        if(Debug_mode || devMode){
            builder.setJSMainModulePath("index");
        }else {
            builder.setBundleAssetName("index.android.bundle")
            .setJSBundleFile(new File(getCacheDir(), "index.android.bundle").getAbsolutePath());
        }
        mReactInstanceManager = builder.build();
        mReactRootView.startReactApplication(mReactInstanceManager, "ArchitectReactNative", null);
        mEmitter = new NativeEventEmitter((ReactApplicationContext) mReactInstanceManager.getCurrentReactContext());
        HttpService.GetInstance().setEventEmitter(mEmitter);
        setContentView(mReactRootView);
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if((keyCode == KeyEvent.KEYCODE_BACK)){
            mEmitter.BackPressed((ReactApplicationContext) mReactInstanceManager.getCurrentReactContext());
        }
        return super.onKeyDown(keyCode, event);
    }

    @Override
    public void invokeDefaultOnBackPressed() {
        super.onBackPressed();
    }

    @Override
    protected void onPause() {
        super.onPause();
        Log.i("Pausing", "Paused app");
        if (mReactInstanceManager != null) {
            mReactInstanceManager.onHostPause(this);
        }
    }

    @Override
    protected void onResume() {
        super.onResume();
        Log.i("Resuming", "Resuming app");
        if (mReactInstanceManager != null) {
            mReactInstanceManager.onHostResume(this);
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        Log.i("Destryoing", "Destroyed app");
        if (mReactInstanceManager != null) {
            mReactInstanceManager.onHostDestroy(this);
        }
    }

    @Override
    public void onBackPressed() {
        if (mReactInstanceManager != null) {
            mReactInstanceManager.onBackPressed();
        } else {
            super.onBackPressed();
        }
    }

    @Override
    public boolean onKeyUp(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_MENU && mReactInstanceManager != null) {
            mReactInstanceManager.showDevOptionsDialog();
            return true;
        }
        return super.onKeyUp(keyCode, event);
    }
}

