package hpic.recardify.recardify;

import androidx.annotation.NonNull;
import java.util.List;
public class Idea {
    public List<String> materialsNeeded, steps, imagesBase64;
    public int timeForCrafting, boxSize, rating, timesRated;
    public String title;
    public Idea() {} // default construct is necessary

    public Idea(String title, int timeForCrafting, int boxSize, int rating, int timesRated, List<String> materialsNeeded, List<String> steps, List<String> imagesBase64) {
        this.title = title;
        this.timeForCrafting = timeForCrafting;
        this.boxSize = boxSize;
        this.rating = rating;
        this.timesRated = timesRated;
        this.steps = steps;
        this.materialsNeeded = materialsNeeded;
        this.imagesBase64 = imagesBase64;
    }

    @NonNull
    public String toString() {
        return this.title + "\n" + this.timeForCrafting + "\n" + this.boxSize + "\n" + this.rating + "\n" + this.timesRated + "\n" + this.materialsNeeded + "\n" + this.steps + "\n" + this.imagesBase64 + "\n";
    }
}