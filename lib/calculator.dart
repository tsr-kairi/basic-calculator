// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';


class TsrCalc extends StatefulWidget {
  @override
  _TsrCalcState createState() => _TsrCalcState();
}

class _TsrCalcState extends State<TsrCalc> {

  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;
  Color equationColor = Colors.white;
  Color resultColor = Colors.white;

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == "AC"){
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      }

      else if(buttonText == "⌫"){
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if(equation == ""){
          equation = "0";
        }
      }

      else if(buttonText == "="){
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = "Error";
        }

      }

      else{
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if(equation == "0"){
          equation = buttonText;
        }else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor){
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.white,
                  width: 1,
                  style: BorderStyle.solid
              )
          ),
          padding: EdgeInsets.all(16.0),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white
            ),
          )
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator'), backgroundColor: Colors.black87,),
      body: Column(
        children: <Widget>[


          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation, style: TextStyle(fontSize: equationFontSize),),
          ),


          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(result, style: TextStyle(fontSize: resultFontSize),),
          ),


          Expanded(
            child: Divider(),
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("AC", 1, const Color(0xFFB47B0F)),
                        buildButton("⌫", 1, Colors.black),
                        buildButton("÷", 1, Colors.black),
                      ]
                    ),

                    TableRow(
                        children: [
                          buildButton("7", 1, Colors.black87),
                          buildButton("8", 1, Colors.black87),
                          buildButton("9", 1, Colors.black87),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("4", 1, Colors.black87),
                          buildButton("5", 1, Colors.black87),
                          buildButton("6", 1, Colors.black87),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("1", 1, Colors.black87),
                          buildButton("2", 1, Colors.black87),
                          buildButton("3", 1, Colors.black87),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton(".", 1, Colors.black87),
                          buildButton("0", 1, Colors.black87),
                          buildButton("00", 1, Colors.black87),
                        ]
                    ),
                  ],
                ),
              ),


              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("×", 1, Colors.black),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("-", 1, Colors.black),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("+", 1, Colors.black),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("=", 2, const Color(0xFFB47B0F)),
                        ]
                    ),
                  ],
                ),
              )
            ],
          ),

        ],
      ),
    );
  }
}