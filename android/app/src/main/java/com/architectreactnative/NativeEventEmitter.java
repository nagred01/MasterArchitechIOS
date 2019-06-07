package com.architectreactnative;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.modules.core.DeviceEventManagerModule;

import javax.annotation.Nonnull;

public class NativeEventEmitter extends ReactContextBaseJavaModule {

    private final ReactApplicationContext mReactContext;
    public NativeEventEmitter(@Nonnull ReactApplicationContext reactContext) {
        super(reactContext);
        mReactContext = reactContext;
    }

    public void BackPressed(ReactApplicationContext reactContext){
        if(reactContext != null){
            reactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
            .emit("backPressed","");
        }
    }

    public void OnError(Exception ex){
        if(mReactContext != null){
            StringBuilder builder = new StringBuilder();
            builder.append(ex.getMessage() + "\r\n");
            builder.append(ex.getStackTrace() + "\r\n");
            mReactContext.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                    .emit("exception", builder.toString());
        }
    }

    @Nonnull
    @Override
    public String getName() {
        return "eventEmitter";
    }
}
