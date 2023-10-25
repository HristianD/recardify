package hpic.recardify.recardify;

import io.flutter.embedding.android.FlutterActivity;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import com.google.firebase.database.ChildEventListener;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import com.google.firebase.database.ValueEventListener;
import com.google.gson.Gson;
import org.json.JSONException;
import org.json.JSONObject;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

public class MainActivity extends FlutterActivity {
    // Java and Dart communicate through channels
    private static final String CREATE_CHANNEL = "recardify.dev/submit-idea";
    private static final String FETCH_CHANNEL = "recardify.dev/fetch-ideas";
    private MethodChannel createMethodChannel, fetchMethodChannel;
    // DB connection
    private static final FirebaseDatabase DB = FirebaseDatabase.getInstance("https://recardify-7ea11-default-rtdb.europe-west1.firebasedatabase.app/");

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) throws RuntimeException {
        super.configureFlutterEngine(flutterEngine);
        this.createMethodChannel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CREATE_CHANNEL);
        this.createMethodChannel.setMethodCallHandler(
            (call, result) -> {
                if (call.method.equals("submitIdea")) {
                    System.out.println(call.arguments().toString());
                    Gson gson = new Gson();
                    Idea idea = gson.fromJson(call.arguments().toString(), Idea.class);
                    this.submitIdea(idea);
                    result.success(null);
                } else {
                    result.notImplemented();
                }
            }
        );
        this.fetchMethodChannel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), FETCH_CHANNEL);
        this.fetchMethodChannel.setMethodCallHandler(
            (call, result) -> {
                if (call.method.equals("fetchIdeas")) {
                    this.fetchIdeas();
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

    private void fetchIdeas() throws RuntimeException {
        DatabaseReference ideasRef = DB.getReference("ideas");
        Map<String, String> fetchedIdeas = new HashMap<>();
        Gson gson = new Gson();
        ideasRef.addListenerForSingleValueEvent(new ValueEventListener() {
            final JSONObject ideasJson = new JSONObject();
            @Override
            public void onDataChange(@NonNull DataSnapshot snapshot) {
                for (DataSnapshot idea : snapshot.getChildren()){
                    fetchedIdeas.put(idea.getKey(), ""); // taking advantage of hashing; we don't actually need any associated values
                    addToJsonObject(ideasJson, gson, idea);
                }
                fetchMethodChannel.invokeMethod("fetchedIdeas", ideasJson.toString());

                ideasRef.addChildEventListener(new ChildEventListener() {
                    @Override
                    public void onChildAdded(@NonNull DataSnapshot snapshot, @Nullable String previousChildName) {
                        final JSONObject newlyAddedIdeasJson = new JSONObject();
                        if (!fetchedIdeas.containsKey(snapshot.getKey())) {
                            fetchedIdeas.put(snapshot.getKey(), "");
                            addToJsonObject(newlyAddedIdeasJson, gson, snapshot);
                        }

                        if (newlyAddedIdeasJson.length() > 0) {
                            fetchMethodChannel.invokeMethod("attachListeners", newlyAddedIdeasJson.toString());
                        }
                    }

                    @Override
                    public void onChildChanged(@NonNull DataSnapshot snapshot, @Nullable String previousChildName) {

                    }

                    @Override
                    public void onChildRemoved(@NonNull DataSnapshot snapshot) {

                    }

                    @Override
                    public void onChildMoved(@NonNull DataSnapshot snapshot, @Nullable String previousChildName) {

                    }

                    @Override
                    public void onCancelled(@NonNull DatabaseError error) {
                        // error-handling
                    }
                });
            }

            @Override
            public void onCancelled(@NonNull DatabaseError error) {
                // error-handling
            }
        });
    }

    private void addToJsonObject(JSONObject ideasJson, Gson gson, DataSnapshot data) throws RuntimeException {
        try {
            ideasJson.put(Objects.requireNonNull(data.getKey()), gson.toJson(data.getValue()));
        } catch (JSONException e) {
            throw new RuntimeException(e);
        }
    }
}