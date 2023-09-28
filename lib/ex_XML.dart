import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:xml/xml.dart';

Future<void> extractXmlData(String assetPath) async {
  final ByteData byteData = await rootBundle.load(assetPath);
  final String xmlStr = String.fromCharCodes(byteData.buffer.asUint8List());

  final XmlDocument xmlDocument = XmlDocument.parse(xmlStr);

  if (kDebugMode) {
    if (xmlDocument.children.isEmpty) {
      print("No XML information found");
    } else {
      for (XmlNode node in xmlDocument.rootElement.children) {
        if (node is XmlElement) {
          print("Tag: ${node.name.local}, Value: ${node.text}");
          for (var attribute in node.attributes) {
            if (kDebugMode) {
              print("Attribute: ${attribute.name}, Value: ${attribute.value}");
            }
          }
        }
      }
    }
  }
}
