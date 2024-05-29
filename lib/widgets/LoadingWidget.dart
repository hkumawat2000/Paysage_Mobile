import 'package:lms/util/strings.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoadingWidgetState();
  }
}

class LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return _buildLoadingWidget();
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(Strings.please_wait),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
