import 'package:flutter/material.dart';
import 'package:wether/data_service.dart';

import 'models.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  final _cityTextController = TextEditingController();
  final _dataService = DataService();

  WeatherResponse _response;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.black87,
          appBar: AppBar(
            title: Text("KNOW THE WEATHER "),
            backgroundColor: Colors.deepOrangeAccent,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_response != null)
                  Column(
                    children: [
                      Image.network(_response.iconUrl),
                      Text(s1((_response.tempInfo.temperature-32)*(5/9))+" °C\n\n"+s1(_response.tempInfo.temperature)+" F",
                        style: TextStyle(fontSize: 21,color: Colors.white),
                      ),
                      Text("\n"+_response.weatherInfo.description,style: TextStyle(fontSize: 14,color: Colors.white,backgroundColor: Colors.black38),)
                    ],
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 50),
                  child: SizedBox(
                    width: 180,
                    child: DecoratedBox(
                  decoration: const BoxDecoration(
                  color: Colors.black87,
                  ),
                  child:
                  TextField(
                      style: TextStyle(color: Colors.white,backgroundColor: Colors.black),
                        controller: _cityTextController,
                        decoration: InputDecoration(labelText: 'City',labelStyle:TextStyle(color:Colors.white,fontSize: 16),

                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0),
                          )
                        ),
                        textAlign: TextAlign.center
                  ),
                  ),
                ),
                ),
                ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.grey)
                    ,onPressed:_search, child: Text('Search',style: TextStyle(color:Colors.black),)
                ),
      ]
            ),
          ),
        ),
    );
  }
  String s1(double n)
  {
    return (n.toStringAsPrecision(3));
  }

  void _search() async {
    final response = await _dataService.getWeather(_cityTextController.text);
    setState(() => _response = response);
  }
}

/*
class DataService {
  Future<WeatherResponse> getWeather(String city) async {
    // api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}

    final queryParameters = {
      'q': city,
      'appid': '98e8dfcf4ea2319b693eb4c58b2a6018',
      'units': 'imperial'
    };

    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameters);

    final response = await http.get(uri);

    print(response.body);
    final json = jsonDecode(response.body);
    return WeatherResponse.fromJson(json);
  }}



class ApiPage extends StatefulWidget
{
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
            TextButton(onPressed: () {
              apicall();
            }, child: Text("Call API")),
            FutureBuilder(future: apicall(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data);
                }
                else {
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



class WeatherInfo {
  final String description;
  final String icon;
  WeatherInfo({this.description, this.icon});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final description = json['description'];
    final icon = json['icon'];
    return WeatherInfo(description: description, icon: icon);
  }
}

class TemperatureInfo {
  final double temperature;

  TemperatureInfo({this.temperature});

  factory TemperatureInfo.fromJson(Map<String, dynamic> json) {
    final temperature = json['temp'];
    return TemperatureInfo(temperature: temperature);
  }
}

class WeatherResponse {
  final String cityName;
  final TemperatureInfo tempInfo;
  final WeatherInfo weatherInfo;

  String get iconUrl {
    return 'https://openweathermap.org/img/wn/${weatherInfo.icon}@2x.png';
  }

  WeatherResponse({this.cityName, this.tempInfo, this.weatherInfo});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'];

    final tempInfoJson = json['main'];
    final tempInfo = TemperatureInfo.fromJson(tempInfoJson);

    final weatherInfoJson = json['weather'][0];
    final weatherInfo = WeatherInfo.fromJson(weatherInfoJson);

    return WeatherResponse(
        cityName: cityName, tempInfo: tempInfo, weatherInfo: weatherInfo);
  }
}*/


