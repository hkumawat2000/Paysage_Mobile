import 'package:lms/util/Colors.dart';
import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {

  final TextEditingController textEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Container(
          child: Row(
            children: <Widget>[
              Material(
                child: new Container(
                  margin: new EdgeInsets.symmetric(horizontal: 1.0),
                  child: Text(" ")
                ),
                color: Colors.white,
              ),

              // Text input
              Flexible(
                child: Container(
                  child: TextField(
                    style: TextStyle(color: appTheme, fontSize: 15.0),
                    controller: textEditingController,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Type a message',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ),


              // Send Message Button
              Material(
                child: new Container(
                  margin: new EdgeInsets.symmetric(horizontal: 8.0),
                  child: new IconButton(
                    icon: new Icon(Icons.send),
                    onPressed: () => {},
                    color: appTheme,
                  ),
                ),
                color: Colors.white,
              ),
            ],
          ),
          width: double.infinity,
          height: 50.0,
          padding: const EdgeInsets.only(left: 20, right: 20),
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(35.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(1.0, 1.0), //(x,y)
                blurRadius: 5.0,
              ),
            ],
//          borderRadius: BorderRadius.circular(35.0),
//          border: new Border(
//              top: new BorderSide(color: Colors.grey, width: 0.5),
//          ),
//          color: Colors.white),
          )),
    );
  }
}