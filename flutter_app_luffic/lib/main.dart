import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_app_luffic/controller/FxController.dart';
import 'package:flutter_app_luffic/model/FxRates.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final textcontroller = TextEditingController();
  var fxRates = FxRates();
  var _scrollController;

  @override
  void initState() {
    getData();
    _scrollController = ScrollController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drawOptions = [];
    final _listView = ListView(
      controller: _scrollController,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: drawOptions,
    );
    if (fxRates != null && fxRates.rates != null) {
      var result = fxRates.rates.toJson();
      for (var entry in result.entries) {
        print(entry.key);
        print(entry.value);
        var value = entry.value;
        drawOptions.add(Align(
          alignment: Alignment.center,
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    entry.key.toString() + " :",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(entry.value.toString() + ""),
                )
              ],
            ),
          ),
        ));
      }
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Center(
        child: Container(
          alignment: Alignment.center,
          child: SafeArea(
              child: Column(
            children: <Widget>[
              appbarContent(),
              conversionPart(),
              Expanded(
                child: _listView,
              ),
            ],
          )),
        ),
      )),
    );
  }

  Container conversionPart() {
    return new Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20, 25, 20, 10),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 5,
                    color: Colors.black,
                  )),
              child: TextField(
                cursorColor: Colors.black,
                controller: textcontroller,
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(35, 5, 35, 5),
              child: Text(
                "Convert",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 5,
            color: Colors.black,
          )
        ],
      ),
    );
  }

  Container appbarContent() {
    return new Container(
      color: Colors.lightBlue,
      child: Padding(
        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      getBase(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      getDate(),
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: getData,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                  child: Text(
                    "Refresh",
                    style: TextStyle(fontSize: 15, color: Colors.lightBlue),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getData() {
    FxController.fetchAlbum().then((response) {
      final jsondata = json.decode(response.body);
      if (response.statusCode == 200) {
        var fxData = FxRates.fromJson(jsondata);
        setState(() {
          fxRates = fxData;
        });
      }
    });
  }

  String getBase() {
    if (fxRates != null && fxRates.base != null) {
      return fxRates.base;
    } else {
      return "Base";
    }
  }

  String getDate() {
    if (fxRates != null && fxRates.date != null) {
      return fxRates.date;
    } else {
      return "Date";
    }
  }
}
