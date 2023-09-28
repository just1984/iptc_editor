import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'ex_IPTC.dart';
import 'ex_EXIF.dart';
import 'ex_XML.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: const Text('Metadata Extractor')),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    final iptcData =
                    await extractIptcData('assets/images/Test_3.jpg');
                    if (kDebugMode) {
                      print(iptcData);
                    }
                  },
                  child: const Text('Extract IPTC Data'),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await extractExifData('assets/images/Test_3.jpg');
                  },
                  child: const Text('Extract EXIF Data'),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await extractXmlData('assets/images/Test_3.jpg');
                  },
                  child: const Text('Extract XML Data'),
                ),
              ),
            ],
          )),
    );
  }
}