import 'package:flutter/material.dart';
import 'package:recardify/view-article.dart';

class LearnPage extends StatelessWidget {
    const LearnPage({super.key});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Center(
                child: ListView(
                    children: <Widget>[
                        SizedBox(
                            width: 500,
                            child: Column(
                                children: <Widget>[
                                    const SizedBox(
                                        height: 20,
                                    ),
                                    SizedBox(
                                        width: 350,
                                        child: GestureDetector(
                                            onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewArticle(id: 1)));
                                            },
                                            child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(
                                                        width: 200, // Set the desired width for the frame
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
                                                          child: Image.asset(
                                                            'assets/images/article1.png',
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  const Expanded(
                                                      child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                                                          children: <Widget>[
                                                            // First Text
                                                            Text(
                                                              'Top ten water saving tips',
                                                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                                            ),
                                                            // Second Text
                                                            Text(
                                                              'Learn how you can help the environment saving',
                                                              style: TextStyle(fontSize: 13),
                                                            )
                                                          ]
                                                      )
                                                  )
                                                ]
                                            )
                                        )
                                    ),
                                    const SizedBox(
                                        height: 20,
                                    ),
                                    SizedBox(
                                        width: 350,
                                        child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewArticle(id: 2)));
                                            },
                                            child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(
                                                        width: 200, // Set the desired width for the frame
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
                                                          child: Image.asset(
                                                            'assets/images/article2.png',
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  const Expanded(
                                                      child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                                                          children: <Widget>[
                                                            // First Text
                                                            Text(
                                                              'Climate change explained for children',
                                                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                                            ),
                                                            // Second Text
                                                            Text(
                                                              'Learn about climate change, what can you as a child do about it and what is climate change exactly?',
                                                              style: TextStyle(fontSize: 13),
                                                            )
                                                          ]
                                                      )
                                                  )
                                                ]
                                            )
                                        )
                                    ),
                                    const SizedBox(
                                        height: 20,
                                    ),
                                    SizedBox(
                                        width: 350,
                                        child: GestureDetector(
                                            onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewArticle(id: 3)));
                                            },
                                            child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(
                                                        width: 200, // Set the desired width for the frame
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
                                                          child: Image.asset(
                                                            'assets/images/article3.png',
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  const Expanded(
                                                      child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                                                          children: <Widget>[
                                                            // First Text
                                                            Text(
                                                              '7 tips to recycle better',
                                                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                                            ),
                                                            // Second Text
                                                            Text(
                                                              'Do you want to do something but don’t know were to start? Here are 7 tips how to better recycle your waste!',
                                                              style: TextStyle(fontSize: 13),
                                                            )
                                                          ]
                                                      )
                                                  )
                                                ]
                                            )
                                        )
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                        width: 350,
                                        child: GestureDetector(
                                            onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewArticle(id: 4)));
                                            },
                                            child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(
                                                        width: 200, // Set the desired width for the frame
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
                                                          child: Image.asset(
                                                            'assets/images/article4.png',
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  const Expanded(
                                                      child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                                                          children: <Widget>[
                                                            // First Text
                                                            Text(
                                                              'Causes and effects of climate change',
                                                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                                            ),
                                                            // Second Text
                                                            Text(
                                                              'Do you want to learn more about the dangerous effects climate change has on ourlovely planet. You can read it here.',
                                                              style: TextStyle(fontSize: 13),
                                                            )
                                                          ]
                                                      )
                                                  )
                                                ]
                                            )
                                        )
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                        width: 350,
                                        child: GestureDetector(
                                            onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewArticle(id: 5)));
                                            },
                                            child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(
                                                        width: 200, // Set the desired width for the frame
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
                                                          child: Image.asset(
                                                            'assets/images/article5.png',
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  const Expanded(
                                                      child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                                                          children: <Widget>[
                                                            // First Text
                                                            Text(
                                                              'Causes and effects of climate change',
                                                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                                            ),
                                                            // Second Text
                                                            Text(
                                                              'Are you interested in renewable energy and want to know what the advantages and disadvantages of solar panels are?',
                                                              style: TextStyle(fontSize: 13),
                                                            )
                                                          ]
                                                      )
                                                  )
                                                ]
                                            )
                                        )
                                    ),
                                    const SizedBox(
                                        height: 20
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