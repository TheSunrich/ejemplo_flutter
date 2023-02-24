import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';

class SignatureView extends StatefulWidget {
  const SignatureView({super.key});

  @override
  State<SignatureView> createState() => _SignatureViewState();
}

class _SignatureViewState extends State<SignatureView> {
  ByteData _img = ByteData(0);

  final _sign = GlobalKey<SignatureState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  height: screenHeight * 0.275,
                  width: screenWidth,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black45, width: 2)),
                  child: Signature(
                    color: Colors.red,
                    key: _sign,
                    onSign: () {
                      final sign = _sign.currentState;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            final sign = _sign.currentState;
                            sign?.clear();
                          },
                          child: const Text('Reset'),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            final sign = _sign.currentState;
                            //retrieve image data, do whatever you want with it (send to server, save locally...)
                            final image = await sign?.getData();
                            var data = await image?.toByteData(format: ui.ImageByteFormat.png);
                            sign?.clear();
                            //final encoded = base64.encode(data?.buffer.asUint8List() as List<int>);
                            setState(() {
                              _img = data!;
                            });
                            //debugPrint("onPressed " + encoded);
                          },
                          child: const Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                ),
                _img.buffer.lengthInBytes == 0
                    ? Container()
                    : LimitedBox(
                        maxHeight: 200.0,
                        child: Image.memory(
                          _img.buffer.asUint8List(),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
