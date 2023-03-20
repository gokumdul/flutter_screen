import 'package:flutter/material.dart';
import 'package:screen/screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isKeptOn = false;
  double _brightness = 1.0;

  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
    bool keptOn = await Screen.isKeptOn ?? false;
    double brightness = await Screen.brightness ?? 0;
    setState(() {
      _isKeptOn = keptOn;
      _brightness = brightness;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Screen plugin example')),
        body: Center(
            child: Column(children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Text("Screen is kept on ? "),
            Checkbox(
                value: _isKeptOn,
                onChanged: (bool? b) {
                  Screen.keepOn(b ?? false);
                  setState(() {
                    _isKeptOn = b ?? false;
                  });
                })
          ]),
          Text("Brightness :"),
          Slider(
              value: _brightness,
              onChanged: (double b) {
                setState(() {
                  _brightness = b;
                });
                Screen.setBrightness(b);
              })
        ])),
      ),
    );
  }
}
