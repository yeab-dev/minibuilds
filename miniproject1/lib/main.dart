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
  Alignment alignment = Alignment.topCenter;
  Color containerColor = Colors.orange;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.yellow[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.5,
                width: double.infinity,
                child: AnimatedAlign(
                  alignment: alignment,
                  duration: const Duration(seconds: 1),
                  curve: Curves.bounceOut,
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    curve: Curves.bounceInOut,
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: containerColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    alignment = Alignment.bottomCenter;
                    containerColor = Colors.green;
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
