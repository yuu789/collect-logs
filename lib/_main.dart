import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    );

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<MyApp> {
  var _labelText = 'put your meal';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2022),
    );
    if (selected != null) {
      setState(() {
        _labelText = (DateFormat.yMMMd()).format(selected);
      });
    }

    final TimeOfDay t = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (t != null) {
      var dt = _toDateTime(t);
      setState(() {
        _labelText += ', ' + (DateFormat.Hm()).format(dt);
      });
    }
  }

  _toDateTime(TimeOfDay t) {
    var now = DateTime.now();
    return DateTime(now.year, now.month, now.day, t.hour, t.minute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ご飯いつ食べた？'),
      ),
      body: Container(
          padding: EdgeInsets.all(16.0),
          child: Center(
              child: Column(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _labelText,
                  style: TextStyle(fontSize: 18),
                ),
                IconButton(
                  icon: Icon(Icons.date_range),
                  onPressed: () => _selectDate(context),
                )
              ],
            ),
            // Row(children: <Widget>[
            //   Text(
            //     "aaaa",
            //     style: TextStyle(fontSize: 18),
            //   ),
            //   Radio(
            //     activeColor: Colors.blueAccent,
            //     value: 'hoge',
            //   ),
            //   Text('aaaa'),
            // ])
          ]))),
    );
  }
}
