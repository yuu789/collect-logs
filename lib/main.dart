import 'package:myapp/meal_report.dart';
import 'package:myapp/personality_test.dart';
import 'package:myapp/screen_time_picker.dart';

import 'package:flutter/material.dart';
// import 'dart:convert';

void main() => runApp(
      MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => MainPersistentTabBar(),
          // '/second': (context) => SecondScreen(),
          // '/meal_report': (context) => MealReport(),
          // '/personaliry_test': (context) => PersonalityTest(0),
        },
      ),
    );

class MainPersistentTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('App'),
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.lunch_dining),
                  text: "Meal Report",
                ),
                Tab(
                  icon: Icon(Icons.receipt_long_rounded),
                  text: "Usage Stats",
                ),
                Tab(
                  icon: Icon(Icons.person_search_sharp),
                  text: "Big Five",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'ご飯を食べたら\nレポートを送信してください',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        RaisedButton(
                          child: Text(
                            'はじめる',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          color: Colors.red,
                          onPressed: () {
                            // Navigator.pushNamed(context, '/meal_report');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MealReport(),
                              ),
                            );
                          },
                        ),
                      ]),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('', style: TextStyle(fontSize: 0)),
                    Text(
                      'スクリーンタイムを撮影して\n送信してください',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    RaisedButton(
                      child: Text(
                        'はじめる',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.red,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScreenTimePicker(),
                          ),
                        );
                      },
                      // onPressed: () {
                      //   Navigator.pushNamed(context, '/personaliry_test');
                      // },
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   '◆撮影してほしいもの',
                        //   style: TextStyle(
                        //     fontSize: 15,
                        //   ),
                        // ),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyText1,
                            children: [
                              WidgetSpan(
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 16,
                                ),
                              ),
                              TextSpan(
                                text: ' 撮影してほしいもの',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text('', style: TextStyle(fontSize: 4)),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: Column(
                            children: [
                              Text(
                                'Android: 設定 > デジタルウェルビーイングとペアレンタルコントロール > ダッシュボード > 「更に表示」を押した画面',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              Text('', style: TextStyle(fontSize: 3)),
                              Text(
                                'iOS: 設定 > スクリーンタイム > すべてのアクティビティを確認する > よく使われたもの > 「表示を増やす」を押した画面',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Center(
                  //child: Text("Page 2")
                  // child: PersonalityTest(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: Text(
                          'ここにBigFiveの\n説明文や注意書きを\n書いたりする',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Center(
                        child: RaisedButton(
                          child: Text(
                            'はじめる',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          color: Colors.red,
                          onPressed: () {
                            var ansArr = new List.filled(10, -1);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PersonalityTest(0, ansArr),
                              ),
                            );
                          },
                          // onPressed: () {
                          //   Navigator.pushNamed(context, '/personaliry_test');
                          // },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

// class SecondScreen extends StatelessWidget {
//   // String rawJson = '{"questions":["活発で、外向的だと思う","他人に不満をもち、もめごとを起こしやすいと思う","しっかりしていて、自分に厳しいと思う","心配性で、うろたえやすいと思う","新しいことが好きで、変わった考えをもつと思う","ひかえめで、おとなしいと思う","人に気をつかう、やさしい人間だと思う","だらしなく、うっかりしていると思う","冷静で、気分が安定していると思う","発想力に欠けた、平凡な人間だと思う"],"choices":["全く違うと思う","おおよそ違うと思う","少し違うと思う","どちらでもない","少しそう思う","まあまあそう思う","強くそう思う"]}';
//   final Map<String, dynamic> bigFive = jsonDecode(
//       '{"questions":["活発で、外向的だと思う","他人に不満をもち、もめごとを起こしやすいと思う","しっかりしていて、自分に厳しいと思う","心配性で、うろたえやすいと思う","新しいことが好きで、変わった考えをもつと思う","ひかえめで、おとなしいと思う","人に気をつかう、やさしい人間だと思う","だらしなく、うっかりしていると思う","冷静で、気分が安定していると思う","発想力に欠けた、平凡な人間だと思う"],"choices":["全く違うと思う","おおよそ違うと思う","少し違うと思う","どちらでもない","少しそう思う","まあまあそう思う","強くそう思う"]}');

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(
//           title: Text('Q1'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Text(bigFive["questions"][0]),
//               Text(bigFive["choices"][0]),
//               RaisedButton(
//                 child: Text('次へ'),
//                 onPressed: () {
//                   // Navigator.pop(context);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => TestDropdownButton(),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       );
// }
