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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PAGE_COLOR,
      appBar: AppBar(
        title: Text("计算器"),
        backgroundColor: PAGE_COLOR,
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
                    child: Padding(
                padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "显区域1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111",
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
        onPressed: () => 0,
        padding: EdgeInsets.all(0.0),
        child: Container(
          decoration: BoxDecoration(
              color: TKeys.contains(num)
                  ? TOP_BTN_BG
                  : RKeys.contains(num) ? RI_BTN_BG : NUM_BTN_BG,
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

    for (int i = 0; i < NKeys.length; i++) {
      String key = NKeys[i];
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
