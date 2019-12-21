import 'package:weather_app_using_bloc/models/weather.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class WeatherRepository {
  Future<WeatherMain> getWeatherData(String city) async {
    final result = await http.Client().get("https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=43ea6baaad7663dc17637e22ee6f78f2");

    if(result.statusCode != 200){
      throw Exception("Error Occured ${result.statusCode}");
    }
    final json = jsonDecode(result.body);
    return WeatherMain.fromJson(json["main"]);
  }
}