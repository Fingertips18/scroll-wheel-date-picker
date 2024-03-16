import 'package:flutter/material.dart';

import 'src/widgets/curve_date_picker.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wheel Date Picker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CurveDatePicker(),
          ),
        ),
      ),
    );
  }
}
