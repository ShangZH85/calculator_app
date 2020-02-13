import 'package:calculator_app/Interface.dart';
import 'package:flutter/material.dart';

class transPage extends StatefulWidget{
@override
_transPageState createState() {
    return _transPageState();
  }
}

class _transPageState extends State<transPage>{
@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: interfacePage.PAGE_COLOR,
      appBar: AppBar(
        title: Text("单位转换页"),
        backgroundColor: interfacePage.PAGE_COLOR,
        centerTitle: true,
      ),
    );
  }
}
