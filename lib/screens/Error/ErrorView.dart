import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String errorMsg;
  const ErrorView({Key key, this.errorMsg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Error"),
      ),
      body: SafeArea(
        child: Text(errorMsg),
      ),
    );
  }
}
