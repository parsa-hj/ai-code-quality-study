  import 'package:flutter/material.dart';

  class HomeLayout extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Home Screen'),
        ),
        body: Center(
          child: ElevatedButton(onPressed: () {}, child: Text('Go to Product Screen')),
        ),
      );
    }
  }