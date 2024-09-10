import 'package:lms/util/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoDataWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoDataWidgetState();
  }
}

class NoDataWidgetState extends State<NoDataWidget> {
  @override
  Widget build(BuildContext context) {
    return _buildNoDataWidget();
  }

  Widget _buildNoDataWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(Strings.no_data),
        ],
      ),
    );
  }
}
