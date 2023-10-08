import 'package:flutter/material.dart';

import 'package:rtap_fir/config/status_message.dart';

import 'package:rtap_fir/model/bin_array.dart';

import '../service/file_service.dart';

class Channel extends StatefulWidget {
  final int identifier;
  final FileService fileService;

  const Channel({key, required this.identifier, required this.fileService})
      : super(key: key);

  @override
  State<Channel> createState() => _ChannelState();
}

class _ChannelState extends State<Channel> {
  late final FileService _fileService;
  BinArray? _binArray;
  String _statusMessage = StatusMessage.waiting;
  Function()? _channelButtonAction;
  Color _statusColor = Colors.orange;
  Icon _statusIcon = Icon(Icons.clear, color: Colors.orange);

  @override
  void initState() {
    super.initState();
    _fileService = widget.fileService;
    _channelButtonAction = _setBinArray;
  }

  void _setBinArray() async {
    //TODO button disable broken due to ffi version req by usb module
    //Maybe file selector window halts main thread
    setState(() {
      _channelButtonAction = null;
    });

    _binArray = await _fileService.loadFileToBinArray();

    setState(() {
      _channelButtonAction = _setBinArray;
      _setStatus();
    });
  }

  void _setStatus() {
    if ( _binArray == null ) {
      _statusMessage = StatusMessage.waiting;
      _statusColor = Colors.orange;
      _statusIcon = Icon(Icons.clear, color: _statusColor);
    } else if ( _binArray!.getFixedPointArr().isEmpty ) {
      _statusMessage = StatusMessage.error;
      _statusColor = Colors.red;
      _statusIcon = Icon(Icons.clear, color: _statusColor);
    } else {
      _statusMessage = StatusMessage.ok;
      _statusColor = Colors.green;
      _statusIcon = Icon(Icons.check, color: _statusColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.background,
      shadowColor: Theme.of(context).colorScheme.primary,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  _statusIcon,
                  Text("Channel ${widget.identifier}"),
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: _channelButtonAction,
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: BorderSide(
                                      color: _statusColor)))),
                      child: const Text("Select file")),
                  const SizedBox(width: 10.0),
                  Text(_statusMessage),
                ],
              ),
            ]),
      ),
    );
  }
}
