import 'package:flutter/material.dart';
import 'package:prefman/prefman.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefMan.initialize();
  runApp(VarApp());
}

class VarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PersistentCounter(),
    );
  }
}

class PersistentCounter extends StatefulWidget {
  @override
  _PersistentCounterState createState() => _PersistentCounterState();
}

class _PersistentCounterState extends State<PersistentCounter> {
  var count = Preference.integer(key: 'counter', defaultValue: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: count,
          builder: (context, _) => Text(count.get().toString()),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => count.setValue(count.get() + 1),
      ),
    );
  }
}
