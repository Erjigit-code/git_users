import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  @override
  void initState() {
    super.initState();
    // Вызываем функцию showToast при инициализации состояния
    showToast();
  }

  void showToast() {
    Fluttertoast.showToast(
      msg: "Test toast message",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Hello World!"),
      ),
    );
  }
}
