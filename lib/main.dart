import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.amber,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController controller;

  var lastPosition = 0.0;
  var random = Random();
  double getRandomNumber() {
    lastPosition = random.nextDouble();
    return lastPosition;
  }

  @override
  void initState() {
    super.initState();
    spinTheBottle();
  }

  spinTheBottle() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "images/block.jpg",
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: Container(
              child: RotationTransition(
                turns: Tween(begin: lastPosition, end: getRandomNumber())
                    .animate(CurvedAnimation(
                        parent: controller, curve: Curves.decelerate)),
                child: GestureDetector(
                  onTap: () {
                    if (controller.isCompleted) {
                      setState(() {
                        spinTheBottle();
                      });
                    }
                  },
                  child: Image.asset(
                    "images/bottle.png",
                    width: 250.0,
                    height: 250.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
