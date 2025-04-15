import 'package:flutter/material.dart';
import 'package:easy_design_system/easy_design_system.dart';
import 'package:my_app/screens/counter/counter.screen.dart';
import 'package:provider/provider.dart';
import 'package:my_app/models/counter.dart';

void main() {
  //Provides an instance of Counter to the entire app.
  //Creates the instance when the app starts.
  runApp(ChangeNotifierProvider(create: (_) => Counter(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample Provider',
      home: Theme(data: ComicTheme.of(context), child: const CounterScreen()),
    );
  }
}
