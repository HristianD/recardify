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

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text(appTitle, style: TextStyle(color: Color(0xff3a887c), fontWeight: FontWeight.bold)), centerTitle: true),
            body: SafeArea(
              child: widget.child
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: const Color(0xffd5dcdc),
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