import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<List<File>> pickMediaFile() async {
  List<File> files = [];
  final ImagePicker picker = ImagePicker();
  final pickedFiles = await picker.pickMultiImage();
  if (pickedFiles.isNotEmpty) {
    for (final file in pickedFiles) {
      files.add(File(file.path));
    }
  }
  return files;
}
