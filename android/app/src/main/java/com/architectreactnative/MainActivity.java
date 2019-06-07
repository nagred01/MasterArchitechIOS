package com.architectreactnative;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.TextView;

import org.json.JSONException;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;

public class MainActivity extends AppCompatActivity implements IAsyncEventNotifier {

    private Portal mPortal=new Portal(this);

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_initialize_app);
        Button button  = (Button) findViewById(R.id.btnLogin);
        final CheckBox devMode = (CheckBox) findViewById(R.id.enableDevMode);
        final CheckBox downloadbundle = (CheckBox) findViewById(R.id.downloadBundle);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                new AsyncTask<Void, Integer, Void>() {

                    @Override
                    protected Void doInBackground(Void... voids) {
                        portalLogin();
                        return null;
                    }

                    @Override
                    protected void onPostExecute(Void aVoid) {
                        AlertDialog.Builder dialog = new AlertDialog.Builder(MainActivity.this);
                        if(devMode.isChecked()){
                            Intent intent = new Intent(MainActivity.this, ReactMainActivity.class);
                            intent.putExtra("dev", devMode.isChecked());
                            startActivity(intent);
                        } else{
                            mPortal.execute(downloadbundle.isChecked());
                        }
                    }
                }.execute();
            }
        });
    }

    @Override
    public void Notify(String message) {
      TextView textView = (TextView) findViewById(R.id.textView);
      textView.setText(message);
    }

    @Override
    public void Finished() {
        try{
            SaveFile();
            startActivity(new Intent(MainActivity.this, ReactMainActivity.class));
        }catch (IOException e){
            ((TextView)findViewById(R.id.textView)).setText(e.getMessage());
        }
    }

    private void SaveFile() throws IOException {
        CheckBox downloadBundle = (CheckBox) findViewById(R.id.downloadBundle);
        File bundleFile = new File(getCacheDir(),"android.bundle");
        String androidBundlePath = bundleFile.getAbsolutePath();
        if(downloadBundle.isChecked()) {
            IOHelpers.saveStream(new ByteArrayInputStream((mPortal.getPortalBundle() + "\r\n").getBytes()),bundleFile);
        }
        bundleFile = new File(getCacheDir(),"module.bundle");
        String moduleBundlePath = bundleFile.getAbsolutePath();
        IOHelpers.saveStream(new ByteArrayInputStream((mPortal.getModuleBundle() + "\r\n").getBytes()), bundleFile);
        //String finalBundle = mPortal.getPortalBundle() + "\r\n" + mPortal.getModuleBundle();
        bundleFile = new File(getCacheDir(), "index.android.bundle");
        //IOHelpers.saveStream(new ByteArrayInputStream(finalBundle.getBytes()), bundleFile);
        IOHelpers.sticthFiles(new String[]{androidBundlePath ,moduleBundlePath},bundleFile.getAbsolutePath());
    }

    public void portalLogin(){
        TextView loginName = (TextView) findViewById(R.id.loginName);
        TextView password = (TextView) findViewById(R.id.password);
        EditText serverip = (EditText)findViewById(R.id.serverIpAddress);
        CheckBox devMode = (CheckBox) findViewById(R.id.enableDevMode);

        HttpService service = HttpService.GetInstance();
        service.setDebugMode(devMode.isChecked());
        if(!serverip.getText().toString().equals("")) {
            service.setServerIp(serverip.getText().toString());
        }
        try {
            service.setSharedPreferences(this.getSharedPreferences("com.architect.reactnative", Context.MODE_PRIVATE));
            service.PortalLogin(loginName.getText().toString(), password.getText().toString());
        } catch (IOException e) {

            Log.e("error", e.getMessage());

        } catch (JSONException e) {

        }
    }
}
