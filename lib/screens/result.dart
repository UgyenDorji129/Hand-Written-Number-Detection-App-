import 'dart:io';
import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  final File image;
  // ignore: prefer_typing_uninitialized_variables
  final result;

  const Result({Key? key, required this.image, required this.result})
      : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Result",
          style:
              TextStyle(fontSize: 20, letterSpacing: 1.5, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(top: 40),
          child: Column(children: [
            const SizedBox(height: 50),
            Container(
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255)),
              child: Expanded(child: Image.file(widget.image)),
            ),
            const SizedBox(
              height: 40,
            ),
            const Center(
              child: Text(
                "The Given Number is: ",
                style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 213, 25, 230),
                  letterSpacing: 1.5,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                (widget.result).substring(2),
                style: const TextStyle(
                  fontSize: 40,
                  color: Color.fromARGB(255, 230, 43, 10),
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
