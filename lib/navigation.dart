import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationPage extends StatefulWidget {
    const BottomNavigationPage({super.key, required this.child});

    final StatefulNavigationShell child;
    @override
    State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
    static const String appTitle = "Recardify";
    int _selectedIndex = 0;

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text(appTitle), centerTitle: true),
            body: SafeArea(
              child: widget.child
            ),
            drawer: Drawer(
              // Add a ListView to the drawer. This ensures the user can scroll
              // through the options in the drawer if there isn't enough vertical
              // space to fit everything.
              // backgroundColor: Colors.green,
                child: ListView(
                  // Important: Remove any padding from the ListView.
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      Center(
                          child: Container(
                              margin: const EdgeInsets.only(top: 100),
                              child: Column(children: <Widget>[
                                  ListTile(
                                      title: const Center(child: Text('Settings')),
                                      selected: _selectedIndex == 0,
                                      onTap: () {
                                          setState(() {
                                              _selectedIndex = 0;
                                          });
                                          Navigator.pop(context);
                                      }
                                  ),
                                  ListTile(
                                      title: const Center(child: Text('Language')),
                                      selected: _selectedIndex == 1,
                                      onTap: () {
                                          setState(() {
                                              _selectedIndex = 1;
                                          });
                                          Navigator.pop(context);
                                      }
                                  )
                              ])
                          )
                      )
                    ]
                )
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: widget.child.currentIndex,
                onTap: (index) {
                    widget.child.goBranch(
                        index,
                        initialLocation: index == widget.child.currentIndex
                    );
                    setState(() {});
                },
                items: const [
                    BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
                    BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
                    BottomNavigationBarItem(icon: Icon(Icons.book), label: '')
                ]
            )
        );
    }
}