import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:number_detector/screens/result.dart';
import 'package:tflite/tflite.dart';

import '../widgets/loading.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PickedFile _image;
  // ignore: prefer_typing_uninitialized_variables
  late String result;
  bool selectFromGallery = true;
  bool isImageLoading = false;
  getImage() async {
    // ignore: prefer_typing_uninitialized_variables
    final image;
    // ignore: prefer_typing_uninitialized_variables
    final res;
    if (selectFromGallery) {
      // ignore: deprecated_member_use
      image = await ImagePicker().getImage(source: ImageSource.gallery);
    } else {
      // ignore: deprecated_member_use
      image = await ImagePicker().getImage(source: ImageSource.camera);
    }

    res = await predict(image);

    setState(() {
      _image = image;
      result = res;
      isImageLoading = false;
    });
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Result(
                  image: File(_image.path),
                  result: result,
                )));
  }

  loadModel() async {
    await Tflite.loadModel(
        labels: "assets/labels.txt", model: "assets/model.tflite");
  }

  predict(PickedFile file) async {
    List? res = await Tflite.runModelOnImage(
        path: file.path,
        numResults: 2,
        threshold: 0.2,
        imageMean: 127.5,
        imageStd: 127.5);

    if (res![0]["confidence"] > 0.5) {
      return (res[0]['label']);
    } else {
      return "Could not determine the number";
    }
  }

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  @override
  Widget build(BuildContext context) {
    return isImageLoading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              title: const Text(
                "Hand Written Number Detector",
                style: TextStyle(
                    fontSize: 20, letterSpacing: 1.5, color: Colors.white),
              ),
              centerTitle: true,
              elevation: 0,
            ),
            body: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.deepOrange[700],
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.camera_enhance_outlined,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: () async {
                          setState(() {
                            selectFromGallery = false;
                            isImageLoading = true;
                          });
                          await getImage();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Take a Photo",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.deepOrange[700],
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.deepOrange[700],
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.photo_size_select_large_outlined,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: () async {
                          setState(() {
                            selectFromGallery = true;
                            isImageLoading = true;
                          });
                          await getImage();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Choose a Photo",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.deepOrange[700],
                        letterSpacing: 1.5,
                      ),
                    )
                  ]),
            ),
          );
  }
}
