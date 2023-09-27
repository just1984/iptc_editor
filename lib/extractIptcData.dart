import 'dart:typed_data';
import 'package:flutter/services.dart';

Future<Map<String, dynamic>> extractIptcData(String assetPath) async {
  Map<String, dynamic> iptcData = {};

  Map<int, String> iptcTags = {
    0x0150: "ApplicationRecordVersion",
    0x005A: "By-line",
    0x0069: "Caption",
    0x0050: "By-line Title",
    0x0074: "Object Name",
    0x0037: "Image Headline",
    0x000F: "Category",
    0x0019: "Supplemental Categories",
    0x0028: "Keywords",
    0x006E: "Image Orientation",
    0x0058: "City",
    0x0060: "Province/State",
    0x0063: "Country/Primary Location Name",
    0x0064: "Country/Primary Location Code",
    0x0001: "MakerNoteVersion",
    0x0002: "ISO",
    0x0003: "ColorMode",
    0x0004: "Quality",
    0x0005: "WhiteBalance",
    0x0006: "Sharpness",
    0x0007: "FocusMode",
    0x0008: "FlashSetting",
    0x0009: "FlashType",
    0x000b: "WhiteBalanceFineTune",
    0x000c: "WB_RBLevels",
    0x000d: "ProgramShift",
    0x000e: "ExposureDifference",
    0x000f: "ISOSelection",
    0x0010: "DataDump",
    0x0011: "PreviewIFD",
    0x0012: "FlashExposureComp",
    0x0013: "ISOSetting",
    0x0014: "ColorBalanceA_NRWData",
    0x0016: "ImageBoundary",
    0x0017: "ExternalFlashExposureComp",
    0x0018: "FlashExposureBracketValue",
    0x0019: "ExposureBracketValue",
    0x001a: "ImageProcessing",
    0x001b: "CropHiSpeed",
    0x001c: "ExposureTuning",
    0x001d: "SerialNumber",
    0x001e: "ColorSpace",
    0x001f: "VRInfo",
    0x0020: "ImageAuthentication",
    0x0021: "FaceDetect",
    0x0022: "ActiveD-Lighting",
    0x0023: "PictureControlData",
    0x0024: "WorldTime",
    0x0025: "ISOInfo",
    0x002a: "VignetteControl",
    0x002b: "DistortInfo",
    0x002c: "UnknownInfo",
    0x0032: "UnknownInfo2",
    0x0034: "ShutterMode",
    0x0035: "HDRInfo",
    0x0037: "MechanicalShutterCount",
    0x0039: "LocationInfo",
    0x003d: "BlackLevel",
    0x003e: "ImageSizeRAW",
    0x003f: "WhiteBalanceFineTune",
    0x0044: "JPGCompression",
    0x0045: "CropArea",
    0x004e: "NikonSettings",
    0x004f: "ColorTemperatureAuto",
    0x0080: "ImageAdjustment",
    0x0081: "ToneComp",
    0x0082: "AuxiliaryLens",
    0x0083: "LensType",
  };


  try {
    final ByteData data = await rootBundle.load(assetPath);
    final ByteBuffer buffer = data.buffer;
    final ByteData byteData = ByteData.view(buffer);

    for (int i = 0; i < byteData.lengthInBytes - 4; i++) {
      if (byteData.getUint8(i) == 0x1C) {
        final tag = byteData.getUint16(i + 1, Endian.big);
        final length = byteData.getUint16(i + 3, Endian.big);

        String tagName = iptcTags[tag] ?? tag.toString();
        if (iptcTags.containsKey(tag)) {
          tagName = iptcTags[tag] ?? tagName;
          print("Tag: $tagName, Length: $length");
        }

        if (i + 5 + length > byteData.lengthInBytes) {
          print("Skipping invalid range.");
          continue;
        }

        final dataBytes = byteData.buffer.asUint8List(i + 5, length);
        final dataString = String.fromCharCodes(dataBytes);

        print("Tag: $tagName, Data: $dataString");
        iptcData[tagName] = dataString;

        i += 4 + length;
      }
    }
  } catch (e) {
    print("Error reading IPTC data: $e");
  }

  return iptcData;
}