package hpic.recardify.recardify;

import io.flutter.embedding.android.FlutterActivity;
import androidx.annotation.NonNull;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import com.google.gson.Gson;

public class MainActivity extends FlutterActivity {
    // Java and Dart communicate through channels
    private static final String CREATE_CHANNEL = "recardify.dev/submit-idea";
    // DB connection
    private static final FirebaseDatabase DB = FirebaseDatabase.getInstance("https://recardify-7ea11-default-rtdb.europe-west1.firebasedatabase.app/");
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CREATE_CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("submitIdea")) {
                                Gson gson = new Gson();
                                Idea idea = gson.fromJson(call.arguments().toString(), Idea.class);
                                submitIdea(idea);
                                result.success(null);
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }

    private void submitIdea(Idea idea) {
        DatabaseReference ideasRef = DB.getReference("ideas");
        ideasRef.push().setValue(idea);
    }
}