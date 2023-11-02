import 'dart:io';

import 'package:flutter/material.dart';

class ScannedMeterDetails extends StatelessWidget {
  const ScannedMeterDetails(
      {super.key, required this.file, required this.scannedText});
  final File file;
  final String scannedText;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scanned Meter',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 20),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(image: FileImage(file))),
          ),
          Text(
            'Meter number details',
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 25),
          ),
          // Text('Meter Number',
          //     style: Theme.of(context)
          //         .textTheme
          //         .headlineMedium!
          //         .copyWith(fontSize: 18)),
          Text(scannedText)
        ],
      ),
    );
  }
}
