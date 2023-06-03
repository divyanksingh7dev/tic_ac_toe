import 'dart:async';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> display = ["", "", "", "", "", "", "", "", "", ""];
  bool o_turn = false;
  String player = "X";
  int x_score = 0;
  int o_score = 0;
  int filled_boxes = 0;
  bool tap = false;

  Timer scheduleTimeout([int milliseconds = 100]) =>
      Timer(Duration(milliseconds: milliseconds), handleTimeout);

  handleTimeout() {
    tap = false;
  }

  void _tapped(int index) {
    if (display[index] == "" && tap == false) {
      tap = true;
      setState(() {
        if (o_turn) {
          display[index] = "O";
          player = "X";
          filled_boxes++;
        } else {
          display[index] = "X";
          player = "O";
          filled_boxes++;
        }
        o_turn = !o_turn;
        _checkWinner();
      });
      scheduleTimeout();
    }
  }

  void _checkWinner() {
    if (display[0] == display[1] &&
        display[0] == display[2] &&
        display[0] != "") {
      _endLogic(display[0]);
    } else if (display[3] == display[4] &&
        display[3] == display[5] &&
        display[3] != "") {
      _endLogic(display[3]);
    } else if (display[6] == display[7] &&
        display[6] == display[8] &&
        display[6] != "") {
      _endLogic(display[6]);
    } else if (display[0] == display[3] &&
        display[0] == display[6] &&
        display[0] != "") {
      _endLogic(display[0]);
    } else if (display[1] == display[4] &&
        display[1] == display[7] &&
        display[1] != "") {
      _endLogic(display[1]);
    } else if (display[2] == display[5] &&
        display[2] == display[8] &&
        display[2] != "") {
      _endLogic(display[2]);
    } else if (display[0] == display[4] &&
        display[0] == display[8] &&
        display[0] != "") {
      _endLogic(display[0]);
    } else if (display[2] == display[4] &&
        display[2] == display[6] &&
        display[2] != "") {
      _endLogic(display[2]);
    } else if (filled_boxes == 9) {
      _endLogic("-");
    }
  }

  void _endLogic(String winner) {
    String temp = "";
    setState(() {
      if (winner == "X") {
        x_score++;
        temp = "Winner is Player X !";
      } else if (winner == "O") {
        o_score++;
        temp = "Winner is Player O !";
      } else {
        temp = "Nobody won the game";
      }
    });

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
		borderRadius: BorderRadius.circular(15),),
            backgroundColor: Colors.black38,
            title: Center(
                child: Text(
              temp,
              style: TextStyle(color: Colors.white, fontSize: 24),
            )),
          );
        }).then((value) {
      setState(() {
        display = ["", "", "", "", "", "", "", "", "", ""];
        o_turn = false;
        player = "X";
        filled_boxes = 0;
      });
    });
  }

  Color retColor(int index){
    if(display[index] == "O"){
      return Colors.white12;
    }
    else if(display[index] == "X"){
      return Colors.black12;
    }
    else {
      return Colors.grey.shade800;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade800,
        body: Container(
          margin: EdgeInsets.fromLTRB(20, 50, 20, 20),
          child: Column(
            children: [
              Expanded(
                  child: Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Player X",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        Text(
                          x_score.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text(
                          "Player O",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        Text(
                          o_score.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ],
                    ),
                  ],
                )),
              )),
              Expanded(
                flex: 3,
                child: GridView.builder(
                    itemCount: 9,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        child: Material(
                          elevation: 10,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.transparent,
                          child: Container(
                            
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              
                              color: retColor(index),
                                border: Border.all(color: Colors.grey.shade700),borderRadius: BorderRadius.circular(15)),
                            child: Center(
                              child: Text(
                                display[index],
                                style:
                                    TextStyle(color: Colors.white, fontSize: 40),
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          _tapped(index);
                        },
                      );
                    }),
              ),
              Expanded(
                  child: Center(
                      child: Text(
                "$player Turn",
                style: TextStyle(color: Colors.white, fontSize: 24),
              )))
            ],
          ),
        ));
  }
}
