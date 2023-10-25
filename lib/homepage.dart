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
    static final List<Idea> _ideasList = [];
    static final List<String> _keysList = [];

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

    @override
    Widget build(BuildContext context) {
        if (!isDataLoaded) {
            return const Center(
                child: CircularProgressIndicator()
            );
        } else if (_ideasList.isEmpty) {
            return const Center(
                child: Text('No data available.'),
            );
        }

        return Scaffold(
            body: Center(
                child: ListView(
                    children: <Widget>[
                        SearchAnchor(
                            builder: (BuildContext context, SearchController controller) {
                                return SearchBar(
                                    controller: controller,
                                    padding: const MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(horizontal: 16.0)),
                                    onTap: () {
                                        controller.openView();
                                    },
                                    onChanged: (_) {
                                        controller.openView();
                                    },
                                    leading: const Icon(Icons.search)
                                );
                            },
                            suggestionsBuilder:
                                (BuildContext context, SearchController controller) {
                                    return List<ListTile>.generate(0, (int index) {
                                        final String item = 'item $index';
                                        return ListTile(
                                            title: Text(item),
                                            onTap: () {
                                                setState(() {
                                                    controller.closeView(item);
                                                });
                                            }
                                        );
                                    }
                                );
                            }
                        ),

                        for (int i = 0; i < _ideasList.length; i++)
                            InkWell(
                                child: Flexible(
                                    child: Card(
                                        child: Row(
                                            children: <Widget>[
                                                Expanded(
                                                    flex: 3,
                                                    child: Column(
                                                        children: [
                                                            Image(image: MemoryImage(Uint8List.fromList(base64Decode(_ideasList[i].imagesBase64[0]))), width: 100, height: 100)
                                                        ]
                                                    )
                                                ),
                                                Expanded(
                                                    flex: 5,
                                                    child: Column(
                                                        children: <Widget>[
                                                            const Row(
                                                                children: [
                                                                    Text("Materials needed:", style: TextStyle(fontSize: 20))
                                                                ]
                                                            ),
                                                            for (var j in _ideasList[i].materialsNeeded)
                                                                Row(
                                                                    children: [
                                                                        const Text("\u2022", style: TextStyle(fontSize: 20)), // bullet text
                                                                        const SizedBox(width: 10), // space between bullet and text
                                                                        Expanded(
                                                                            child:
                                                                                Text(j, style: const TextStyle(fontSize: 20)) // text
                                                                        )
                                                                    ]
                                                                )
                                                        ]
                                                    )
                                                ),
                                                Expanded(
                                                    flex: 2,
                                                    child: Column(
                                                        children: [
                                                            Container(
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(),
                                                                    borderRadius: BorderRadius.circular(20)
                                                                ),
                                                                width: 70,
                                                                height: 30,
                                                                alignment: Alignment.center,
                                                                child: Text("${_ideasList[i].timeForCrafting}min")
                                                            )
                                                        ]
                                                    )
                                                )
                                            ]
                                        )
                                    )
                                ),
                                onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewIdea()));
                                }
                            )
                    ]
                )
            )
        );
    }
}