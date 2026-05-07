  import 'package:flutter/material.dart';

  class ReusableWidget extends StatelessWidget {
    final Widget child;

    const ReusableWidget({Key? key, required this.child}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: child,
      );
    }
  }