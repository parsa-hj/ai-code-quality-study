import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../core/utils/responsive_helper.dart';

class AppPageShell extends StatelessWidget {
  const AppPageShell({
    super.key,
    required this.title,
    required this.child,
    this.actions = const <Widget>[],
    this.floatingActionButton,
  });

  final String title;
  final Widget child;
  final List<Widget> actions;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    final maxWidth = ResponsiveHelper.isDesktop(context) ? 1280.0 : 720.0;

    return Scaffold(
      floatingActionButton: floatingActionButton,
      appBar: AppBar(
        title: Text(title),
        centerTitle: false,
        actions: actions,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.appPadding),
            child: child,
          ),
        ),
      ),
    );
  }
}
