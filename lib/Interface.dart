import 'package:flutter/material.dart';

class interfacePage extends StatelessWidget {
  static const Color PAGE_COLOR = Colors.black;
  static const Color NUM_BTN_BG = Color(0xff323232);
  static const Color TOP_BTN_BG = Color(0xFFa6a6a6);
  static const Color RI_BTN_BG = Color(0xffFF9500);

  static const NKeys = [
    "C", "D", "%", "/", //
    "7", "8", "9", "*", //
    "4", "5", "6", "-", //
    "1", "2", "3", "+", //
    " ", "0", ".", "=", //
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("计算器"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Center(
              child: Column(
            children: <Widget>[
              Expanded(child: Center(child: Text("显区域"))),
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
        onPressed: () => 0,
        child: Container(
          decoration: BoxDecoration(
              color: TKeys.contains(num)
                  ? TOP_BTN_BG
                  : RKeys.contains(num) ? RI_BTN_BG : NUM_BTN_BG,
              shape: flex > 1 ? BoxShape.rectangle : BoxShape.circle,
              borderRadius:
                  flex > 1 ? BorderRadius.all(Radius.circular(1000.0)) : null),
          padding: EdgeInsets.all(20.0),
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

    for (int i = 0; i < NKeys.length; i++) {
      String key = NKeys[i];
      Widget b = buildFlatButton(key);
      btns.add(b);
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
