import 'package:flutter/material.dart';

class CreateIdea extends StatefulWidget {
  const CreateIdea({super.key});

  @override
  State<StatefulWidget> createState() => _CreateIdeaState();
}

class _CreateIdeaState extends State<CreateIdea> {
  int _count = 3;

  void addStep() {
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<StepWidget> _stepsList = new List.generate(_count, (int i) => new StepWidget(index: i + 1));
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
                                  icon: const Icon(
                                    Icons.add,
                                    size: 24.0,
                                    color: Colors.white
                                  )
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Materials Needed',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                        ),
                        SizedBox(
                          width: 180.0,
                          height: 100.0,
                          child: TextField(
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
                            addStep();
                          },
                          icon: const Icon(
                              Icons.add,
                              size: 24.0,
                              color: Colors.blue
                          )
                      ),
                      GestureDetector(
                        onTap: () {
                          addStep();
                        },
                        child: const Text('Add Step')
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
  const StepWidget({super.key, required this.index});

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
                                      icon: const Icon(
                                          Icons.add,
                                          size: 24.0,
                                          color: Colors.white
                                      )
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