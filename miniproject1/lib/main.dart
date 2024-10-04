import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with SingleTickerProviderStateMixin {
  bool top = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 400,
                width: double.infinity,
                child: AnimatedAlign(
                  alignment: top ? Alignment.bottomCenter : Alignment.topCenter,
                  duration: const Duration(seconds: 1),
                  curve: top ? Curves.bounceOut : Curves.bounceIn,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    top = !top;
                  });
                },
                child: const Text("Start"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
