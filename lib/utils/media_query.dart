import 'package:flutter/cupertino.dart';

class AdjustScreen {
  double screenWidth(BuildContext context, double width) {
    return MediaQuery.of(context).size.width / width;
  }

  double screenHeight(BuildContext context, double height) {
    return MediaQuery.of(context).size.width / height;
  }
}
