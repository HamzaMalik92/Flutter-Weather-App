import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  // called when widget is about to build
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  // called when widget is destroyed
  void deactivate() {
    super.deactivate();
  }

  // Get User Location
  void getLocation() async {
    WeatherModel weatherModel =WeatherModel();
    var weatherData=await weatherModel.getWeatherData();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(locationWeather: weatherData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // WanderingCubes
      // Loading Screen
      body: SpinKitSquareCircle(
        color: Colors.white,
        size: 50.0,
      ),
    );
  }
}
