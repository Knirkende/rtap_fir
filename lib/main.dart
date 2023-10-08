import 'package:flutter/material.dart';
import 'package:rtap_fir/gui/serial_selector.dart';

import 'package:rtap_fir/service/file_service.dart';
import 'package:rtap_fir/service/serial_port_service.dart';

import 'package:rtap_fir/gui/channel.dart';
import 'package:rtap_fir/gui/progress_indicator.dart';

void main() {
  runApp(const PrimaryWindow());
}

class PrimaryWindow extends StatelessWidget {
  const PrimaryWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'rTap9000',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white60),
        useMaterial3: true,
      ),
      home: const PrimaryView(title: 'rTap9000'),
    );
  }
}

class PrimaryView extends StatefulWidget {
  const PrimaryView({super.key, required this.title});

  final String title;

  @override
  State<PrimaryView> createState() => _PrimaryViewState();
}

class _PrimaryViewState extends State<PrimaryView> {
  final List<Channel> _inputChannels = [];
  final int _numOfChannels = 4;
  final FileService fileService = FileService();

  @override
  void initState() {
    super.initState();
    _inputChannels.addAll([
      for (var i = 1; i <= _numOfChannels; i++)
        Channel(identifier: i, fileService: fileService)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: Text(
      //     widget.title,
      //   ),
      // ),
      body: Column(
        children: [
          ..._inputChannels,
          const SerialSelector(),
        ],
      ),
    );
  }
}
