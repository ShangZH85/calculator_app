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
    String prekey = "";

    if (_keys.length > 0) {
      prekey = _keys[_keys.length - 1];
    }

    if (TKeys.contains(key)) {
      switch (key) {
        case "C":
          _s1 = [];
          _s2 = [];
          _s3 = [];
          _keys = [];
          _output = "";
          _curnum = "";
          return;
          break;
        case "D":
          removeLastkey();
          return;
          break;
      }
    }

    if (NKeys.contains(key)) {
      if (_curnum.isEmpty && _s1.isEmpty) {
        _output = "";
      }

      _keys.add(key);
      _curnum += key;
      _output += key;
    } else {
      if (_curnum.isNotEmpty) {
        _s1.add(_curnum);
        _curnum = "";
      }
    }

    if (RKeys.contains(key)) {
      if (_s1.isEmpty) {
        String str = result.toString();
        _output = str;
        for (int i = 0; i < str.length; i++) {
          _keys.add(str.substring(i, i + 1));
        }
        _s1.add(result.toString());
      }
      if (RKeys.contains(prekey)) {
        removeLastkey();
      }

      _output += key;
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

    if (key == EQ && (_s1.length > 0 || _curnum.isNotEmpty) && prekey != EQ) {
      if (RKeys.contains(prekey)) {
        removeLastkey();
      }
      _keys.add(key);
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
      _keys = [];
    }
  }

  void removeLastkey() {
    String prekey = "";

    if (_keys.length > 0) {
      prekey = _keys[_keys.length - 1];
    }

    if (RKeys.contains(prekey)) {
      String k1 = _s1[_s1.length - 1];
      if (RKeys.contains(k1)) {
        _s2.removeLast();
        for (int i = _s1.length - 1; i >= 0; i--) {
          String kk = _s1[i];
          if (RKeys.contains(kk)) {
            _s2.add(_s1.removeLast());
          } else {
            break;
          }
        }
      } else {
        _s2.removeLast();
      }
      _keys.removeLast();
      _output = _output.substring(0, _output.length - 1);
    } else if (_s1.length > 0 || _curnum.isNotEmpty) {
      if (_curnum.isNotEmpty) {
        _curnum = _curnum.substring(0, _curnum.length - 1);
      } else {
        String str = _s1.removeLast();
        str = str.substring(0, str.length - 1);
        _curnum=str;
      }
      _keys.removeLast();
      _output = _output.substring(0, _output.length - 1);
    }
  }
}
