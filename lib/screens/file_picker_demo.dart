//import 'dart:convert';
import 'dart:io';

import 'package:jsonfile/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
//import 'package:simple_permissions/simple_permissions.dart';
import 'pages/simple_table.dart' as simple;
import 'pages/custom_data_table.dart' as custom;

class FilePickerDemo extends StatefulWidget {
  @override
  _FilePickerDemoState createState() => new _FilePickerDemoState();
}

File file;
String contents;

class _FilePickerDemoState extends State<FilePickerDemo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: MyHome(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(backgroundColor: Colors.teal),
    );
  }
}

class MyHome extends StatelessWidget {
  bool _isButtonDisable = true;
  final snackBar = SnackBar(
    content: Text('Yay! A SnackBar!'),
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 320, 0, 0),
                  child: RaisedButton(
                    child: Text(
                      "SELECT FILE",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    onPressed: () {
                      openFileExplorer();
                    },
                    color: Colors.teal,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                RaisedButton(
                  child: Text(
                    "SHOW",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  onPressed: () {
                    if (_isButtonDisable) {
                      showAlertDialog(context);
                    } else {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => MyApp()));
                    }
                  },
                  color: Colors.teal,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                RaisedButton(
                  child: Text(
                    "UPLOAD",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  onPressed: () {
                    print("upload this file to fire base ");
                  },
                  color: Colors.teal,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
//              RaisedButton(
//                child: Text("EDIT "),
//                onPressed: () {
//                  Navigator.of(context).push(MaterialPageRoute(
//                      builder: (context) => custom.CustomDataTable()));
//                },
//              ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void openFileExplorer() async {
    try {
      file = await FilePicker.getFile(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );
      contents = await file.readAsString();
      simple.dis(contents);
      custom.dis(contents);
      if (file != null) {
        _isButtonDisable = false;
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("First Select a File"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
