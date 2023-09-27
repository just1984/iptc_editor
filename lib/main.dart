import 'package:flutter/material.dart';
import 'extractIptcData.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('IPTC Extractor')),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              final iptcData = await extractIptcData('assets/images/20230722-Boris Niehaus-DSC_2782.jpg');
              print(iptcData);
            },
            child: Text('Extract IPTC Data'),
          ),
        ),
      ),
    );
  }
}
