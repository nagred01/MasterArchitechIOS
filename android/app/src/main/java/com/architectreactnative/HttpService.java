package com.architectreactnative;

import android.content.SharedPreferences;
import android.text.TextUtils;
import android.util.Log;

import com.facebook.imagepipeline.producers.HttpUrlConnectionNetworkFetcher;
import com.facebook.react.bridge.Callback;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.CookieManager;
import java.net.HttpCookie;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.util.List;
import java.util.Map;

import okhttp3.OkHttpClient;

public class HttpService {
    private String mXcsrfToken;
    private CookieManager mCookieManager = new CookieManager();
    private final String mUserAgent = "Mobile IOS 18.1;Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebLit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1";
    private String mPortalServerIp = "192.168.1.14";
    private String mformatString =  "http://%1$s"; //DEV ONLY MODE.
    private String mPortalBase;
//    private final String mPortalBase =  "http://192.168.1.13/UI";
    static final String COOKIE_HEADER = "Set-Cookie";
    NativeEventEmitter mEmitter;
    private static HttpService _instance;
    private SharedPreferences mPrefs;
    String sharedKey = "com.architect.reactnative.antiforgery";
    private HttpService(){
        String.format(mformatString,mPortalServerIp);
    }

    static HttpService GetInstance(){
        if(_instance == null){
            _instance = new HttpService();
        }
        return _instance;
    }

    public String getAntiforgeryToken(){
        return mXcsrfToken;
    }

    public void setSharedPreferences(SharedPreferences prefs){
        mPrefs = prefs;
    }
    public void setServerIp(String ip){
        if(ip.trim().equals("")) throw new IllegalArgumentException("Please provide a valid Url");
        this.mPortalBase = String.format(mformatString, ip);
    }

    public void setEventEmitter(NativeEventEmitter emitter){
        mEmitter = emitter;
    }

    public boolean PortalLogin(String userName, String password) throws MalformedURLException, JSONException {
        try {
            URL url = new URL(mPortalBase + "/UI/api/Authentication/Login");
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setDoOutput(true);
            connection.setRequestProperty("Content-Type", "application/json");
            JSONObject postData = new JSONObject();
            postData.put("loginName", userName);
            postData.put("password", password);
            DataOutputStream dr = new DataOutputStream(connection.getOutputStream());
            dr.writeBytes(postData.toString());
            dr.flush();
            dr.close();
            BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            String line = null;
            StringBuilder response = new StringBuilder();
            while ((line = reader.readLine()) != null) {
                response.append(line);
            }
            Map<String, List<String>> headerFields = connection.getHeaderFields();
            List<String> cookiesHeader = headerFields.get(COOKIE_HEADER);

            if (cookiesHeader != null) {
                for (String cookie : cookiesHeader) {
                    mCookieManager.getCookieStore().add(null, HttpCookie.parse(cookie).get(0));
                }
            }

            JSONObject tokenizer = new JSONObject(response.toString());
            mXcsrfToken = tokenizer.getString("antiForgeryToken");
            mPrefs.edit().putString(sharedKey, mXcsrfToken).apply();

            return true;
        }catch(Exception ex){
            mXcsrfToken = mPrefs.getString(sharedKey,"");
            ex.printStackTrace();
            return false;
        }
    }

    private boolean mDebugMode = true;

    public boolean IsDebugModeEnabled() { return mDebugMode; }
    public void setDebugMode(boolean mode){
        mDebugMode = mode;
    }
    public void get(String requestUrl, String requestToken, Callback successCallback, Callback errorCallback) {
        try {
            HttpURLConnection connection = GetConnection(requestUrl,"GET", requestToken);
            successCallback.invoke(this.ReadResponse(connection));
        } catch (IOException ex){
            if(mEmitter != null){
                mEmitter.OnError(ex);
            }
            Log.e("HttpError", ex.getStackTrace().toString());
            errorCallback.invoke(ex);
        }
    }

    public String get(String requestUrl, String requestToken) throws IOException {
        try{
            if(!IsUrlWithHost(requestUrl)){
                requestUrl =  mPortalBase + requestUrl;
            }
            HttpURLConnection connection =  GetConnection(requestUrl,"GET", requestToken);
            return this.ReadResponse(connection);
        } catch (IOException e) {
            throw e;
        }
    }

    private boolean IsUrlWithHost(String url){
        return url.startsWith("http") || url.startsWith("https");
    }

    private String ReadResponse(HttpURLConnection connection) throws IOException {
        try {
            StringBuilder sb = new StringBuilder();
            int responseCode = connection.getResponseCode();
            BufferedReader reader;
            if(responseCode > 400 && responseCode <=510){
                reader = new BufferedReader(new InputStreamReader(connection.getErrorStream()));
            } else {
                reader =new BufferedReader(new InputStreamReader(connection.getInputStream()));
            }
            String line = null;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
                sb.append("\r\n");
            }
            return sb.toString();
        }catch (Exception ex){
            Log.e("ReadResponse", ex.getMessage(), ex   );
            throw ex;
        }
    }

    private HttpURLConnection GetConnection(String requestUrl, String method, String requestToken)
            throws IOException {
        if(!IsUrlWithHost(requestUrl)){
            requestUrl = mPortalBase + requestUrl;
        }
        URL url = new URL(requestUrl);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod(method);
        connection.setRequestProperty("X-CSRF-TOKEN", mXcsrfToken);
        connection.setRequestProperty("User-Agent",mUserAgent);
        if(requestToken != null && !requestToken.trim().equals("")){
            connection.setRequestProperty("X-Request-Token", requestToken);
        }
        if(mCookieManager.getCookieStore().getCookies().size()> 0){
            connection.setRequestProperty("Cookie",
                    TextUtils.join(";", mCookieManager.getCookieStore().getCookies()));
        }

        return connection;
    }

    public void post(String requestUrl, String requestToken, JSONObject data, Callback successCallback, Callback errorCallback){
        try {
            HttpURLConnection connection = GetConnection(requestUrl, "POST", requestToken);
            if(requestToken != null && !requestToken.trim().equals("")) {
                connection.addRequestProperty("X-Request-Token", requestToken);
            }
        }catch (IOException ex){
            errorCallback.invoke(ex.getMessage());
        }
    }
}
