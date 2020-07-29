package de.kniggos.android.k11android;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class Main8Activity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main8);

        Button b = findViewById(R.id.buttonActivity8);
        b.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                changePage();
            }
        });
    }

    public void changePage() {
        Intent intent = new Intent(this, Main9Activity.class);
        startActivity(intent);
    }
}
