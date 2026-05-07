  import 'package:flutter/material.dart';
  import 'package:get_x/get_x.dart';

  void main() {
    runApp(const MyApp());
  }

  class MyApp extends StatelessWidget {
    const MyApp({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Grocery App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      );
    }
  }

  class MyHomePage extends StatelessWidget {
    const MyHomePage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Grocery App'),
        ),
        body: const Center(
          child: ElevatedButton(onPressed: () {}, child: Text('Go to Home Screen')),
        ),
      );
    }
  }
