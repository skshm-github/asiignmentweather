import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiPage extends StatefulWidget {
  const ApiPage({Key?key}) : super(key: key);

  @override
  State<ApiPage> createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api Page"),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(onPressed: (){
              apicall();
            }, child: Text("Call API")),
            FutureBuilder(future: apicall(),
              builder: (BuildContext context,AsyncSnapshot snapshot){
                if(snapshot.hasData){
                  return Text(snapshot.data);
                }
                else{
                  return CircularProgressIndicator();
                }
              },)
          ],
        ),
      ),
    );
  }
}

Future apicall() async{
  final url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=bangalore&appid=1d5592436c6d43c47b20c2e8d2bc40d3");
  final response =await http.get(url);
  String output=(jsonDecode(response.body)["weather"][0]['description']);
  return output;
}
