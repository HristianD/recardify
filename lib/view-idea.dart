import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recardify/idea.dart';
import 'dart:convert';

class ViewIdea extends StatefulWidget {
    final String id;
    const ViewIdea({super.key, required this.id});

    @override
    State<StatefulWidget> createState() => _ViewIdeaState(id: this.id);
}

class _ViewIdeaState extends State<ViewIdea> {
    static const MethodChannel _fetchChannel = MethodChannel('recardify.dev/fetch-idea');
    static const MethodChannel _rateChannel = MethodChannel('recardify.dev/rate-idea');
    final String id;
    late Idea _idea;
    int rating = 0;
    bool isDataLoaded = false;

    _ViewIdeaState({required this.id});

    @override
    void initState() {
        super.initState();
        _fetchIdea();
    }

    Future<void> _fetchIdea() async {
        _fetchChannel.setMethodCallHandler((call) async {
            if (call.method == 'fetchedIdea') {
                setState(() {
                    _idea = Idea.fromJson(json.decode(call.arguments));
                    isDataLoaded = true;
                });
            }
        });

        try {
            await _fetchChannel.invokeMethod('fetchIdea', id);
        } on PlatformException catch (e) {
            print(e);
        }
    }

    Future<void> _rateIdea() async {
      try {
        Map<String, Idea> ideaMap = {};
        ideaMap[id] = _idea;
        await _rateChannel.invokeMethod('rateIdea', json.encode(ideaMap));
      } on PlatformException catch (e) {
        print(e);
      }
    }

    void updateRating(int newRating) {
      setState(() {
          rating = newRating;
          _idea.rating += rating;
          _idea.timesRated++;
          _rateIdea();
      });
    }

    @override
    Widget build(BuildContext context) {
        if (!isDataLoaded) {
            return const Center(
                child: CircularProgressIndicator()
            );
        }

        Uint8List imageBytes = Uint8List.fromList(base64Decode(_idea.imagesBase64[0]));
        double imageAspectRatio = imageBytes.lengthInBytes / imageBytes.length;
        return Scaffold(
            body: Center(
                child: ListView(
                    children: <Widget>[
                      SizedBox(
                          child: Column(
                              children: <Widget>[
                                SizedBox(
                                    width: 200,
                                    child: Column(
                                        children: <Widget>[
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(_idea.title, style: const TextStyle(fontSize: 30)),
                                          Text('${_idea.timeForCrafting.toString()} min', style: const TextStyle(fontSize: 20)),
                                          Container(
                                            width: 200, // Set the desired width for the frame
                                            height: 200 / imageAspectRatio, // Calculate the height to match the aspect ratio
                                            decoration: BoxDecoration(
                                              color: Colors.black, // Frame background color
                                              borderRadius: BorderRadius.circular(10.0), // Rounded frame
                                              border: Border.all(
                                                color: Colors.black, // Frame border color
                                                width: 3.0, // Border width
                                              ),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(7.0), // Slightly smaller border radius
                                              child: Image.memory(
                                                imageBytes,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          )
                                        ]
                                    )
                                ),

                                SizedBox(
                                    width: 370,
                                    child: Column(
                                        children: <Widget>[
                                          const Text('Materials needed:', style: TextStyle(fontSize: 20)),
                                          for (int i = 0; i < _idea.materialsNeeded.length; i++)
                                            SizedBox(
                                                width: 200,
                                                child: Text(
                                                    '\u2022 ${_idea.materialsNeeded[i]}',
                                                    maxLines: 1,
                                                    style: const TextStyle(fontSize: 18),
                                                    overflow: TextOverflow.ellipsis
                                                )
                                            ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          for (int i = 0; i < _idea.steps.length; i++)
                                            Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text('Step ${i + 1}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                                      Container(
                                                        width: 150, // Set the desired width for the frame
                                                        height: 150, // Calculate the height to match the aspect ratio
                                                        decoration: BoxDecoration(
                                                          color: Colors.black, // Frame background color
                                                          borderRadius: BorderRadius.circular(10.0), // Rounded frame
                                                          border: Border.all(
                                                            color: Colors.black, // Frame border color
                                                            width: 3.0, // Border width
                                                          ),
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(7.0), // Slightly smaller border radius
                                                          child: Image.memory(
                                                            Uint8List.fromList(base64Decode(_idea.imagesBase64[i + 1])),
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Expanded(
                                                      child: Container(
                                                          padding: const EdgeInsets.all(24),
                                                          child: Text(_idea.steps[i], style: const TextStyle(fontSize: 16))
                                                      )
                                                  )
                                                ]
                                            ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text('Did you like the idea? You can rate it!'),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: List.generate(5, (index) {
                                              final starColor =
                                              index < rating ? Colors.amber : Colors.grey; // Determine star color

                                              return GestureDetector(
                                                onTap: () {
                                                    updateRating(index + 1);
                                                },
                                                child: AnimatedContainer(
                                                  duration: Duration(milliseconds: 300),
                                                  curve: Curves.easeInOut,
                                                  child: Icon(
                                                    Icons.star,
                                                    color: starColor, // Set the star color
                                                    size: 40,
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          )
                                        ]
                                    )
                                )
                              ]
                          )
                      )
                    ]
                )
            )
        );
    }
}