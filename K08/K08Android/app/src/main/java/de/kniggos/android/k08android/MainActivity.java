package de.kniggos.android.k08android;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import org.w3c.dom.Text;

import java.time.Duration;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.PriorityQueue;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        final TextView resultText = findViewById(R.id.resultsText);

        Button clearResults = findViewById(R.id.clearResults);

        clearResults.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                resultText.setText("");
            }
        });


        Button startk08a = findViewById(R.id.startk08a);
        startk08a.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                for (int i = 0; i < 5; i++) {
                    Instant start = Instant.now();
                    fibonacci(40);
                    resultText.setText(resultText.getText() + "K08a finished, took " + Duration.between(start, Instant.now()).toMillis() + " ms\n");
                }
            }
        });


        Button startk08b = findViewById(R.id.startk08b);
        startk08b.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                int amountElements = 2000000;
                List<Integer> input = new ArrayList<>();
                for (int i = 0; i < amountElements; i += 2) {
                    input.add(i);
                }
                for (int i = 1; i < amountElements; i += 2) {
                    input.add(i);
                }
                for (int i = 0; i < 5; i++) {
                    Instant start = Instant.now();
                    PriorityQueue<Integer> pq = new PriorityQueue<>();
                    pq.addAll(input);
                    while (!pq.isEmpty()) {
                        pq.poll();
                    }
                    resultText.setText(resultText.getText() + "K08b finished, took " + Duration.between(start, Instant.now()).toMillis() + " ms\n");
                }


            }
        });

        Button startk08c1 = findViewById(R.id.startk08c1);
        startk08c1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                resultText.setText(resultText.getText() + "K08c1 Started at:  " + Instant.now().toEpochMilli() + "\n");
                Thread thread = new Thread() {
                    @Override
                    public void run() {
                        resultText.setText(resultText.getText() + "K08c1 Finished at:" + Instant.now().toEpochMilli() + "\n");
                    }
                };
                thread.start();

            }
        });

        Button startk08c2 = findViewById(R.id.startk08c2);
        startk08c2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                resultText.setText(resultText.getText() + "K08c2 Started at:  " + Instant.now().toEpochMilli() + "\n");

                for (int i = 0; i < 5; i++) {
                    Thread thread = new Thread() {
                        @Override
                        public void run() {
                            resultText.setText(resultText.getText() + "K08c2 Finished at:" + Instant.now().toEpochMilli() + "\n");
                        }
                    };
                    thread.start();
                }
            }
        });

        Button startk08c3 = findViewById(R.id.startk08c3);
        startk08c3.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                resultText.setText(resultText.getText() + "K08c3 Started at:  " + Instant.now().toEpochMilli() + "\n");

                for (int i = 0; i < 15; i++) {
                    Thread thread = new Thread() {
                        @Override
                        public void run() {
                            resultText.setText(resultText.getText() + "K08c3 Finished at:" + Instant.now().toEpochMilli() + "\n");
                        }
                    };
                    thread.start();
                }
            }
        });
    }

    int fibonacci(int a) {
        if (a == 1 || a == 2) {
            return 1;
        } else {
            return fibonacci(a - 1) + fibonacci(a - 2);
        }
    }
}
