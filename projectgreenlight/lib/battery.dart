import 'package:flutter/material.dart';

class Battery extends StatefulWidget {
  const Battery({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BatteryState createState() => _BatteryState();
}

class _BatteryState extends State<Battery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Greenlight',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const Center(
        child: Text("Battery Page"),
      ),
    );
  }
}
