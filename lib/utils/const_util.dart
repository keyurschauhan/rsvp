import 'dart:ui';

import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';

class ConstUtil{

  Future<bool> checkConnection() async {
    return await DataConnectionChecker().hasConnection;
  }

  static const Color themeColor = Color(0xff60A053);
}