package de.kniggos.android.k06android;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

import java.time.Duration;
import java.time.Instant;

public class MainActivity extends AppCompatActivity {
    public boolean doRepeated = false;
    int repeatedCounter = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        final TextView resultText = findViewById(R.id.resultText);

        Button button1 = findViewById(R.id.button1);
        button1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startDownloadFile1(resultText);
            }
        });

        Button button2 = findViewById(R.id.button2);
        button2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startPing(resultText);
            }
        });

        Button button3 = findViewById(R.id.button3);
        button3.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startMultipleDownload(resultText);
            }
        });

        Button button4 = findViewById(R.id.button4);
        button4.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                doRepeated = true;
                startRepeatedDownload(resultText);
            }
        });

        Button button5 = findViewById(R.id.button5);
        button5.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                doRepeated = false;
                repeatedCounter = 0;
            }
        });
    }

    public void startDownloadFile1(final TextView resultText) {

        RequestQueue queue = Volley.newRequestQueue(this);
        queue.getCache().clear();
        final Instant startTime = Instant.now();
        String url = "http://192.168.178.61:8080/file1.data";
        // Request a string response from the provided URL.
        StringRequest stringRequest = new StringRequest(Request.Method.GET, url,
                new Response.Listener<String>() {
                    @Override
                    public void onResponse(String response) {

                        resultText.setText("Finished Downloading File1, took "+ Duration.between(startTime, Instant.now()).toMillis()+" ms");
                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                resultText.setText(error.toString());
            }
        });
        queue.add(stringRequest);
    }

    public void startPing(final TextView resultText) {

        RequestQueue queue = Volley.newRequestQueue(this);
        queue.getCache().clear();
        final Instant startTime = Instant.now();
        String url = "http://192.168.178.61:8080/ping.data";
        // Request a string response from the provided URL.
        StringRequest stringRequest = new StringRequest(Request.Method.GET, url,
                new Response.Listener<String>() {
                    @Override
                    public void onResponse(String response) {

                        resultText.setText("Finished Ping, took "+ Duration.between(startTime, Instant.now()).toNanos()/1000+" Microseconds");
                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                resultText.setText(error.toString());
            }
        });
        queue.add(stringRequest);
    }

    public void startMultipleDownload(final TextView resultText) {

        RequestQueue queue = Volley.newRequestQueue(this);
        queue.getCache().clear();
        final Instant startTime = Instant.now();
        for(int i=10;i<110;i++){
            String url = "http://192.168.178.61:8080/file"+i+".data";
            // Request a string response from the provided URL.
            StringRequest stringRequest = new StringRequest(Request.Method.GET, url,
                    new Response.Listener<String>() {
                        @Override
                        public void onResponse(String response) {
                            resultText.setText("Finished Download Multiple, took "+ Duration.between(startTime, Instant.now()).toMillis()+" ms");
                        }
                    }, new Response.ErrorListener() {
                @Override
                public void onErrorResponse(VolleyError error) {
                    resultText.setText(error.toString());
                }
            });
            queue.add(stringRequest);
        }
    }

    public void startRepeatedDownload(final TextView resultText) {
        if(!doRepeated){
            return;
        }
        RequestQueue queue = Volley.newRequestQueue(this);
        queue.getCache().clear();
        final Instant startTime = Instant.now();
        String url = "http://192.168.178.61:8080/file1.data";
        // Request a string response from the provided URL.
        StringRequest stringRequest = new StringRequest(Request.Method.GET, url,
                new Response.Listener<String>() {
                    @Override
                    public void onResponse(String response) {
                        repeatedCounter++;
                        resultText.setText("Finished Downloading File1 for "+repeatedCounter+" time");
                        startRepeatedDownload(resultText);
                    }
                }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
                resultText.setText(error.toString());
            }
        });
        queue.add(stringRequest);
    }
}
