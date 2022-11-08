import 'package:calculator/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var question = '';
  var answer = '';
  final List<String> buttons = [
    "C",
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'X',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      body: Column(
        
        children: [
        Container(
          height: 150,
          width: double.infinity,
          color:Colors.deepPurple[50],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const SizedBox(height: 5,),
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              child: Text(question,textAlign: TextAlign.start, style: const TextStyle(fontSize: 30,letterSpacing: 1.0,color: Colors.black),)),
            
            
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.bottomRight,
              child: Text(answer,textAlign: TextAlign.end,style: const TextStyle(fontSize: 30,color: Colors.black))),
          ]),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            // padding: const EdgeInsets.only(left: 9,right: 9,top: 9),
            padding:const EdgeInsets.all(9),
            child: Container(
              child: GridView.builder(
               physics: const NeverScrollableScrollPhysics(),
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Buttons(
                      buttonTapped: (){
                        setState(() {
                          question = "";
                          answer = '';
                        });
                      },
                      color: Colors.green,
                      textColor: Colors.white,
                      buttonText: buttons[index],
                    );
                  } else if (index == 1) {
                    return Buttons(
                      buttonTapped: (){
                        setState(() {
                          question = question.substring(0,question.length-1);
                        });
                      },
                      color: ( Colors.red[700])!,
                      textColor: Colors.white,
                      buttonText: buttons[index],
                    );
                  }else if (index ==buttons.length-2 ) {
                    return Buttons(
                      buttonTapped: (){
                        setState(() {
                          equalPressed();
                        });
                      },
                      color: (Colors.deepPurple[100])!,
                      textColor: Colors.deepPurple,
                      buttonText: buttons[index],
                    );
                  }else if (index == buttons.length-1) {
                    return Buttons(
                      buttonTapped: (){
                        setState(() {
                          equalPressed();
                        });
                      },
                      color:( Colors.red[700])!,
                      textColor: Colors.white,
                      buttonText: buttons[index],
                    );
                  }  
                  else {
                    return Buttons(
                      buttonTapped: (){
                        setState(() {
                          question += buttons[index];
                        });
                      },
                      color: isOperator(buttons[index])
                          ?( Color.fromARGB(255, 87, 86, 86))
                          : (Colors.deepPurple[100])!,
                      textColor: isOperator(buttons[index])
                          ? Colors.white
                          : Colors.deepPurple,
                      buttonText: buttons[index],
                    );
                  }
                },
              ),
            ),
          ),
        ),
        
      ]),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == '-' || x == '+' || x == '='|| x=='X') {
      return true;
    } else {
      return false;
    }
  }
  void equalPressed(){
    String finalQuestion = question;
    finalQuestion = finalQuestion.replaceAll('X', '*');
    Parser p = Parser();
  Expression exp = p.parse(finalQuestion);
  ContextModel cm = ContextModel();
  double eval = exp.evaluate(EvaluationType.REAL, cm);
  answer = eval.toString();
  }
}
