import 'package:flutter/material.dart';
import 'package:radio/screens/app.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radio Chapingo',
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      supportedLocales: const [Locale('es', 'MX')],
      theme: ThemeData(
        primaryColor: Colors.grey[100],
        brightness: Brightness.light,
        accentColor: Colors.indigoAccent,
      ),
      home: HomePage(),
    );
  }
}
