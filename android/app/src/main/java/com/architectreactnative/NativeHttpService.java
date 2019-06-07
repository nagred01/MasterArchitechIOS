package com.architectreactnative;

import android.text.TextUtils;

import com.facebook.react.ReactPackage;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.uimanager.ViewManager;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.CookieManager;
import java.net.HttpCookie;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Nullable;

public class NativeHttpService extends ReactContextBaseJavaModule {
    static HttpService httpService;
    private final ReactApplicationContext _reactContext;
    public NativeHttpService(ReactApplicationContext reactContext) {
        super(reactContext);
        httpService = HttpService.GetInstance();
        this._reactContext = reactContext;
    }

    @ReactMethod
     public void isdebug(final Promise promise){
        promise.resolve(httpService.IsDebugModeEnabled());
    }

    @ReactMethod
    public void get(String requestURL, String requestToken,  Promise promise){
        final Promise returnedPromise = promise;
        httpService.get(requestURL, requestToken, new Callback() {
            @Override
            public void invoke(Object... args) {
                returnedPromise.resolve(args[0]);
            }
        }, new Callback() {
            @Override
            public void invoke(Object... args) {
                if(args.length > 0)
                    returnedPromise.reject("NetworkError", args[0].toString());
            }
        });
    }

    @Override
    public String getName() {
        return "NativeHttpService";
    }

}

