import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: FutureBuilder(
            future: getData(),
            builder: (context, snapshot){
              if(snapshot.hasData){ // If there is data got from the API
                List list = snapshot.data;
                return ListView(
                  children: List.generate(list.length, (index){
                    return ListTile(
                      title: Text('${list[index]['title']}'),
                    );
                  }),
                );
              }
              return Column(
                children: <Widget>[
                  Container(
                    width: 40, height: 40,
                    child: CircularProgressIndicator(),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<List> getData() async{ //
    String apiUrl = 'https://jsonplaceholder.typicode.com/posts';
    var response = await http.get(apiUrl);
    return json.decode(response.body);
  }
}




