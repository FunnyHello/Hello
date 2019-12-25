import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef InputCompleteCallback(String content);

class CellInput extends StatefulWidget {
  int cellCount = 4;
  InputType inputType = InputType.number;
  InputCompleteCallback inputCompleteCallback;
  bool autofocus = true;
  BorderRadiusGeometry borderRadius;
  Color solidColor;
  Color borderColor;
  Color strokeColor;
  Color textColor;
  double fontSize;

  CellInput(
      {Key key,
        //单格数量
        this.cellCount = 4,
        this.inputType,
        //autofocus
        this.autofocus = true,
        //输入后回调
        this.inputCompleteCallback,
        //单格圆角
        this.borderRadius,
        //单格背景色
        this.solidColor,
        //默认边框颜色
        this.borderColor = Colors.white,
        //当前边框颜色
        this.strokeColor = Colors.blue,
        //字体颜色
        this.textColor,
        //字体大小
        this.fontSize = 22})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CellInputState(
        cellCount,
        inputType,
        autofocus,
        inputCompleteCallback,
        borderRadius,
        solidColor,
        borderColor,
        strokeColor,
        textColor,
        fontSize);
  }
}

enum InputType {
  password,
  number,
  text,
}

class _CellInputState extends State<CellInput>
    with AutomaticKeepAliveClientMixin {
  String inputStr = "";
  int _cellCount = 4;
  InputType _inputType = InputType.number;
  InputCompleteCallback _inputCompleteCallback;
  bool _autofocus = true;
  BorderRadiusGeometry _borderRadius;
  Color _solidColor;
  Color _borderColor;
  Color _strokeColor;
  Color _textColor;
  double _fontSize;

  _CellInputState(
      this._cellCount,
      this._inputType,
      this._autofocus,
      this._inputCompleteCallback,
      this._borderRadius,
      this._solidColor,
      this._borderColor,
      this._strokeColor,
      this._textColor,
      this._fontSize);

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new Container(
      height: 64,
      child: Stack(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: getCells(),
          ),
          Container(
            height: 64,
            width: double.infinity,
            child: TextField(
              //禁止复制粘贴，保证格子效果
              enableInteractiveSelection: false,
              keyboardType: _keyboardType(),
              inputFormatters: [LengthLimitingTextInputFormatter(_cellCount)],
              decoration: InputDecoration(border: InputBorder.none),
              cursorWidth: 0,
              style: TextStyle(color: Colors.transparent),
              controller: _controller,
              autofocus: _autofocus,
              onChanged: (v) {
                setState(() {
                  inputStr = v;
                  if (v.length == _cellCount) {
                    if (_inputCompleteCallback != null) {
                      _inputCompleteCallback(v);
                    }
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  String getIndexStr(int index) {
    if (inputStr == null || inputStr.isEmpty) return "";
    if (inputStr.length > index) {
      if (_inputType == InputType.password) {
        return "●";
      } else {
        return inputStr[index];
      }
    } else {
      return "";
    }
  }

  TextInputType _keyboardType() {
    if (_inputType == InputType.number) {
      return TextInputType.number;
    } else if (_inputType == InputType.password) {
      return TextInputType.number;
    } else {
      return TextInputType.text;
    }
  }

  List<Widget> getCells() {
    var cells = <Widget>[];
    for (var i = 0; i < _cellCount; i++) {
      cells.add(Expanded(
        flex: 1,
        child: Center(
          child: Container(
            width: 56,
            height: 64,
            margin: EdgeInsets.only(left: 6, right: 6),
            alignment: Alignment.center,
            child: Text(
              getIndexStr(i),
              style: TextStyle(
                  fontSize: _fontSize,
                  color: _textColor,
                  fontWeight: FontWeight.w600),
            ),
            decoration: BoxDecoration(
                color: _solidColor,
                border: Border.all(width: 1, color: getBoarderColor(i)),
                borderRadius: _borderRadius),
          ),
        ),
      ));
    }

    return cells;
  }

  Color getBoarderColor(int index) {
    if (inputStr == null || inputStr.isEmpty) {
      if (index == 0) {
        return _strokeColor;
      } else {
        return _borderColor;
      }
    } else {
      if (index == inputStr.length) {
        return _strokeColor;
      } else {
        return _borderColor;
      }
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
