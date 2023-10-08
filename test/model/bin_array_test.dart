import 'dart:ffi';
import 'dart:typed_data';

import 'package:file/memory.dart';
import 'package:rtap_fir/model/bin_array.dart';
import 'package:test/test.dart';

void main() {
  group ('Process file', () {
    test('Fixed point array calculated from valid input file', () async {
      var bytes = [50, 74, 163, 177, 229, 28, 158, 178, 156, 153, 43, 179, 11, 154, 146, 179];
      Uint8List byteArr = Uint8List(16);
      for (var i = 0; i < 16; i++) {
        byteArr[i]= bytes[i];
      }
      var file = MemoryFileSystem().file('test.bin');
      file.writeAsBytes(byteArr);
      var binArr = await BinArray.create(file);

      expect(binArr.getFixedPointArr(), equals([34359738368, 19586341548, -3726447990, -34359738368]));
    });

    test('Faulty input format handled gracefully', () async {
      var stupidBytes = [257, 257, 257, 0];
      var file = MemoryFileSystem().file('test.bin');
      file.writeAsBytes(stupidBytes);
      var binArr = await BinArray.create(file);

      expect(binArr.getFixedPointArr(), equals([]));
    });
  });
}