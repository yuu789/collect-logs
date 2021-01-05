import 'package:flutter/material.dart';
import 'complete_answer.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class BigFive {
  final String userId;
  final String ansTime;
  final List qAns10;

  BigFive({this.userId, this.ansTime, this.qAns10});

  Map<String, dynamic> toJson() => {
        "user-id": userId,
        "ans-time": ansTime,
        "q1": qAns10[0],
        "q2": qAns10[1],
        "q3": qAns10[2],
        "q4": qAns10[3],
        "q5": qAns10[4],
        "q6": qAns10[5],
        "q7": qAns10[6],
        "q8": qAns10[7],
        "q9": qAns10[8],
        "q10": qAns10[9]
      };
}

class PersonalityTest extends StatefulWidget {
  final int qNum;
  final List qAns;
  PersonalityTest(this.qNum, this.qAns);

  @override
  _PersonalityTest createState() => _PersonalityTest(qNum, qAns);
}

class _PersonalityTest extends State<PersonalityTest> {
  int _selectedAnswer = 0; // = '';
  _PersonalityTest(this.qNum, this.qAns);
  final int qNum;
  List qAns;

  // String rawJson = '{"questions":["活発で、外向的だと思う","他人に不満をもち、もめごとを起こしやすいと思う","しっかりしていて、自分に厳しいと思う","心配性で、うろたえやすいと思う","新しいことが好きで、変わった考えをもつと思う","ひかえめで、おとなしいと思う","人に気をつかう、やさしい人間だと思う","だらしなく、うっかりしていると思う","冷静で、気分が安定していると思う","発想力に欠けた、平凡な人間だと思う"],"choices":["全く違うと思う","おおよそ違うと思う","少し違うと思う","どちらでもない","少しそう思う","まあまあそう思う","強くそう思う"]}';
  final Map<String, dynamic> bigFive = jsonDecode(
    '{"questions":["活発で、外向的だと思う","他人に不満をもち、もめごとを起こしやすいと思う","しっかりしていて、自分に厳しいと思う","心配性で、うろたえやすいと思う","新しいことが好きで、変わった考えをもつと思う","ひかえめで、おとなしいと思う","人に気をつかう、やさしい人間だと思う","だらしなく、うっかりしていると思う","冷静で、気分が安定していると思う","発想力に欠けた、平凡な人間だと思う"],"choices":["全く違うと思う","おおよそ違うと思う","少し違うと思う","どちらでもない","少しそう思う","まあまあそう思う","強くそう思う"]}',
  );

  final List<String> bigFiveChoices = [
    "全く違うと思う",
    "おおよそ違うと思う",
    "少し違うと思う",
    "どちらでもない",
    "少しそう思う",
    "まあまあそう思う",
    "強くそう思う"
  ];

  void _handleRadioButton(int selectedAnswer) => setState(() {
        _selectedAnswer = selectedAnswer;
      });

  var resData = '';
  Future<void> _send() async {
    final url =
        'https://prod-25.japaneast.logic.azure.com:443/workflows/30d56a15a6bf47c688ea116f605a33a8/triggers/manual/paths/invoke?api-version=2016-10-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=W7kPGfhHtHFWF_2U3weEfXdX_vZXypGZhJGSVgnl--o';
    var request = new BigFive(
        userId: 'test', ansTime: DateTime.now().toString(), qAns10: qAns // ,
        // mealCount: _selectedItemMealCount.value
        );
    var body = json.encode(request.toJson());
    final Map<String, String> headers = {'Content-Type': 'application/json'};

    final res = await http.post(url, headers: headers, body: body);

    if (res.body.isNotEmpty) {
      final data = json.decode(res.body);
      resData = data.statusCode.toString();
      print(resData);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Big Five Test : Q" + (qNum + 1).toString()),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Text(
              //   qNum.toString(),
              // ),
              Text(
                "Q" + (qNum + 1).toString() + ".  " + bigFive["questions"][qNum],
                style: TextStyle(fontSize: 18),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        value: 0,
                        // value: bigFive["choices"][0].toString(),
                        groupValue: _selectedAnswer,
                        onChanged: _handleRadioButton,
                      ),
                      Text(bigFive["choices"][0]),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        value: 1,
                        groupValue: _selectedAnswer,
                        onChanged: _handleRadioButton,
                      ),
                      Text(bigFive["choices"][1]),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        value: 2,
                        groupValue: _selectedAnswer,
                        onChanged: _handleRadioButton,
                      ),
                      Text(bigFive["choices"][2]),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        value: 3,
                        groupValue: _selectedAnswer,
                        onChanged: _handleRadioButton,
                      ),
                      Text(bigFive["choices"][3]),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        value: 4,
                        groupValue: _selectedAnswer,
                        onChanged: _handleRadioButton,
                      ),
                      Text(bigFive["choices"][4]),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        value: 5,
                        groupValue: _selectedAnswer,
                        onChanged: _handleRadioButton,
                      ),
                      Text(bigFive["choices"][5]),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        value: 6,
                        groupValue: _selectedAnswer,
                        onChanged: _handleRadioButton,
                      ),
                      Text(bigFive["choices"][6]),
                    ],
                  ),
                  // Column(
                  //   children: bigFive["choices"]
                  //       .map(
                  //         (String key) => ListTile(
                  //           title: Text('hoge'),
                  //           leading: Radio(
                  //             value: key,
                  //             groupValue: _selectedAnswer,
                  //             onChanged: _handleRadioButton,
                  //           ),
                  //         ),
                  //       )
                  //       .toList(),
                  // ),
                  // Text(bigFive["choices"][0]),
                ],
              ),
              Text(
                '回答の確認：' + bigFive["choices"][_selectedAnswer],
                style: TextStyle(fontSize: 14),
              ),
              RaisedButton(
                child: Text(
                  '次へ',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                color: Colors.red,
                onPressed: () {
                  // Navigator.pop(context);
                  print(_selectedAnswer);

                  if (qAns == null) {
                    qAns = [];
                    print("init array");
                  }
                  // qAns.add(_selectedAnswer);
                  // print(qAns);
                  print(qNum);
                  qAns[qNum] = _selectedAnswer;
                  print(qAns);

                  if (qAns[9] == -1) {
                    print("<10");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PersonalityTest(qNum + 1, qAns),
                      ),
                    );
                  } else {
                    print("10");
                    _send();
                    // Navigator.pushNamed(context, '/');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CompleteAnswer(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      );
}
