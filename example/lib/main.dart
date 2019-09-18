import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List<DropdownMenuItem> items = [];
  String selectedValue;

  @override
  void initState() {
    for(int i=0; i < 20; i++){
      items.add(new DropdownMenuItem(
        child: new Text(
          'test ' + i.toString(),
        ),
        value: 'test ' + i.toString(),
      ));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Searchable Dropdown Demo'),
        ),
        body: new Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                child: new Text(
                  'Searchable Dropdown',
                  style: new TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                )
              ),
              new SearchableDropdown(
                items: items,
                value: selectedValue,
                isCaseSensitiveSearch: true,
                hint: new Text(
                  'Select One'
                ),
                searchHint: new Text(
                  'Select One',
                  style: new TextStyle(
                      fontSize: 20
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
              ),
              new Container(
                margin: EdgeInsets.only(
                  top: 30
                ),
                child: new Text(
                  'Regular Dropdown',
                  style: new TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                )
              ),
              new DropdownButton(
                items: items,
                value: selectedValue,
                hint: new Text(
                  'Select One'
                ),
                onChanged: (value){
                  setState(() {
                    selectedValue = value;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
