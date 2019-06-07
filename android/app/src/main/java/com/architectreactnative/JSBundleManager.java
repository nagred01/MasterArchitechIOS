//package com.architectreactnative;
//
//import android.app.Application;
//import android.content.res.AssetManager;
//import android.os.AsyncTask;
//import android.os.Handler;
//import android.support.annotation.NonNull;
//import android.support.annotation.Nullable;
//import android.text.TextUtils;
//import android.util.Log;
//
//import org.json.JSONException;
//import org.json.JSONObject;
//
//import java.io.BufferedInputStream;
//import java.io.BufferedReader;
//import java.io.ByteArrayInputStream;
//import java.io.DataOutputStream;
//import java.io.File;
//import java.io.FileInputStream;
//import java.io.IOException;
//import java.io.InputStream;
//import java.io.InputStreamReader;
//import java.net.CookieManager;
//import java.net.HttpCookie;
//import java.net.HttpURLConnection;
//import java.net.URISyntaxException;
//import java.net.URL;
//import java.security.NoSuchAlgorithmException;
//import java.util.List;
//import java.util.Map;
//
//
//public class JSBundleManager {
//
//    private static final String TAG = "JSBundleManager";
//
//    private static final String PROP_FILENAME = "filename";
//    private static final String PROP_VERSION_NAME = "version_name";
//    private static final String PROP_CHECKSUM_MD5 = "checksum_md5";
//    private static final String TIMESTAMP = "timestamp";
//
//    private final String mBundleAssetName;
//    private final String mMetadataName;
//    private final String mRequestPath;
//    private final AssetManager mAssetManager;
//    private final Callback mCallback;
//    private final Boolean mEnabled;
//    private final File assetDir;
//    private final File tmpDir;
//
//    private final String mPortalUrl;
//    private final String mMetadataApi;
//
//    JSBundleManager(@NonNull String bundleAssetName, @NonNull String metadataName, @NonNull String requestPath,
//                    @NonNull File cacheDir, @NonNull AssetManager assetManager,
//                    @Nullable Callback callback, @Nullable Boolean enabled,
//                    @NonNull String portalUrl, @NonNull String metadataApi) {
//
//        mBundleAssetName = bundleAssetName;
//        mMetadataName = metadataName;
//        mRequestPath = requestPath;
//        mAssetManager = assetManager;
//        mCallback = callback == null ? new CallBackImpl() : callback;
//        mEnabled = enabled;
//
//        assetDir = new File(cacheDir, "assets");
//        tmpDir = new File(cacheDir, "tmp");
//        mPortalUrl = portalUrl;
//        mMetadataApi = metadataApi;
//    }
//
//    public String getJSBundleFile(Application
//                                  app) {
//
//        File assetFile = new File(assetDir, mBundleAssetName);
//
//        // Toast toast2 = Toast.makeText(app.getApplicationContext(),
//        //         "From Application taken from ",
//        //         Toast.LENGTH_SHORT);
//        // toast2.show();
//
//        if (assetFile.exists()) {
//            File metadataFile = new File(assetDir, mMetadataName);
//
//
//            if (metadataFile.exists()) {
//                try {
//                    JSONObject metadata = new JSONObject(IOHelpers.getStringFromFile(metadataFile));
//
//                    //Toast toast23= Toast.makeText(app.getApplicationContext(),
//                    //        assetFile.getAbsolutePath(),
//                    //        Toast.LENGTH_SHORT);
//                    //toast23.show();
//
//                   // if (BuildConfig.VERSION_NAME.equals(metadata.getString(PROP_VERSION_NAME))) {
//                        //if (mCallback != null) {
//                            mCallback.onCached();
//                        //}
//
//                        return assetFile.getAbsolutePath();
//                  //  }
//                    //Log.d(TAG, "Deleting obsolete cache");
//                    //IOHelpers.deleteDirectory(assetDir);
//                } catch (IOException | JSONException e) {
//                    Log.e(TAG, "Error reading metadata", e);
//                }
//            }
//        }
//
//
////        Toast toast23= Toast.makeText(app.getApplicationContext(),
////                "Return",
////                Toast.LENGTH_SHORT);
////        toast23.show();
//        return "assets://" + mBundleAssetName;
//    }
//
//    public JSBundleManager checkUpdate() {
//        if (mEnabled == null || mEnabled) {
//            (new AsyncTask<Void, Void, Void>() {
//                @Override
//                protected Void doInBackground(Void... voids) {
//                    checkAndDownloadUpdate();
//
//                    return null;
//                }
//            }).execute();
//        }
//
//        return this;
//    }
//
//    public JSBundleManager checkUpdate(long delay) {
//        final Handler handler = new Handler();
//
//        handler.postDelayed(new Runnable() {
//            @Override
//            public void run() {
//                checkUpdate();
//            }
//        }, delay);
//
//        return this;
//    }
//
//    private boolean shouldDownloadBundle(JSONObject metadata) throws IOException, JSONException, NoSuchAlgorithmException {
//        InputStream in;
//        File assetFile = new File(assetDir, mBundleAssetName);
//
//        if (assetFile.exists()) {
//            in = new FileInputStream(assetFile);
//        } else {
//            in = mAssetManager.open(mBundleAssetName);
//        }
//
//        try {
//            // Check if MD5 has changed
//            String updateChecksum = metadata.getString(PROP_CHECKSUM_MD5);
//            String currentChecksum = Checksum.MD5(in);
//
//            if (updateChecksum.equals(currentChecksum)) {
//                Log.d(TAG, "Bundle is already up-to-date");
//
//                return false;
//            }
//        } finally {
//            in.close();
//        }
//
//        return true;
//    }
//
//    private InputStream downloadFile(@Nullable String downloadFileName) throws IOException {
//        URL url = new URL(mPortalUrl + "/" + downloadFileName);
//        return new BufferedInputStream(url.openStream());
//    }
//
////    private File downloadFile(String sourceFileName, @Nullable String downloadFileName) throws IOException {
////        URL url = new URL(mRequestPath + "/" + sourceFileName);
////        File file = new File(tmpDir, downloadFileName == null ? sourceFileName : downloadFileName);
////
////        Log.d(TAG, "Downloading " + url + " to " + file.getAbsolutePath());
////
////        return IOHelpers.saveStream(new BufferedInputStream(url.openStream()), file);
////    }
//
//    private JSONObject fetchMetadata() throws IOException, JSONException {
//        return new JSONObject(IOHelpers.getStringFromStream(downloadFile(mMetadataApi)));
//    }
//
//    private File downloadBundle(JSONObject metadata) throws IOException, JSONException, NoSuchAlgorithmException {
//        //File bundle = downloadFile(metadata.getString(PROP_FILENAME), mBundleAssetName);
//        return new File(assetDir, mBundleAssetName);
////        String fileName = metadata.getString(PROP_FILENAME);
////        InputStream bundle = downloadFile(fileName);
////        File bundleFile = new File(tmpDir, mBundleAssetName == null ? fileName : mBundleAssetName);
////        IOHelpers.saveStream(bundle, bundleFile);
////        Log.d(TAG, "Verifying downloaded bundle");
////
////        String updateChecksum = metadata.getString(PROP_CHECKSUM_MD5);
////        String currentChecksum = Checksum.MD5(bundle);
////
////        if (!updateChecksum.equals(currentChecksum)) {
////            throw new IOException("MD5 checksums don't match: " + updateChecksum + " != " + currentChecksum);
////        }
////
////        return bundleFile;
//    }
//
//    private CookieManager mCookieManager = new CookieManager();
//    static final String COOKIE_HEADER = "Set-Cookie";
//    private final String mUserAgent = "Mobile IOS 18.1;Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebLit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1";
//    private String mAntiForgeryToken = null;
//    private void portalLogin() throws IOException, JSONException, URISyntaxException {
//        URL url = new URL(mPortalUrl + "/api/Authentication/Login");
//        HttpURLConnection connection  = (HttpURLConnection) url.openConnection();
//        connection.setRequestMethod("POST");
//        connection.setDoOutput(true);
//        connection.setRequestProperty("Content-Type","application/json");
//        JSONObject postData = new JSONObject();
//        postData.put("loginName", "testuser");
//        postData.put("password","Asdf1234@");
//        DataOutputStream dr = new DataOutputStream(connection.getOutputStream());
//        dr.writeBytes(postData.toString());
//        dr.flush();dr.close();
//        BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
//        String line = null;
//        StringBuilder response = new StringBuilder();
//        while((line = reader.readLine())!= null){
//            response.append(line);
//        }
//        Map<String, List<String>> headerFields = connection.getHeaderFields();
//        List<String> cookiesHeader = headerFields.get(COOKIE_HEADER);
//
//        if(cookiesHeader != null    ){
//            for (String cookie : cookiesHeader){
//                mCookieManager.getCookieStore().add(null, HttpCookie.parse(cookie).get(0));
//            }
//        }
//
//        JSONObject tokenizer = new JSONObject(response.toString());
//        mAntiForgeryToken = tokenizer.getString("antiForgeryToken");
//    }
//
//    private String GetAndroidBundle() throws IOException {
//        return InvokeApi(mPortalUrl + "/api/Native/android");
//    }
//
//    private String GetPollyFill() throws IOException{
//        return InvokeApi(mPortalUrl + "/api/Native/pollyfill");
//    }
//
//    private String GetSystemJs() throws IOException{
//        return InvokeApi(mPortalUrl + "/api/Native/systemjs");
//    }
//
//    private String GetModuleBundle() throws IOException {
//        return InvokeApi(mPortalUrl + "/api/Native/ReactScript?pageName=Accounts%2FAccountSummary");
//    }
//    private String GetPortalBundle() throws IOException {
//        return InvokeApi(mPortalUrl  + "/ScriptRegistrar.aspx?bundle=Theme5Native");
//    }
//    private String InvokeApi(String apiUrl) throws IOException {
//        URL url = new URL(apiUrl);
//        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
//        connection.setRequestMethod("GET");
//        connection.setRequestProperty("X-CSRF-TOKEN",mAntiForgeryToken);
//        connection.setRequestProperty("User-Agent",mUserAgent);
//        if(mCookieManager.getCookieStore().getCookies().size() > 0 ){
//            connection.setRequestProperty("Cookie",
//                    TextUtils.join(";",mCookieManager.getCookieStore().getCookies()));
//        }
//        StringBuilder sb = new StringBuilder();
//        String line = null;
//        try {
//            BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream()));
//            while ((line = br.readLine()) != null) {
//                sb.append(line);
//                sb.append("\r\n");
//            }
//        }catch(IOException e){
//            Log.d(TAG, "InvokeApi: " + e.getMessage());
//            throw e;
//        }
//        return sb.toString();
//    }
//
//    public void checkAndDownloadUpdate() {
//        Log.d(TAG, "Checking for updates");
//        mCallback.onChecking();
//
//        try {
//            mCallback.onChecking();
//            JSONObject metadata = fetchMetadata();
//            File metadataFile = new File(assetDir, mMetadataName);
//            IOHelpers.saveStream(new ByteArrayInputStream(metadata.toString().getBytes()),metadataFile);
//            mCallback.onDownloading();
//            //Login
//            portalLogin();
//            //Get Android Bundle
//            String androidBundle = GetAndroidBundle();
//            //Get Pollyfill
//            String pollyFill = GetPollyFill();
//            //Get SystemJs
//            String systemJS =  GetSystemJs();
//            //Get Portal Bundle
//            String portalBundle = GetPortalBundle();
//            //Get Module Bundle
//            String moduleBundle = GetModuleBundle();
//            //String systemBootstrap = "\r\nSystem.import('IDS.Web.UI.React/ReactBootstrapper').then(module => {module}); console.log('this works')";
//            //String SystemJsContext = "var systemJsContext = new Function('require', sysjs);\r\nsystemJsContext(() => { return { runInThisContext: function(script){  debugger; eval(script) } } });";
//            //String bundle = SystemJsContext + "\r\nvar something=(() => alert('Hi'));\r\n" + androidBundle + "\r\ndebugger;\r\n";// + "\r\n" + moduleBundle + "\r\n" +  ";\r\nconsole.log('I did execute');";// + systemBootstrap;
//            //String bundle = "(function(global){ " + pollyFill + "\r\n" + systemJS + "\r\n});\r\n" + androidBundle + "\r\n" + systemBootstrap;
//            //String bundle = pollyFill + "\r\n" + systemJS + "\r\n" + androidBundle + "\r\n" + systemBootstrap;
//            String randomScript = "throw;\r\n(function(global){\r\n" +
//                    "'use strict'\r\n" +
//                    " global.somefunction = somefunction;\r\n"+
//                    "function somefunction (){\r\n" +
//                    "   reutrn 'Hi There';\r\n" +
//                    "}\r\n" +
//                    "})(typeof global !== 'undefined' ? global : typeof window !== undefined ? window : this);\r\n";
//            String bundle = randomScript+ "\r\n" + androidBundle ;
//            File bundleFile = new File(assetDir, mBundleAssetName);
//            InputStream bundleStream = new ByteArrayInputStream(bundle.getBytes());
//            IOHelpers.saveStream(bundleStream, bundleFile);
//            mCallback.onUpdateReady();
//            if (shouldDownloadBundle(metadata)) {
//                Log.d(TAG, "Update available");
//
//                if (mCallback != null) {
//                    mCallback.onDownloading();
//                }
//
//                downloadBundle(metadata);
//
//                //IOHelpers.deleteDirectory(assetDir);
//                //IOHelpers.copyFiles(tmpDir, assetDir);
//
//                Log.d(TAG, "Finished copying files");
//
//                if (mCallback != null) {
//                    mCallback.onUpdateReady();
//                }
//            } else {
//                if (mCallback != null) {
//                    mCallback.onNoUpdate();
//                }
//            }
//        } catch (IOException | JSONException  e) {
//            Log.e(TAG, "Error during update", e);
//
//            if (mCallback != null) {
//                mCallback.onError(e);
//            }
//        } catch (URISyntaxException e) {
//            e.printStackTrace();
//        } catch (NoSuchAlgorithmException e) {
//            e.printStackTrace();
//        } finally {
//            IOHelpers.deleteDirectory(tmpDir);
//        }
//    }
//
//    public interface Callback {
//        void onCached();
//
//        void onChecking();
//
//        void onDownloading();
//
//        void onError(Exception e);
//
//        void onNoUpdate();
//
//        void onUpdateReady();
//    }
//
//    public class CallBackImpl implements  Callback{
//
//        @Override
//        public void onCached() {
//
//        }
//
//        @Override
//        public void onChecking() {
//
//        }
//
//        @Override
//        public void onDownloading() {
//
//        }
//
//        @Override
//        public void onError(Exception e) {
//
//        }
//
//        @Override
//        public void onNoUpdate() {
//
//        }
//
//        @Override
//        public void onUpdateReady() {
//
//        }
//    }
//
//    public static class Builder {
//
//        private String mBundleAssetName;
//        private String mMetadataName;
//        private String mRequestPath;
//        private File mCacheDir;
//        private AssetManager mAssetmanager;
//        private Callback mCallback;
//        private Boolean mEnabled;
//
//        public Builder setBundleAssetName(@NonNull final String bundleAssetName) {
//            mBundleAssetName
//                    = bundleAssetName;
//
//            return this;
//        }
//
//        public Builder setMetadataName(@NonNull final String metadataName) {
//            mMetadataName = metadataName;
//
//            return this;
//        }
//
//        public Builder setRequestPath(@NonNull final String requestPath) {
//            mRequestPath = requestPath;
//
//            return this;
//        }
//
//        public Builder setCacheDir(@NonNull final File cacheDir) {
//            mCacheDir = cacheDir;
//
//            return this;
//        }
//
//        public Builder setAssetManager(@NonNull final AssetManager assetManager) {
//            mAssetmanager = assetManager;
//
//            return this;
//        }
//
//        public Builder setCallback(@Nullable final Callback callback) {
//            mCallback = callback;
//
//            return this;
//        }
//
//        public Builr setEnabled(@Nullable final Boolean enabled) {
//            mEnabled = enabled;
//
//            return this;
//        }
//
//        public JSBundleManager build() {
//            return new JSBundleManager(mBundleAssetName, mMetadataName, mRequestPath, mCacheDir, mAssetmanager, mCallback, mEnabled, mPortalUrl,
//                    mMetadataApi);
//        }
//
//        private String mPortalUrl;
//        public Builder setPortalUrl(@NonNull final String portalUrl){
//            mPortalUrl = portalUrl;
//
//            return this;
//        }
//        private String mMetadataApi;
//        public Builder setMetadataApi(@NonNull final String metadataApi){
//            mMetadataApi = metadataApi;
//
//            return this;
//        }
//
//        private String mScriptBundleUrl;
//        public Builder setScriptBundleUrl(@NonNull final String scriptBundleUrl){
//            mScriptBundleUrl = scriptBundleUrl;
//
//            return this;
//        }
//
//    }
//}