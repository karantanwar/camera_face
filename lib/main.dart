import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  cameras = await availableCameras();
  runApp(HomeApp());
}

class HomeApp extends StatefulWidget {
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera',
      home: CameraApp(),
    );
  }
}

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  CameraController controller;

  @override
  void initState() {
    super.initState();
    print(cameras);
    controller = CameraController(cameras[1], ResolutionPreset.high);
    
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }

    return new Stack(
      alignment: FractionalOffset.center,
      children: <Widget>[
        new Positioned.fill(
          child: new AspectRatio(aspectRatio: controller.value.aspectRatio, child: new CameraPreview(controller)),
        ),
        new Positioned.fill(
          child: new Opacity(
            opacity: 1,
            child: Image(
              image: AssetImage(
                'assets/img/overlay.png',
              ),
              fit: BoxFit.fill,
            ),
          ),
        ),
        new Positioned(
          bottom: 0.0,
          child: new Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            margin: const EdgeInsets.all(0.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Align(
                  alignment: Alignment.bottomCenter,
                  child: new ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new OutlineButton(
                        onPressed: () {},
                        child: new Text(
                          "reverse",
                          style: new TextStyle(color: Colors.white),
                        ),
                      ),
                      new RaisedButton(
                        color: Colors.white,
                        onPressed: null,
                        child: new Text(
                          "click",
                          style: new TextStyle(color: Colors.black),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
    // return AspectRatio(aspectRatio: controller.value.aspectRatio, child: CameraPreview(controller));
  }
}
