import 'package:all_sensors2/all_sensors2.dart';
import 'package:flutter/material.dart';
import 'package:gyro_test/transform_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TransformPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List<double>> _accelerometerValues = [
    [0, 0, 0]
  ];
  List<List<double>> _gyroscopeValues = [
    [0, 0, 0]
  ];
  List<double> _userAccelerometerValues = [];
  bool _proximityValues = false;

  @override
  void initState() {
    // Access sensors value
    accelerometerEvents?.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues.add([event.x, event.y, event.z]);
      });
    });

    gyroscopeEvents?.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeValues.add([event.x, event.y, event.z]);
      });
    });

    proximityEvents?.listen((ProximityEvent event) {
      setState(() {
        // event.getValue return true or false
        _proximityValues = event.getValue();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_gyroscopeValues.last[0].abs() > 2) {
      print('x : ${_gyroscopeValues.last[0].toStringAsFixed(2)}');
    }
    if (_gyroscopeValues.last[1].abs() > 2) {
      print('   y : ${_gyroscopeValues.last[1].toStringAsFixed(2)}');
    }
    if (_gyroscopeValues.last[2].abs() > 2) {
      print('   z : ${_gyroscopeValues.last[2].toStringAsFixed(2)}');
    }

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                const Text('자이로 :'),
                Text('x : ${_gyroscopeValues.last[0].toStringAsFixed(2)}'),
                Text('   y : ${_gyroscopeValues.last[1].toStringAsFixed(2)}'),
                Text('   z : ${_gyroscopeValues.last[2].toStringAsFixed(2)}'),
              ],
            ),
            Row(
              children: [
                const Text('가속도 :'),
                Text('x : ${_accelerometerValues.last[0].toStringAsFixed(2)}'),
                Text(
                    '   y : ${_accelerometerValues.last[1].toStringAsFixed(2)}'),
                Text(
                    '   z : ${_accelerometerValues.last[2].toStringAsFixed(2)}'),
              ],
            ),
            Row(
              children: [
                const Text('_proximityValues :'),
                Text(_proximityValues.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
