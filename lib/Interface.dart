import 'package:calculator_app/operation.dart';
import 'package:flutter/material.dart';

class interfacePage extends StatefulWidget {
  static const Color PAGE_COLOR = Colors.black;
  static const Color NUM_BTN_BG = Color(0xff323232);
  static const Color TOP_BTN_BG = Color(0xFFa6a6a6);
  static const Color RI_BTN_BG = Color(0xffFF9500);

  static const NKeys = [
    "C", "D", "%", "/", //
    "7", "8", "9", "*", //
    "4", "5", "6", "-", //
    "1", "2", "3", "+", //
    "", "0", ".", "=", //
  ];

  static const TKeys = [
    "C",
    "D",
    "%",
  ];

  static const RKeys = [
    "/",
    "*",
    "-",
    "+",
    "=",
  ];

  @override
  _interfacePageState createState() => _interfacePageState();
}

class _interfacePageState extends State<interfacePage> {

  String _num = "";

  operation _op = new operation();

  void clickKey(String key) {

  _op.addKey(key);

  setState(() {
    _num=_op.OutPut;
  });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: interfacePage.PAGE_COLOR,
      appBar: AppBar(
        title: Text("计算器"),
        backgroundColor: interfacePage.PAGE_COLOR,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Center(
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: SingleChildScrollView(
                        reverse: true,
                        child: Padding(
                          padding:
                          const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                "$_num",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                ),
                              )),
                        ),
                      )),
                  Container(child: Center(child: _buildBtns()))
                ],
              )),
        ),
      ),
    );
  }

  Widget buildFlatButton(String num, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: FlatButton(
        onPressed: () {
          clickKey(num);
        },
        padding: EdgeInsets.all(0.0),
        child: Container(
          decoration: BoxDecoration(
              color: interfacePage.TKeys.contains(num)
                  ? interfacePage.TOP_BTN_BG
                  : interfacePage.RKeys.contains(num)
                  ? interfacePage.RI_BTN_BG
                  : interfacePage.NUM_BTN_BG,
              shape: flex > 1 ? BoxShape.rectangle : BoxShape.circle,
              borderRadius:
              flex > 1 ? BorderRadius.all(Radius.circular(1000.0)) : null),
          padding: EdgeInsets.all(20.0),
          margin: EdgeInsets.all(10.0),
          child: Center(
              child: Text(
                "$num",
                style: TextStyle(fontSize: 28.0),
              )),
        ),
      ),
    );
  }

  Widget _buildBtns() {
    List<Widget> rows = [];

    List<Widget> btns = [];

    int flex = 1;

    for (int i = 0; i < interfacePage.NKeys.length; i++) {
      String key = interfacePage.NKeys[i];
      if (key.isEmpty) {
        flex++;
        continue;
      } else {
        Widget b = buildFlatButton(key, flex: flex);
        btns.add(b);
        flex = 1;
      }
      if ((i + 1) % 4 == 0) {
        rows.add(Row(
          children: btns,
        ));
        btns = [];
      }
    }
    if (btns.length > 0) {
      rows.add(Row(
        children: btns,
      ));
      btns = [];
    }
    return Column(
      children: rows,
    );
  }
}
