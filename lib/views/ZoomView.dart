import 'package:flutter/material.dart';

class ZoomView extends StatefulWidget {
  const ZoomView({super.key});

  @override
  State<ZoomView> createState() => _ZoomViewState();
}

class _ZoomViewState extends State<ZoomView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InteractiveViewer(
                  child: Image.network('https://rare-gallery.com/thumbs/582381-hawaii-wallpaper.jpg')
              )
            ],
          )
        )
      ),
    );
  }
}