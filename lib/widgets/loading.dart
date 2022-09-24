import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent[100],
      child: Center(
          child: SpinKitChasingDots(
        color: Colors.greenAccent[700],
        size: 100.0,
      )),
    );
  }
}
