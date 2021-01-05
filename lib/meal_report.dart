import 'package:myapp/complete_answer.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
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
        "meal-as": mealAs // ,
        // "meal-count": mealCount
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

  // final List<String> _mealCount = ['1回目', '2回目', '3回目', '4回目', '5回目', '6回目'];
  // List<ListItem> _dropdownItemsMealCount = [];
  // ListItem _selectedItemMealCount;
  // List<DropdownMenuItem<ListItem>> _dropdownMenuItemsMealCount;

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
    // _selectedItem = _dropdownMenuItems[0].value;

    // _dropdownItemsMealCount = _createDropdownItems(_mealCount);
    // _dropdownMenuItemsMealCount =
    //     buildDropdownMenuItems(_dropdownItemsMealCount);
    // _selectedItemMealCount = _dropdownMenuItemsMealCount[0].value;
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
        "https://prod-03.japaneast.logic.azure.com:443/workflows/7b3099b1dd2b42898ded0173bde7782f/triggers/manual/paths/invoke?api-version=2016-10-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=acZQqiM39oGM_-Ub94NhXRLDHNo8fQpzf7AJrLNWegE";
    var request = new MealContent(
        userId: 'test', mealTime: _labelText, mealAs: _selectedItem.value // ,
        // mealCount: _selectedItemMealCount.value
        );
    var body = json.encode(request.toJson());
    final Map<String, String> headers = {'Content-Type': 'application/json'};

    final res = await http.post(url, headers: headers, body: body);

    if (res.body.isNotEmpty) {
      final data = json.decode(res.body);
      resData = data.statusCode.toString();
    }
  }

  // var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) => Scaffold(
        // key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Meal Report'),
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
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              '食べた日時は？：', // + _labelText,
                              style: TextStyle(fontSize: 18),
                            ),
                            // IconButton(
                            //   icon: Icon(Icons.date_range),
                            //   onPressed: () => _selectDate(context),
                            //   tooltip: '日時を選択してください',
                            // ),
                            RaisedButton.icon(
                              color: Colors.white,
                              icon: const Icon(
                                Icons.date_range,
                                size: 24,
                              ),
                              onPressed: () => _selectDate(context),
                              label: Text(
                                'タップで入力',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[600],
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '確認：' + _labelText,
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'これは何ご飯？：',
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
                      hint: Text(
                        "タップで選択",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       '朝起きてから何回目の食事ですか？：',
                //       style: TextStyle(fontSize: 18),
                //     ),
                //     DropdownButton<ListItem>(
                //       value: _selectedItemMealCount,
                //       items: _dropdownMenuItemsMealCount,
                //       onChanged: (value) {
                //         setState(
                //           () {
                //             _selectedItemMealCount = value;
                //           },
                //         );
                //       },
                //     ),
                //   ],
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        _send();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CompleteAnswer(),
                          ),
                        );
                        // _scaffoldKey.currentState.showSnackBar(
                        //   SnackBar(
                        //     content: const Text('送信しました！'),
                        //     duration: const Duration(seconds: 5),
                        //     action: SnackBarAction(
                        //       label: '戻す',
                        //       onPressed: () {
                        //         Navigator.pop(context);
                        //       },
                        //     ),
                        //   ),
                        // );
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
