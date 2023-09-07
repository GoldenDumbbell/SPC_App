import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).primaryColor), // Customize color
          strokeWidth: 5, // Customize thickness
        ),
      ),
    );
  }
}
