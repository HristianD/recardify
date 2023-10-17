import 'package:flutter/material.dart';

class CreateIdea extends StatefulWidget {
  const CreateIdea({super.key});

  @override
  State<StatefulWidget> createState() => _CreateIdeaState();
}

class _CreateIdeaState extends State<CreateIdea> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ListView(
                children: <Widget>[
                  Column(
                      children: <Widget>[
                        Row(
                            children: <Widget>[
                              Column(

                              ),
                              Column(
                                  children: <Widget>[

                                  ]
                              )
                            ]
                        ),
                        for (int i = 0; i < 3; i++)
                          Row(
                              children: <Widget>[
                                Column(

                                ),
                                Column(

                                )
                              ]
                          )
                      ]
                  ),
                ])
        ),
    );
  }
}