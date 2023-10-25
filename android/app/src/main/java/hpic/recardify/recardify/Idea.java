package hpic.recardify.recardify;

import androidx.annotation.NonNull;
import java.util.List;
public class Idea {
    public List<String> materialsNeeded, steps, imagesBase64;
    public int timeForCrafting, boxSize;
    public String title;
    public Idea() {} // default construct is necessary

    public Idea(String title, List<String> materialsNeeded, List<String> steps, List<String> imagesBase64, int timeForCrafting, int boxSize) {
        this.title = title;
        this.materialsNeeded = materialsNeeded;
        this.steps = steps;
        this.imagesBase64 = imagesBase64;
        this.timeForCrafting = timeForCrafting;
        this.boxSize = boxSize;
    }

    @NonNull
    public String toString() {
        return this.title + "\n" + this.timeForCrafting + "\n" + this.boxSize + "\n" + this.materialsNeeded + "\n" + this.steps + "\n" + this.imagesBase64 + "\n";
    }
}