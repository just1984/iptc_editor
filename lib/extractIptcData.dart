import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

Map<int, String> iptcTags = {
  0x0100: "TAG_ENVELOPE_RECORD_VERSION",
  0x0105: "TAG_DESTINATION",
  0x0114: "TAG_FILE_FORMAT",
  0x0116: "TAG_FILE_VERSION",
  0x011E: "TAG_SERVICE_ID",
  0x0128: "TAG_ENVELOPE_NUMBER",
  0x0132: "TAG_PRODUCT_ID",
  0x013C: "TAG_ENVELOPE_PRIORITY",
  0x0146: "TAG_DATE_SENT",
  0x0150: "TAG_TIME_SENT",
  0x015A: "TAG_CODED_CHARACTER_SET",
  0x0164: "TAG_UNIQUE_OBJECT_NAME",
  0x0178: "TAG_ARM_IDENTIFIER",
  0x017A: "TAG_ARM_VERSION",
  0x0200: "TAG_APPLICATION_RECORD_VERSION",
  0x0203: "TAG_OBJECT_TYPE_REFERENCE",
  0x0204: "TAG_OBJECT_ATTRIBUTE_REFERENCE",
  0x0205: "TAG_OBJECT_NAME",
  0x0207: "TAG_EDIT_STATUS",
  0x0208: "TAG_EDITORIAL_UPDATE",
  0x020A: "TAG_URGENCY",
  0x020C: "TAG_SUBJECT_REFERENCE",
  0x020F: "TAG_CATEGORY",
  0x0214: "TAG_SUPPLEMENTAL_CATEGORIES",
  0x0216: "TAG_FIXTURE_ID",
  0x0219: "TAG_KEYWORDS",
  0x021A: "TAG_CONTENT_LOCATION_CODE",
  0x021B: "TAG_CONTENT_LOCATION_NAME",
  0x021E: "TAG_RELEASE_DATE",
  0x0223: "TAG_RELEASE_TIME",
  0x0225: "TAG_EXPIRATION_DATE",
  0x0226: "TAG_EXPIRATION_TIME",
  0x0228: "TAG_SPECIAL_INSTRUCTIONS",
  0x022A: "TAG_ACTION_ADVISED",
  0x022D: "TAG_REFERENCE_SERVICE",
  0x022F: "TAG_REFERENCE_DATE",
  0x0232: "TAG_REFERENCE_NUMBER",
  0x0237: "TAG_DATE_CREATED",
  0x023C: "TAG_TIME_CREATED",
  0x023E: "TAG_DIGITAL_DATE_CREATED",
  0x023F: "TAG_DIGITAL_TIME_CREATED",
  0x0241: "TAG_ORIGINATING_PROGRAM",
  0x0246: "TAG_PROGRAM_VERSION",
  0x024B: "TAG_OBJECT_CYCLE",
  0x0250: "TAG_BY_LINE",
  0x0255: "TAG_BY_LINE_TITLE",
  0x025A: "TAG_CITY",
  0x025C: "TAG_SUB_LOCATION",
  0x025F: "TAG_PROVINCE_OR_STATE",
  0x0264: "TAG_COUNTRY_OR_PRIMARY_LOCATION_CODE",
  0x0265: "TAG_COUNTRY_OR_PRIMARY_LOCATION_NAME",
  0x0267: "TAG_ORIGINAL_TRANSMISSION_REFERENCE",
  0x0269: "TAG_HEADLINE",
  0x026E: "TAG_CREDIT",
  0x0273: "TAG_SOURCE",
  0x0274: "TAG_COPYRIGHT_NOTICE",
  0x0276: "TAG_CONTACT",
  0x0278: "TAG_CAPTION",
  0x0279: "TAG_LOCAL_CAPTION",
  0x027A: "TAG_CAPTION_WRITER",
  0x027D: "TAG_RASTERIZED_CAPTION",
  0x0282: "TAG_IMAGE_TYPE",
  0x0283: "TAG_IMAGE_ORIENTATION",
  0x0287: "TAG_LANGUAGE_IDENTIFIER",
  0x0296: "TAG_AUDIO_TYPE",
  0x0297: "TAG_AUDIO_SAMPLING_RATE",
  0x0298: "TAG_AUDIO_SAMPLING_RESOLUTION",
  0x0299: "TAG_AUDIO_DURATION",
  0x029A: "TAG_AUDIO_OUTCUE",
  0x02B8: "TAG_JOB_ID",
  0x02B9: "TAG_MASTER_DOCUMENT_ID",
  0x02BA: "TAG_SHORT_DOCUMENT_ID",
  0x02BB: "TAG_UNIQUE_DOCUMENT_ID",
  0x02BC: "TAG_OWNER_ID",
  0x02C8: "TAG_OBJECT_PREVIEW_FILE_FORMAT",
  0x02C9: "TAG_OBJECT_PREVIEW_FILE_FORMAT_VERSION",
  0x02CA: "TAG_OBJECT_PREVIEW_DATA",
};

Future<ByteData> loadImageData(String assetPath) async {
  try {
    return await rootBundle.load(assetPath);
  } on FlutterError catch (e) {
    print('Error loading image data: $e');
    rethrow;
  }
}

String extractTagData(ByteData byteData, int index, int length) {
  final dataBytes = byteData.buffer.asUint8List(index + 5, length);

  bool isText = dataBytes.every((byte) => byte >= 32 && byte <= 126);

  if (isText) {
    return String.fromCharCodes(dataBytes);
  } else {
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

      String tagName = iptcTags[tag] ?? tag.toString();
      String hexTag = "(0x${tag.toRadixString(16).toUpperCase().padLeft(4, '0')})";

      if (iptcTags.containsKey(tag)) {
       // print("Tag: $hexTag $tagName, Length: $length");
      }

      if (i + 5 + length > byteData.lengthInBytes) {
        i++;
        continue;
      }

      final dataString = extractTagData(byteData, i, length);

      print("Tag: $hexTag $tagName, Data: $dataString");
      iptcData[tagName] = dataString;
      i += 4 + length;
    } else {
      i++;
    }
  }

  return iptcData;
}