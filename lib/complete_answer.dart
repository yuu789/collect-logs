import 'package:flutter/material.dart';

class CompleteAnswer extends StatelessWidget {
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('App'),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(
                      Icons.check_circle_outline_rounded,
                      size: 140,
                      color: Colors.greenAccent,
                    ),
                    Text(
                      ' 送信しました！',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                // Text('', style: TextStyle(fontSize: 18)),
                Text(
                  'ご協力ありがとうございました！',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                RaisedButton(
                  child: Text(
                    'ホーム',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.red,
                  onPressed: () {
                    Navigator.popUntil(
                      context,
                      ModalRoute.withName('/'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
