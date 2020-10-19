import 'package:flutter/material.dart';

void main() => runApp(new Calculator()); // Вызов калькулятора

class Calculator extends StatelessWidget {
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Calc(),
    );
  }
}

class Calc extends StatefulWidget {
  CalcState createState() => CalcState();
}

class CalcState extends State<Calc> {
  dynamic text ='0';
  double first_num = 0;
  double second_num = 0;
  dynamic result = '';
  dynamic final_result = '';
  dynamic opr = '';
  dynamic preOpr = '';

  Widget btn(btnText, Color color) {  // Функция которая создает кнопку
    return Container(
        width: MediaQuery.of(context).size.width * 0.25, // Она заниамет одну четверть всей ширины контейнера
        padding: EdgeInsets.only(bottom: 1.0, right: 0.5, left: 0.5), // Подобрала минимальный видный паддинг в 1 пикслель
        child: new RaisedButton(
            child: Text(btnText,
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w300,
                  color: Colors.white
              ),
            ),
            onPressed: (){
              calculation(btnText);
            },
            color: color,
            padding: EdgeInsets.all(22.0),
          shape: RoundedRectangleBorder(  // убрала закругленность в углах кнопок
            borderRadius: BorderRadius.circular(0.0),
          ),
        )
    );
  } // end of button

  Widget btnZero(btnText, Color color) { // функция для создания днлинной кнопки 0
    return Container(
        width: MediaQuery.of(context).size.width * 0.5,   // которая занимает половину ширины
        padding: EdgeInsets.only(bottom: 1.0, right: 0.5, left: 0.5),
        child: new RaisedButton(
            child: Text(btnText,
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w300,
                  color: Colors.white
              ),
            ),
            onPressed: (){
              calculation(btnText);
            },
            color: color,
            padding: EdgeInsets.only(left:80,top:22,right:80,bottom:22),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
          ),
        )
    );
  } // end of button

  Widget build(BuildContext context) {  // Виджет внутри которой система grid-ов элементов калькулятора
    return new Scaffold(
      appBar: null,
      backgroundColor: Color(0xff3d3e3e),
      body: Container(
        margin: EdgeInsets.only(bottom: 0.5),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(children: <Widget>[ // Первый роу будет хранить в себе результат и операторы
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 60.0,
                  ),
                  textAlign: TextAlign.right,
                  maxLines: 1,
                ),
              )
            ],
            ),
            Row(                  // А в остальных строках будут вызываться кнопки
              children: <Widget>[
                btn('C',const Color(0xff545454)), // Подобрала цвета кнопок с помощью пипетки
                btn('+/-',const Color(0xff545454)),
                btn('%',const Color(0xff545454)),
                btn('/',const Color(0xffff9f17)),
              ],),
            Row(
              children: <Widget>[
                btn('7',const Color(0xff737373)),
                btn('8',const Color(0xff737373)),
                btn('9',const Color(0xff737373)),
                btn('x',const Color(0xffff9f17)),
              ],),
            Row(
              children: <Widget>[
                btn('4',const Color(0xff737373)),
                btn('5',const Color(0xff737373)),
                btn('6',const Color(0xff737373)),
                btn('-',const Color(0xffff9f17)),
              ],),
            Row(
              children: <Widget>[
                btn('1',const Color(0xff737373)),
                btn('2',const Color(0xff737373)),
                btn('3',const Color(0xff737373)),
                btn('+',const Color(0xffff9f17)),
              ],),
            Row(
              children: <Widget>[
                btnZero('0',const Color(0xff737373)),
                btn('.',const Color(0xff737373)),
                btn('=',const Color(0xffff9f17)),
              ],),
          ],
        ),
      ),
    );
  } // end of state class

  void calculation(btnText) {
    if(btnText  == 'C') {
      text ='0';
      first_num = 0;
      second_num = 0;
      result = '';
      final_result = '';
      opr = '';
      preOpr = '';
    } else if( opr == '=' && btnText == '=') {
      if(preOpr == '+') {
        final_result = add();
      } else if( preOpr == '-') {
        final_result = sub();
      } else if( preOpr == 'x') {
        final_result = mul();
      } else if( preOpr == '/') {
        final_result = div();
      }
    } else if(btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {
      if(first_num == 0) {
        first_num = double.parse(result);
      } else {
        second_num = double.parse(result);
      }
      if(opr == '+') {
        final_result = add();
      } else if( opr == '-') {
        final_result = sub();
      } else if( opr == 'x') {
        final_result = mul();
      } else if( opr == '/') {
        final_result = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    } else if(btnText == '%') {
      result = first_num / 100;
      final_result = doesContainDecimal(result);
    } else if(btnText == '.') {
      if(!result.toString().contains('.')) {
        result = result.toString()+'.';
      }
      final_result = result;
    } else if(btnText == '+/-') {
      result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-'+result.toString();
      final_result = result;
    } else {
      result = result + btnText;
      final_result = result;
    }

    setState(() {
      text = final_result;
    });
  }

  String add() {
    result = (first_num + second_num).toString();
    first_num = double.parse(result);
    return doesContainDecimal(result);
  }
  String sub() {
    result = (first_num - second_num).toString();
    first_num = double.parse(result);
    return doesContainDecimal(result);
  }
  String mul() {
    result = (first_num * second_num).toString();
    first_num = double.parse(result);
    return doesContainDecimal(result);
  }
  String div() {
    result = (first_num / second_num).toString();
    first_num = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if(result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if(!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}