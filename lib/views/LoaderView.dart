import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class LoaderView extends StatefulWidget {
  const LoaderView({super.key});

  @override
  State<LoaderView> createState() => _LoaderViewState();
}

class _LoaderViewState extends State<LoaderView> {
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        body: SafeArea(
          child: LoadingOverlay(
            isLoading: _saving,
            color: Colors.black,
            child: ElevatedButton(
              onPressed: () => {
                setState(() {
                  _saving = true;
                  Timer(const Duration(seconds: 3), () {
                    setState(() {
                      _saving = false;
                    });
                  });
                })
              },
              child: const Text('Save'),
            ),
          ),
        ),
      ),
    );
  }
}
