import 'package:flutter/material.dart';

class RunModePage extends StatefulWidget {
  const RunModePage({super.key});

  @override
  State<RunModePage> createState() => _RunModePageState();
}

class _RunModePageState extends State<RunModePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Run Mode Page'),
    );
  }
}
