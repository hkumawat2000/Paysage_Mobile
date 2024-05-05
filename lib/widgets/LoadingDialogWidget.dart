import 'package:flutter/material.dart';

class LoadingDialogWidget {
  static showDialogLoading(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            height: 100,
            width: 30,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: new Row(
                children: [
                  new CircularProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: new Text(message),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  static showLoadingWithoutBack(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              height: 100,
              width: 30,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: new Row(
                  children: [
                    new CircularProgressIndicator(),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: new Text(message),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}