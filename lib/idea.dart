class Idea {
    late int timeForCrafting, boxSize;
    late String title;
    late List<String> steps, materialsNeeded, imagesBase64;

    Idea({required this.title, required this.timeForCrafting, required this.boxSize, required this.materialsNeeded, required this.steps, required this.imagesBase64});

    Map<String, dynamic> toJson() {
        return {
            'title': title,
            'timeForCrafting': timeForCrafting,
            'boxSize': boxSize,
            'materialsNeeded': materialsNeeded,
            'steps': steps,
            'imagesBase64': imagesBase64
        };
    }

    factory Idea.fromJson(Map<String, dynamic> map) {
        return Idea(
            title: map['title'],
            timeForCrafting: map['timeForCrafting'],
            boxSize: map['boxSize'],
            materialsNeeded: List<String>.from(map['materialsNeeded']),
            steps: List<String>.from(map['steps']),
            imagesBase64: List<String>.from(map['imagesBase64'])
        );
    }
}