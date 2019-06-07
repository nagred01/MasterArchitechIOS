package com.architectreactnative;

import android.annotation.SuppressLint;
import android.os.AsyncTask;
import android.text.TextUtils;
import android.util.Log;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.CookieManager;
import java.net.HttpCookie;
import java.net.HttpURLConnection;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.List;
import java.util.Map;

import static android.content.ContentValues.TAG;

public class Portal extends AsyncTask<Boolean, String, Void> {
    private HttpService mHttpService;
    private CookieManager mCookieManager = new CookieManager();
    private final String mUserAgent = "Mobile IOS 18.1;Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebLit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1";
    private String mAntiForgeryToken = null;
    private IAsyncEventNotifier mNotifier;
    private String mModuleBundle;
    private String mPortalBundle;

    public Portal(IAsyncEventNotifier notifier) {
        mNotifier = notifier != null ? notifier : new AsyncEventNotifierImpl();
        mHttpService = HttpService.GetInstance();
    }

    public String getModuleBundle() {
        return mModuleBundle ;//"var globalToken = '"+ mAntiForgeryToken +"';\r\nbaseUrl = \"http://192.168.43.245/\";" + mModuleBundle;
    }

    public String getPortalBundle(){
        return mPortalBundle;
    }
    private String GetModuleBundle() throws IOException{
        this.mModuleBundle = mHttpService.get("/UI/api/Native/Config?pageName=Accounts%2FAccountSummary",null);
        return mModuleBundle;
    }

    private String GetPortalBundle() throws IOException {
        this.mPortalBundle = mHttpService.get("/UI/api/Native/Bundle?platform=android",null);
        return mPortalBundle;
    }

    @Override
    protected Void doInBackground(Boolean... booleans) {
        if(booleans[0]) {
            publishProgress("Downloading Portal bundle");
            try {
                GetPortalBundle();
            } catch (IOException e) {
                e.printStackTrace();
            }
            publishProgress("Downloaded Portal bundle");
        }else{
            publishProgress("Skipping download portal bundle");
        }
        publishProgress("Downloading Module bundle");
        try {
            GetModuleBundle();
        } catch (IOException e) {
            e.printStackTrace();
        }
        publishProgress("Downloaded Module bundle");
        return null;
    }

    @Override
    protected void onPostExecute(Void aVoid) {
        this.mNotifier.Finished();
        super.onPostExecute(aVoid);
    }

    @Override
    protected void onProgressUpdate(String... values) {
        if (values.length > 0) {
            mNotifier.Notify(values[0]);
        }
        super.onProgressUpdate(values);
    }

    //Place holder class just in case a Notifier is not provided.
    private class AsyncEventNotifierImpl implements  IAsyncEventNotifier{

        @Override
        public void Notify(String message) {

        }

        @Override
        public void Finished() {

        }
    }

}

