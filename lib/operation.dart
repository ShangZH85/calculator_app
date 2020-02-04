class operation {
  String _output = "";
  String _curnum = "";

  double result = 0.0;

  String get OutPut => this._output;

  static const NKeys = [
    "7", "8", "9", //
    "4", "5", "6", //
    "1", "2", "3", //
    "0", "." //
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
  ];

  static const RKeysMap = {
    "/": 2,
    "*": 2,
    "-": 1,
    "+": 1,
  };

  static const EQ = "=";

  List<String> _keys = [];

  List<String> _s1 = [], _s2 = [];
  List<double> _s3 = [];

  void addKey(String key) {
    if (TKeys.contains(key)) {
      switch (key) {
        case "C":
          _s1 = [];
          _s2 = [];
          _s3 = [];
          _output = "";
          _curnum = "";
          return;
          break;
//        case "D":
//          if (RKeys.contains(key)) {
//            _output="";
//            _keys.removeLast();
//            for(int i=0;i<_keys.length;i++){
//              _output+=_keys[i];
//            }
//          }
//          return;
//          break;
      }
    }

    if (NKeys.contains(key)) {
      _keys.add(key);
      _curnum += key;
      _output += key;
    } else {
      if (_curnum.isNotEmpty) {
        _s1.add(_curnum);
        _curnum = "";
        _output += key;
      }
    }

    if (RKeys.contains(key)) {
      _keys.add(key);
      if (_s2.length == 0) {
        _s2.add(key);
      } else {
        if (RKeysMap[key] <= RKeysMap[_s2[_s2.length - 1]]) {
          while (_s2.length > 0 &&
              RKeysMap[key] <= RKeysMap[_s2[_s2.length - 1]]) {
            _s1.add(_s2.removeLast());
          }
        }
        _s2.add(key);
      }
    }

    if (key == EQ) {
      while (_s2.length > 0) {
        _s1.add(_s2.removeLast());
      }
      for (int i = 0; i < _s1.length; i++) {
        if (!RKeys.contains(_s1[i])) {
          _s3.add(double.parse(_s1[i]));
        } else {
          switch (_s1[i]) {
            case "+":
              _s3.add(_s3.removeLast() + _s3.removeLast());
              break;
            case "-":
              double r1 = _s3.removeLast(), r2 = _s3.removeLast();
              _s3.add(r2 - r1);
              break;
            case "*":
              _s3.add(_s3.removeLast() * _s3.removeLast());
              break;
            case "/":
              double r1 = _s3.removeLast(), r2 = _s3.removeLast();
              _s3.add(r2 / r1);
              break;
          }
        }
      }
      result = _s3[0];
      _output = "$result";

      _s3 = [];
      _s2 = [];
      _s1 = [];
    }
  }
}
