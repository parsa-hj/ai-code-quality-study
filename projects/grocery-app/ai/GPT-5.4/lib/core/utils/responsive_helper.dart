import 'package:flutter/widgets.dart';

class ResponsiveHelper {
  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 600;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= 600 && width < 1024;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 1024;

  static int gridCount(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= 1400) {
      return 5;
    }
    if (width >= 1024) {
      return 4;
    }
    if (width >= 700) {
      return 3;
    }
    return 2;
  }
}
