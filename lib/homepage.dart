import 'dart:async';

import 'package:flutter/material.dart';
import './smiley.dart';
import './barriers.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double smileyveraxis = 0;
  double height = 0;
  double time = 0;
  double initialHeight = 0;
  bool gameStarted = false;
  static double xone = 1;
  static double xtwo = xone + 1.2;
  double xthree = xtwo + 1.2;
  double score = 0;
  double highScore = 0;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = smileyveraxis;
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.brown,
            title: Text(
              'GAME OVER',
              style: TextStyle(color: Colors.white),
            ),
            content: Text('Score : ' + score.toString()),
            actions: [
              FlatButton(
                  onPressed: () {
                    if (score > highScore) {
                      highScore = score;
                    }
                    initState();
                    setState(() {
                      gameStarted = false;
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'PLAY AGAIN ',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ))
            ],
          );
        });
  }

  void startGame() {
    gameStarted = true;
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        smileyveraxis = initialHeight - height;
      });

      setState(() {
        if (xone < -1.2) {
          xone += 3.6;
          score += 1;
        } else {
          xone -= 0.05;
        }
      });
      setState(() {
        if (xtwo < -1.2) {
          xtwo += 3.6;
          score += 1;
        } else {
          xtwo -= 0.05;
        }
      });
      setState(() {
        if (xthree < -1.2) {
          xthree += 3.6;
          score += 1;
        } else {
          xthree -= 0.05;
        }
      });

      if (smileyveraxis > 1) {
        _showDialog();
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    AnimatedContainer(
                      alignment: Alignment(0, smileyveraxis),
                      duration: Duration(milliseconds: 0),
                      color: Colors.blue,
                      child: MySmiley(),
                    ),
                    Container(
                      child: gameStarted
                          ? Text('')
                          : Text(
                              'T A P   T O   P L A Y !',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                      alignment: Alignment(0, -0.3),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 0),
                      alignment: Alignment(xone, 1.1),
                      child: MyBarrier(size: 200.0),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 0),
                      alignment: Alignment(xone, -1.1),
                      child: MyBarrier(size: 200.0),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 0),
                      alignment: Alignment(xtwo, 1.1),
                      child: MyBarrier(size: 100.0),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 0),
                      alignment: Alignment(xtwo, -1.1),
                      child: MyBarrier(size: 300.0),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 0),
                      alignment: Alignment(xthree, 1.1),
                      child: MyBarrier(size: 150.0),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 0),
                      alignment: Alignment(xthree, -1.1),
                      child: MyBarrier(size: 250.0),
                    ),
                  ],
                )),
            Container(
              color: Colors.green,
              height: 15,
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'SCORE',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(height: 20),
                        Text(
                          score.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'BEST',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(height: 20),
                        Text(
                          highScore.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
