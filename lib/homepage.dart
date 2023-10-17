import 'package:flutter/material.dart';
import 'package:recardify/view-idea.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isDark = false;
  static const List<String> str = [
    "Medium Box",
    "Glue",
    "Scissors",
    "Cardboard rolls"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ListView(
                children: <Widget>[
                  SearchAnchor(
                      builder: (BuildContext context, SearchController controller) {
                        return SearchBar(
                          controller: controller,
                          padding: const MaterialStatePropertyAll<EdgeInsets>(
                              EdgeInsets.symmetric(horizontal: 16.0)),
                          onTap: () {
                            controller.openView();
                          },
                          onChanged: (_) {
                            controller.openView();
                          },
                          leading: const Icon(Icons.search),
                        );
                      }, suggestionsBuilder:
                      (BuildContext context, SearchController controller) {
                    return List<ListTile>.generate(0, (int index) {
                      final String item = 'item $index';
                      return ListTile(
                        title: Text(item),
                        onTap: () {
                          setState(() {
                            controller.closeView(item);
                          });
                        },
                      );
                    });
                  }),

                  for (var j = 0; j < 7; j++)
                    InkWell(
                        child: Flexible(
                            child: Card(
                                child: Row(
                                    children: <Widget>[
                                      Expanded(
                                          flex: 3,
                                          child: Column(
                                              children: [
                                                Image.asset('assets/images/example.png', width: 100, height: 100),
                                              ]
                                          )
                                      ),
                                      Expanded(
                                          flex: 5,
                                          child: Column(
                                              children: <Widget>[
                                                Row(
                                                    children: [
                                                      Text("Materials needed:", style: TextStyle(fontSize: 20))
                                                    ]
                                                ),
                                                for (var i in str)
                                                  Row(
                                                      children:[
                                                        Text("\u2022", style: TextStyle(fontSize: 20)), //bullet text
                                                        SizedBox(width: 10), //space between bullet and text
                                                        Expanded(
                                                            child:Text(i, style: TextStyle(fontSize: 20)) //text
                                                        )
                                                      ]
                                                  )
                                              ])
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
                                                    child: Text("20 min")
                                                )
                                              ]
                                          )
                                      )
                                    ]
                                )
                            )
                        ),
                        onTap: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => const ViewIdea())
                          );
                        }
                    )
                ]
            )
        ),
    );
  }
}