package hpic.recardify.recardify;

import androidx.annotation.NonNull;
import java.util.List;
public class Idea {
    public List<String> materialsNeeded, steps;
    public int timeForCrafting, boxSize;
    public Idea() {} // default construct is necessary

    public Idea(List<String> materialsNeeded, List<String> steps, int timeForCrafting, int boxSize) {
        this.materialsNeeded = materialsNeeded;
        this.steps = steps;
        this.timeForCrafting = timeForCrafting;
        this.boxSize = boxSize;
    }

    @NonNull
    public String toString() {
        return this.timeForCrafting + "\n" + this.boxSize + "\n" + this.materialsNeeded + "\n" + this.steps + "\n";
    }
}