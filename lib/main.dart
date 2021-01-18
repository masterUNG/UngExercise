import 'package:flutter/material.dart';
import 'package:ungexercies/router.dart';

String initialRoute = '/authen';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: map,
      initialRoute: initialRoute,
    );
  }
}
