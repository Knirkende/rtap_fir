import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:binary/binary.dart';
import 'package:rtap_fir/config/rtap_config.dart';

class BinArray {

  final List<int> _fixedPointArr;

  BinArray._create(this._fixedPointArr);

  static Future<BinArray> create(File inputFile) async {
    BinArray binArray;
    Float32List floatArr;
    List<int> fixedPointArr = [];

    try {
      floatArr = await _readFloat32FromFile(inputFile);
      fixedPointArr = _toFixedPointArr(floatArr);
    } catch (e, trace) {
      //something went wrong
    } finally {
      binArray = BinArray._create(fixedPointArr);
    }
    return binArray;
  }

  static Future<Float32List> _readFloat32FromFile(File inputFile) async {
    Uint8List byteArr = await inputFile.readAsBytes();
    return byteArr.buffer.asFloat32List();
  }

  static double _normalize(double x, double xMin, double xMax) {
    return 2 * ((x - xMin) / (xMax - xMin)) - 1;
  }

  static int _toFixedPoint(double x, int fractionalBits) {
    return (x * pow(2, fractionalBits)).round();
  }

  static List <int> _toFixedPointArr(Float32List floatArr) {
    var min = double.infinity;
    var max = -double.infinity;
    for (var n in floatArr) {
      min = n < min ? n : min;
      max = n > max ? n : max;
    }
    return [
      for (var x in floatArr)
        _toFixedPoint(
            _normalize(x, min, max), RtapConfig.fixedPointFractionalBits)
    ];
  }

  void toHexString(int fixedPoint) {
    //TODO
    //print((fixedPoint & -1).toBinaryPadded(RtapConfig.fixedPointFractionalBits + 1));
    print(fixedPoint.toRadixString(16));
    
  }

  List<int> getFixedPointArr() {
    print(_fixedPointArr[5]);//TODO debug stuff
    toHexString(_fixedPointArr[5]);//TODO bug, type de-
    return _fixedPointArr;
  }
}
