//package com.architectreactnative;
//
//import com.facebook.react.bridge.Promise;
//import com.facebook.react.bridge.ReactApplicationContext;
//import com.facebook.react.bridge.ReactContextBaseJavaModule;
//import com.facebook.react.bridge.ReactMethod;
//
//public class PortalModule extends ReactContextBaseJavaModule {
//    private Portal mPortal = new Portal(null);
//    public PortalModule(ReactApplicationContext reactContext) {
//        super(reactContext);
//    }
//
//    @Override
//    public String getName() {
//        return "Portal Module";
//    }
//
//    @Override
//    public void initialize() {
//        super.initialize();
//        mPortal.execute();
//    }
//
//    @ReactMethod
//    public void GetAndroidBundle(Promise promise){
//        try{
//            if(mPortal.getAndroidBundle() != null ) {
//                promise.resolve(mPortal.getAndroidBundle());
//            }
//        }catch(Exception e) {
//            promise.reject(e);
//        }
//    }
//}
