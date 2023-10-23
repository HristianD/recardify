import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class CreateIdea extends StatefulWidget {
    const CreateIdea({super.key});

    @override
    State<StatefulWidget> createState() => _CreateIdeaState();
}

class _CreateIdeaState extends State<CreateIdea> {
    int _count = 1;
    static const _platform = MethodChannel('recardify.dev/submit-idea'); // communicate to java code
    static late List<StepWidget> _stepsList;
    static final _materialsController = TextEditingController();

    void _addStep() {
        // max steps count = 10
        if (_count == 10) {
            return;
        }

        setState(() {
            _count++;
        });
    }

    void _deleteStep() {
        // you cannot delete first step
        if (_count == 1) {
            return;
        }

        setState(() {
            _count--;
        });
    }

    void _collectData() {
        final idea = Idea(
            timeForCrafting: 20,
            boxSize: 2,
            materialsNeeded: <String>[],
            steps: <String>[]
        );

        _stepsList.forEach((widget) => idea.steps.add(widget.controller.text));
        // check first if there are any symbols other than plain text, commas or whitespaces
        // regex for that: [^A-Za-z, \t]
        String edited = _materialsController.text.replaceAll(RegExp(r'\s+(?:\s*,+\s*)*|,'), ',');
        if (edited[0] == ',') {
            edited = edited.substring(1, edited.length);
        }
        idea.materialsNeeded.add(edited);
        _submitIdea(idea.toJson());
    }

    Future<void> _submitIdea(Map<String, dynamic> idea) async {
        try {
            await _platform.invokeMethod('submitIdea', idea);
        } on PlatformException catch (e) {
            // pop-up for error
        }

        setState(() {
            // pop-up for success/error
        });
    }

    @override
    Widget build(BuildContext context) {
        _stepsList = List.generate(_count, (int i) => StepWidget(index: i + 1));
        return Scaffold(
            body: Center(
                child: ListView(
                    children: <Widget>[
                        Column(
                            children: <Widget>[
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center, // Center the children horizontally
                                    children: [
                                        Column(
                                            children: <Widget>[
                                                Container(
                                                    width: 150.0,
                                                    height: 150.0,
                                                    margin: const EdgeInsets.only(top: 30.0),
                                                    decoration: BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius:
                                                            BorderRadius.circular(10.0) // Rounded corners
                                                        ),
                                                    child: ElevatedButton(
                                                        onPressed: () {
                                                            // Add your button action here
                                                        },
                                                        style: ButtonStyle(
                                                            backgroundColor: MaterialStateProperty.all(Colors.transparent),
                                                            elevation: MaterialStateProperty.all(0) // No shadow
                                                        ),
                                                        child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: <Widget>[
                                                              IconButton(
                                                                  onPressed: () {
                                                                      // Add your button action here
                                                                  },
                                                                  icon: const Icon(Icons.add, size: 24.0, color: Colors.white)),
                                                                  const Text('Add Image')
                                                            ]
                                                        )
                                                    )
                                                )
                                            ]
                                        ),
                                        const SizedBox(
                                            width: 8.0
                                        ),
                                        Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                                const Text('Materials Needed', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                                SizedBox(
                                                    width: 180.0,
                                                    height: 100.0,
                                                    child: TextField(
                                                        controller: _materialsController,
                                                        decoration: InputDecoration(
                                                            labelText: 'Add Materials',
                                                            border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(10.0) // Rounded corners
                                                            )
                                                        )
                                                    )
                                                )
                                            ]
                                        )
                                    ]
                                ),
                                for (var step in _stepsList)
                                    step, // add step widgets
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                        IconButton(
                                            onPressed: () {
                                                _addStep();
                                            },
                                            icon: const Icon(Icons.add, size: 24.0, color: Colors.blue)
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                                _addStep();
                                            },
                                            child: const Text('Add Step')
                                        ),
                                        IconButton(
                                            onPressed: () {
                                                _deleteStep();
                                            },
                                            icon: const Icon(Icons.delete, size: 24.0, color: Colors.red)
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                                _deleteStep();
                                            },
                                            child: const Text('Remove Step')
                                        )
                                    ]
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue, // Set the button's background color to blue
                                        foregroundColor: Colors.white, // Set the text color to white
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), // Adjust the button's border radius
                                        elevation: 5, // Add a slight elevation to the button
                                    ),
                                    onPressed: () {
                                        _collectData();
                                    },
                                    child: const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                        child: Text('Submit',
                                            style: TextStyle(
                                                fontSize: 18.0, // Adjust the text size
                                                fontWeight: FontWeight.bold // Make the text bold
                                            )
                                        )
                                    )
                                ),
                                const Row(
                                    children: <Widget>[
                                        SizedBox(
                                            width: 10,
                                            height: 20
                                        )
                                    ]
                                )
                            ]
                        )
                    ]
                )
            )
        );
    }
}

class StepWidget extends StatelessWidget {
    final int index;
    StepWidget({super.key, required this.index});
    final TextEditingController controller = TextEditingController();

    @override
    Widget build(BuildContext context) {
        return Container(
            margin: const EdgeInsets.only(top: 16),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // Center the children horizontally
                children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            Text("Step $index", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Container(
                                width: 100.0,
                                height: 80.0,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10.0) // Rounded corners
                                    ),
                                child: ElevatedButton(
                                    onPressed: () {
                                       // Add your button action here
                                    },
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Colors.transparent),
                                        elevation: MaterialStateProperty.all(0) // No shadow
                                    ),
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          IconButton(
                                              onPressed: () {
                                                 // Add your button action here
                                              },
                                              icon: const Icon(Icons.add, size: 24.0, color: Colors.white)
                                          ),
                                          const Text('Add Image')
                                        ]
                                    )
                                )
                            )
                        ]
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Column(
                        children: <Widget>[
                            SizedBox(
                                width: 200.0,
                                height: 60.0,
                                child: TextField(
                                    controller: controller,
                                    decoration: InputDecoration(
                                        labelText: 'Add Instructions',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10.0) // Rounded corners
                                        )
                                    )
                                )
                            )
                        ]
                    )
                ]
            )
        );
    }
}

class Idea {
    late int timeForCrafting, boxSize;
    late List<String> steps, materialsNeeded;

    Idea({required this.timeForCrafting, required this.boxSize, required this.materialsNeeded, required this.steps});

    Map<String, dynamic> toJson() {
        return {
            'timeForCrafting': timeForCrafting,
            'boxSize': boxSize,
            'materialsNeeded': materialsNeeded,
            'steps': steps
        };
    }
}