import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_app/models/counter.dart';

class AnotherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = context.watch<Counter>();

    return Scaffold(
      appBar: AppBar(title: Text('Provider Counter - Decrement')),
      body: Center(
        child: Text('Count: ${counter.count}', style: TextStyle(fontSize: 24)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counter.decrement();
        },
        child: Icon(Icons.remove),
      ),
    );
  }
}
