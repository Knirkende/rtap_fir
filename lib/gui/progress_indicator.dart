import 'package:flutter/material.dart';

class UsbProgressIndicator extends StatefulWidget {
  const UsbProgressIndicator({super.key});

  @override
  State<UsbProgressIndicator> createState() =>
      _UsbProgressIndicatorState();
}

class _UsbProgressIndicatorState extends State<UsbProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
      setState(() {});
    });
    controller.repeat(reverse: false);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      value: controller.value,
      semanticsLabel: 'Progress indicator',
    );
  }
}
