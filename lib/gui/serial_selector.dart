import 'package:flutter/material.dart';
import 'dart:isolate';

import 'package:rtap_fir/gui/progress_indicator.dart';

import '../service/serial_port_service.dart';

class SerialSelector extends StatefulWidget {
  const SerialSelector({super.key});

  @override
  State<SerialSelector> createState() => _SerialSelectorState();
}

class _SerialSelectorState extends State<SerialSelector> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading == true
        ? const UsbProgressIndicator()
        : ElevatedButton(
            onPressed: () async {
              setState(() {
                _isLoading = true;
              });
              await Isolate.run(() => SerialPortService.usbTest());
              setState(() {
                _isLoading = false;
              });
            },
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ))),
            child: const Text("Scan for serial device"),
          );
  }
}

/*
* _isLoading == true
              ? const UsbProgressIndicator()
              : ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    await Isolate.run(() => SerialPortService.usbTest());
                    setState(() {
                      _isLoading = false;
                    });
                  },
                  child: const Text("Scan for serial device"),
          ),*/
