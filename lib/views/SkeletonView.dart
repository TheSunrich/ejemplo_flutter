import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonView extends StatefulWidget {
  const SkeletonView({super.key});

  @override
  State<SkeletonView> createState() => _SkeletonViewState();
}

class _SkeletonViewState extends State<SkeletonView> {
  late FToast fToast;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  void showToast(String text, {required Color color, IconData? icon}) {
    fToast.showToast(
      child: Container(
        padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: color,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon),
            const SizedBox(
              width: 12.0,
            ),
            Text(text),
          ],
        ),
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              ElevatedButton(
                  onPressed: () => {setState(() => isLoading = !isLoading)},
                  child: const Text('Toggle')
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.796,
                child: isLoading
                    ? SkeletonListView() :ListView(
                  padding: const EdgeInsets.all(8),
                  children: List.generate(7, (index) {
                    return Container(
                      margin: const EdgeInsets.all(12),
                      child: Text('Item $index'),
                    );
                  }),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
