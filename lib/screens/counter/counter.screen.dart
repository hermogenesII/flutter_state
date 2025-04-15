import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_app/models/counter.dart';
import 'package:my_app/screens/counter/another_page.dart';

//Basic StatelessWidget, the UI is rebuilt via Provider — no need for StatefulWidget.
class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Listens to changes in Counter.
    // When notifyListeners() is called, this widget rebuilds.
    final counter = context.watch<Counter>();

    return Scaffold(
      appBar: AppBar(title: Text('Provider Counter')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Count: ${counter.count}', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnotherPage()),
                );
              },
              child: Text('Go to Decrement Page'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context
              .read<Counter>()
              .increment(); //updates the value without rebuilding this widget.
          // counter.increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
