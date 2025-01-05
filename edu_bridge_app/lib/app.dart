import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EduBridge extends StatelessWidget {
  const EduBridge({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        body: Center(
          child: Text("Hello World"),
        ),
      ),
    );
  }
}
