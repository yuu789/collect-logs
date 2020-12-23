import 'package:myapp/meal_report.dart';
import 'package:myapp/personality_test.dart';

import 'package:flutter/material.dart';
import 'dart:convert';

void main() => runApp(
      MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => MainPersistentTabBar(),
          '/second': (context) => SecondScreen(),
          '/meal_report': (context) => MealReport(),
          '/personaliry_test': (context) => PersonalityTest(),
        },
      ),
    );

class MainPersistentTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 2,
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
                  icon: Icon(Icons.person_search_sharp),
                  text: "Big 5",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('説明文'),
                      RaisedButton(
                        child: Text(
                          'ご飯を食べました！',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        color: Colors.red,
                        onPressed: () {
                          // Navigator.pushNamed(context, '/personaliry_test');
                          Navigator.pushNamed(context, '/meal_report');
                        },
                      ),
                    ]),
              ),
              Center(
                //child: Text("Page 2")
                child: PersonalityTest(),
              ),
            ],
          ),
        ),
      );
}

class SecondScreen extends StatelessWidget {
  // String rawJson = '{"questions":["活発で、外向的だと思う","他人に不満をもち、もめごとを起こしやすいと思う","しっかりしていて、自分に厳しいと思う","心配性で、うろたえやすいと思う","新しいことが好きで、変わった考えをもつと思う","ひかえめで、おとなしいと思う","人に気をつかう、やさしい人間だと思う","だらしなく、うっかりしていると思う","冷静で、気分が安定していると思う","発想力に欠けた、平凡な人間だと思う"],"choices":["全く違うと思う","おおよそ違うと思う","少し違うと思う","どちらでもない","少しそう思う","まあまあそう思う","強くそう思う"]}';
  final Map<String, dynamic> bigFive = jsonDecode(
      '{"questions":["活発で、外向的だと思う","他人に不満をもち、もめごとを起こしやすいと思う","しっかりしていて、自分に厳しいと思う","心配性で、うろたえやすいと思う","新しいことが好きで、変わった考えをもつと思う","ひかえめで、おとなしいと思う","人に気をつかう、やさしい人間だと思う","だらしなく、うっかりしていると思う","冷静で、気分が安定していると思う","発想力に欠けた、平凡な人間だと思う"],"choices":["全く違うと思う","おおよそ違うと思う","少し違うと思う","どちらでもない","少しそう思う","まあまあそう思う","強くそう思う"]}');

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Q1'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(bigFive["questions"][0]),
              Text(bigFive["choices"][0]),
              RaisedButton(
                child: Text('次へ'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      );
}
