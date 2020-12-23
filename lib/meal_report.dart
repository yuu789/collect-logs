import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListItem {
  int value;
  String name;
  ListItem(this.value, this.name);
}

class MealContent {
  final String userId;
  final String mealTime;
  final int mealAs;
  final int mealCount;

  MealContent({this.userId, this.mealTime, this.mealAs, this.mealCount});

  Map<String, dynamic> toJson() => {
        "user-id": userId,
        "meal-time": mealTime,
        "meal-as": mealAs,
        "meal-count": mealCount
      };
}

class MealReport extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MealReportState();
}

class MealReportState extends State<MealReport> {
  var _labelText = '';

  final List<String> _mealAsList = ['朝食', '昼食', '夕食', '夜食', 'おやつ'];
  List<ListItem> _dropdownItems = [];
  ListItem _selectedItem;
  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;

  final List<String> _mealCount = ['1回目', '2回目', '3回目', '4回目', '5回目', '6回目'];
  List<ListItem> _dropdownItemsMealCount = [];
  ListItem _selectedItemMealCount;
  List<DropdownMenuItem<ListItem>> _dropdownMenuItemsMealCount;

  // create dropdown items ( from _mealAsList array )
  _createDropdownItems(List dropdownitem) {
    List<ListItem> item = List();
    for (var i = 0; i < dropdownitem.length; i++) {
      item.add(ListItem(i + 1, dropdownitem[i]));
    }
    return item;
  }

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

  void initState() {
    super.initState();
    // ListItem(1, "朝食")... を作成
    _dropdownItems = _createDropdownItems(_mealAsList);
    _dropdownMenuItems = buildDropdownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;

    _dropdownItemsMealCount = _createDropdownItems(_mealCount);
    _dropdownMenuItemsMealCount =
        buildDropdownMenuItems(_dropdownItemsMealCount);
    _selectedItemMealCount = _dropdownMenuItemsMealCount[0].value;
  }

  List<DropdownMenuItem<ListItem>> buildDropdownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  var resData = '';

  Future<void> _send() async {
    final url =
        'https://prod-14.eastasia.logic.azure.com:443/workflows/c54505395bb941ef92b00bc9eebbfbec/triggers/manual/paths/invoke?api-version=2016-10-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=7t4jjxazGMDsv3U8KClKBrCqoqD83fABGpqpovit-bo';
    var request = new MealContent(
        userId: 'test',
        mealTime: _labelText,
        mealAs: _selectedItem.value,
        mealCount: _selectedItemMealCount.value);
    var body = json.encode(request.toJson());
    final Map<String, String> headers = {'Content-Type': 'application/json'};

    final res = await http.post(url, headers: headers, body: body);

    if (res.body.isNotEmpty) {
      final data = json.decode(res.body);
      resData = data.statusCode.toString();
    }
  }

  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('MealReport'),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '食べた日時は？：' + _labelText,
                      style: TextStyle(fontSize: 18),
                    ),
                    IconButton(
                      icon: Icon(Icons.date_range),
                      onPressed: () => _selectDate(context),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'これは何ご飯ですか？：',
                      style: TextStyle(fontSize: 18),
                    ),
                    DropdownButton<ListItem>(
                      value: _selectedItem,
                      items: _dropdownMenuItems,
                      onChanged: (value) {
                        setState(
                          () {
                            _selectedItem = value;
                          },
                        );
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '朝起きてから何回目の食事ですか？：',
                      style: TextStyle(fontSize: 18),
                    ),
                    DropdownButton<ListItem>(
                      value: _selectedItemMealCount,
                      items: _dropdownMenuItemsMealCount,
                      onChanged: (value) {
                        setState(
                          () {
                            _selectedItemMealCount = value;
                          },
                        );
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        _send();
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: const Text('送信しました！'),
                          duration: const Duration(seconds: 5),
                          action: SnackBarAction(
                            label: 'DONE',
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ));
                      },
                      color: Colors.red,
                      child: Text(
                        '送信',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      resData,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
