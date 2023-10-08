import 'dart:io';

import 'package:file_picker/file_picker.dart';

import 'package:rtap_fir/model/bin_array.dart';

class FileService {
  Future<String?> _getPath() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        dialogTitle: "Select file",
        initialDirectory: Directory.current.path,
        type: FileType.custom,
        allowedExtensions: ['bin'],
    lockParentWindow: true);
    return result != null ? result.files.single.path! : null;
  }

  Future<File?> _pickFile() async {
    String? path = await _getPath();
    File? file = path != null ? File(path) : null;
    return file;
  }

  Future<BinArray?> loadFileToBinArray() async {
    File? file = await _pickFile();
    if (file != null) {
      return await BinArray.create(file);
    }
    return null;
  }
}
