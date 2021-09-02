
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = '0b3ead4bc5712aa1f5361f73a5a0ffc5';


class WeatherModel {
  Future<dynamic> getCity(String cityName) async{
    String url ='http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper0 = new  NetworkHelper(url);
    var weatherData0 = await networkHelper0.getData();
    print(weatherData0);
    return weatherData0;

  }
  Future<dynamic> getWeatherData() async
  {
    Location loc = Location();
    await loc.getCurrentLocation();
    String url =
        'http://api.positionstack.com/v1/reverse?access_key=d729592f7dbda537054c0dc0b99c9e97&query=32.1877,74.1945';
    NetworkHelper networkHelper = new NetworkHelper(url);
    var weatherData = await networkHelper.getData();

    return weatherData;

  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for summer clothes';
    } else if (temp < 10) {
      return 'You\'ll need scarf and gloves';
    } else {
      return 'Bring a coat just in case';
    }
  }
}
