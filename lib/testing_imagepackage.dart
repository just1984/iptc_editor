import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:exif/exif.dart';

Future<void> extractExifData(String assetPath) async {
  final ByteData byteData = await rootBundle.load(assetPath);
  final List<int> uint8List = byteData.buffer.asUint8List();

  final Map<String, IfdTag> exifData = await readExifFromBytes(uint8List);

  if (kDebugMode) {
    if (exifData.isEmpty) {
      print("No EXIF information found");
    } else {
      for (String ifd in exifData.keys) {
        print("$ifd (${exifData[ifd]!.tagType}): ${exifData[ifd]}");
      }
    }
  }
}
