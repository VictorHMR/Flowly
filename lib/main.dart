import 'package:flutter/material.dart';

void main() {
  runApp(const FlowlyApp());
}

class FlowlyApp extends StatelessWidget {
  const FlowlyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Center(child: Text('Olá mundo'))),
    );
  }
}
