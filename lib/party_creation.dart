import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Counter with ChangeNotifier {
  Counter(this._counter);

  int _counter;

  int getCounter() => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }

  void decrement() {
    _counter--;
    notifyListeners();
  }
}

class PartyCreation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Counter counter = Provider.of<Counter>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Counter ' + counter.getCounter().toString()),
          IconButton(icon: Icon(Icons.add), onPressed: counter.increment),
          IconButton(icon: Icon(Icons.remove), onPressed: counter.decrement)

        ],
      ),
    );
  }
}
