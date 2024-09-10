import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorMessageWidget extends StatefulWidget {
  final String? error;

  ErrorMessageWidget({Key? key, this.error}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ErrorMessageWidgetState();
  }
}

class ErrorMessageWidgetState extends State<ErrorMessageWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.error!),
        ],
      ),
    );
  }
}
