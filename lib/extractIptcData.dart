import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'map_list_iptc.dart';
import 'dart:convert';

Future<ByteData> loadImageData(String assetPath) async {
  try {
    return await rootBundle.load(assetPath);
  } on FlutterError catch (e) {
    if (kDebugMode) {
      print('Error loading image data: $e');
    }
    rethrow;
  }
}

String extractTagData(ByteData byteData, int index, int length) {
  final dataBytes = byteData.buffer.asUint8List(index + 5, length);
  try {
    return utf8.decode(dataBytes);
  } catch (e) {
    return dataBytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join(' ');
  }
}

Future<Map<String, dynamic>> extractIptcData(String assetPath) async {
  Map<String, dynamic> iptcData = {};

  final ByteData byteData;
  try {
    byteData = await loadImageData(assetPath);
  } catch (e) {
    return {};
  }

  int i = 0;

  while (i < byteData.lengthInBytes - 4) {
    if (byteData.getUint8(i) == 0x1C) {
      final tag = byteData.getUint16(i + 1, Endian.big);
      final length = byteData.getUint16(i + 3, Endian.big);

      if (iptcTags.containsKey(tag)) {
        String tagName = iptcTags[tag] ?? tag.toString();
        String hexTag = "(0x${tag.toRadixString(16).toUpperCase().padLeft(4, '0')})";

        if (kDebugMode) {
          //print("Tag: $hexTag $tagName, Length: $length");
        }

        if (i + 5 + length > byteData.lengthInBytes) {
          i++;
          continue;
        }

        final dataString = extractTagData(byteData, i, length);

        if (kDebugMode) {
         // print("Tag: $hexTag $tagName, Data: $dataString");
        }
        iptcData[tagName] = dataString;
      }
      i += 4 + length;
    } else {
      i++;
    }
  }

  print("");
  print("");
  print("");

  for (int key in orderedKeys) {
    if (iptcTags.containsKey(key)) {
      String tagName = iptcTags[key] ?? key.toString();
      String hexTag = "(0x${key.toRadixString(16).toUpperCase().padLeft(4, '0')})";
      if (iptcData.containsKey(tagName)) {
        if (kDebugMode) {
          print("$tagName $hexTag, ${iptcData[tagName]}");
        }
      }
    }
  }

  return iptcData;
}