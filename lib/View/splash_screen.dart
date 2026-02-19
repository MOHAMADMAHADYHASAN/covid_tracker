import 'dart:async';

import 'package:flutter/material.dart';

import 'dart:math' as math;
import 'package:covid_tracker/world_states.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: Duration(seconds: 2),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (contex) => WorldStateScreen()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 35),
            AnimatedBuilder(
              animation: _animationController,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width * 0.50,
                child: Center(
                  child: Image(image: AssetImage("images/virus.png")),
                ),
              ),
              builder: (context, Widget? child) {
                return Transform.rotate(
                  angle: _animationController.value * 2.0 * math.pi,
                  child: Center(child: child),
                );
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Covid _19 \nTracker App",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
