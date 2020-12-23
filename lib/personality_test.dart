import 'package:flutter/material.dart';

class PersonalityTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        // appBar: AppBar(
        //   title: Text('bigfive'),
        // ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Text('ここにBigFiveの\n説明文や注意書きを\n書いたりする'),
            ),
            Center(
              child: RaisedButton(
                child: Text('はじめる'),
                onPressed: () {
                  Navigator.pushNamed(context, '/second');
                },
              ),
            ),
          ],
        ),
      );
}
