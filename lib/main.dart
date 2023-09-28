import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'extractIptcData.dart';
import 'testing_imagepackage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: const Text('IPTC Extractor')),
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
              Center(  // Add this line
                child: ElevatedButton(
                  onPressed: () async {
                    await extractExifData('assets/images/Test_1.jpg');
                  },
                  child: const Text('Extract EXIF Data'),
                ),
              ),
            ],
          )),
    );
  }
}
