import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:http/http.dart';
import 'package:clima/services/weather.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;

  LocationScreen({this.locationWeather});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String cityName;
  int temperature;
  String weatherMessage;
  String weatherIcon;

  WeatherModel weather = WeatherModel();
  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = '';
        weatherMessage = 'Unable to get weather data :(';

        return;
      }
      cityName = weatherData['name'];
      //////////////////////////////////////////////////////
      if(cityName=='Babian'){
        cityName='Gujranwala';
      }
    });
      var tempF = weatherData['main']['temp'];
      temperature = tempF.toInt();
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);

      weatherMessage = weather.getMessage(temperature) + ' in ' + cityName;

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: 10),     // by Hamza
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/location_background.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.8), BlendMode.dstATop),
            ),
          ),
          constraints: BoxConstraints.expand(),        //  -------?
          child: Column(
       //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
     //       crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weather.getWeatherData();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var passedInputCityName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {  // builder expect a call back
                            return CityScreen();
                          },
                        ),
                      );
                      if (passedInputCityName != null) {
                        var weatherData = await weather.getCity(passedInputCityName);
                        updateUI(weatherData);
                        print(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature° ',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0,top: 50),
                child: Text(
                  '$weatherMessage',
                  textAlign: TextAlign.left,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
