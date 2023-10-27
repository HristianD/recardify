import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recardify/view-idea.dart';
import 'dart:async';
import 'dart:convert';
import 'package:recardify/idea.dart';

class MyHomePage extends StatefulWidget {
    const MyHomePage({super.key});
    @override
    State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
    bool isDark = false;
    bool isDataLoaded = false;
    static const MethodChannel _fetchChannel = MethodChannel('recardify.dev/fetch-ideas');
    final List<Idea> _ideasList = [];
    final List<String> _keysList = [];
    List<Idea> _ideasToShow = [];

    @override
    void initState() {
        super.initState();
        _fetchIdeasAndAttachListeners();
    }

    Future<void> _fetchIdeasAndAttachListeners() async {
        _fetchChannel.setMethodCallHandler((call) async {
            if (call.method == 'fetchedIdeas' || call.method == 'attachListeners') {
                Map<String, dynamic> ideasMap = json.decode(call.arguments);
                ideasMap.forEach((key, value) {
                   setState(() {
                      _ideasList.add(Idea.fromJson(json.decode(value)));
                      _ideasToShow.add(Idea.fromJson(json.decode(value)));
                      _keysList.add(key);
                      isDataLoaded = true;
                   });
                });


            }
        });

        try {
            await _fetchChannel.invokeMethod('fetchIdeas');
        } on PlatformException catch (e) {
           print(e);
        }
    }

    void _filterOnTitle(String text) {
        if (text.trim() == '') {
            setState(() {
                _ideasToShow = _ideasList;
            });
        } else {
            _ideasToShow = [];
            setState(() {
                for (var idea in _ideasList) {
                    if (idea.title.toLowerCase().contains(text.toLowerCase())) {
                        _ideasToShow.add(idea);
                    }
                }
            });
        }
    }

    double compareIdeasByRating(Idea a, Idea b) {
        return (b.rating / b.timesRated) - (a.rating / a.timesRated);
    }

    @override
    Widget build(BuildContext context) {
        if (!isDataLoaded) {
            return const Center(
                child: CircularProgressIndicator()
            );
        } else if (_ideasList.isEmpty) {
          return const Center(
            child: Text('No data available'),
          );
        }

        return Scaffold(
            body: Center(
                child: ListView(
                    children: <Widget>[
                        Column(
                            children: <Widget>[
                                const SizedBox(
                                    height: 5,
                                ),
                                SizedBox(
                                    width: 350,
                                    child: InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        child: TextField(
                                            onChanged: (text) {
                                              _filterOnTitle(text);
                                            },
                                            decoration: const InputDecoration(
                                              filled: true,
                                              fillColor: Color(0xffd5dcdc),
                                              prefixIcon: Icon(Icons.search),
                                              hintText: 'Search'
                                            )
                                        )
                                    )
                                ),
                                for (int i = 0; i < _ideasToShow.length; i++)
                                    GestureDetector(
                                        onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => ViewIdea(id: _keysList[i])));
                                        },
                                        child: Container(
                                            margin: const EdgeInsets.only(top: 30),
                                            width: 350,
                                            child: Column(
                                                children: <Widget>[
                                                  Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                        Text(_ideasToShow[i].title, style: const TextStyle(
                                                            fontSize: 30, fontWeight: FontWeight.bold))
                                                      ]
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                      children: <Widget>[
                                                        Container(
                                                          width: 130, // Set the desired width for the frame
                                                          height: 130, // Calculate the height to match the aspect ratio
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10.0), // Rounded frame
                                                            border: Border.all(
                                                              color: Colors.black, // Frame border color
                                                              width: 3.0, // Border width
                                                            ),
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(7.0), // Slightly smaller border radius
                                                            child: Image.memory(
                                                              Uint8List.fromList(base64Decode(_ideasToShow[i].imagesBase64[0])),
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: 20
                                                        ),
                                                        Column(
                                                          children: <Widget>[
                                                            SizedBox(
                                                              width: 120,
                                                              height: 130,
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: <Widget>[
                                                                  for (int j = 0; j < min(_ideasToShow[i].materialsNeeded.length, 4); j++)
                                                                    if (j < 3)
                                                                      Row(
                                                                        children: <Widget>[
                                                                          Text("\u2022",
                                                                              style: TextStyle(fontSize: 20)),
                                                                          Container(
                                                                            width: 110,
                                                                            child: Text(
                                                                              _ideasToShow[i].materialsNeeded[j],
                                                                              maxLines: 1,
                                                                              // Set the maximum number of lines
                                                                              overflow: TextOverflow.ellipsis,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      )
                                                                    else
                                                                      Row(
                                                                        children: <Widget>[
                                                                          Text("\u2022\u2022\u2022",
                                                                              style: TextStyle(fontSize: 20)),
                                                                        ],
                                                                      ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                            width: 20
                                                        ),
                                                        Column(
                                                            children: [
                                                              Container(
                                                                  width: 60, // Set the width of the container
                                                                  height: 30,
                                                                  child: Center(
                                                                      child: Text(
                                                                        '${_ideasToShow[i].timeForCrafting} min',
                                                                        style: TextStyle(fontSize: 12),
                                                                      )
                                                                  ),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(12.0),
                                                                      // Rounded corners
                                                                      border: Border.all(
                                                                        color: Colors.grey, // Grey frame color
                                                                        width: 1.0, // Thin border width
                                                                      )
                                                                  )
                                                              )
                                                            ]
                                                        )
                                                      ]
                                                  )
                                                ]
                                            )
                                        )
                                    ),
                                    SizedBox(
                                        height: 20,
                                    )
                            ]
                        )
                    ]
                )
            )
        );
    }
}