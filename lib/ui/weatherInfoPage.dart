import 'dart:convert';

import 'package:ex/models/weather.dart';
import 'package:ex/ui/inform_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherPage extends StatelessWidget {
  String country, population;
  List capital;
  WeatherPage(
      {required this.country, required this.capital, required this.population});
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: _body(_width, _height, context),
    );
  }

  _body(width, height, context) {
    return Stack(
      children: [
        _backImage(height, width),
        previewButton(context),
        startRound(),
        _country(),
        _inform(),
        _backButton(context)
      ],
    );
  }

  Image _backImage(height, width) {
    return Image.network(
      "https://source.unsplash.com/random",
      height: height,
      width: width,
      fit: BoxFit.cover,
    );
  }

  Positioned _backButton(context) {
    return Positioned(
      child: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  _inform() {
    return FutureBuilder(
      builder: (context, AsyncSnapshot<Weathers> snap) {
        var data = snap.data;
        if (snap.connectionState == ConnectionState.waiting) {
          return Positioned(
            bottom: 205,
            left: 40,
            child: CircularProgressIndicator(),
          );
        } else if (snap.connectionState == ConnectionState.done) {
          return Positioned(
            bottom: 205,
            left: 40,
            child: Row(children: [
              Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9GCkt7G-UDE5463FbU1ZazcUYyHnVpdtwsA&usqp=CAU',
                height: 60,
                width: 60,
              ),
              SizedBox(
                width: 20.0,
              ),
              Column(
                children: [
                  Text("Wind: ${data!.wind!.speed} m/s",
                      style: TextStyle(color: Colors.yellow, fontSize: 20)),
                  Text("${data.name} is ${data.weather![0].description}",style: TextStyle(
                  fontSize: 20,color: Colors.yellow),),
                ],
              )
            ]),
          );
        } else {
          return Positioned(bottom: 205, left: 40, child: Text("404"));
        }
        return Container();
      },
      future: _getData(),
    );
  }

  Positioned _country() {
    return Positioned(
      child: Text(
        "Meadow Springs Golf And Country Club",
        style: TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.white),
        maxLines: 2,
      ),
      bottom: 150,
      left: 40,
      right: 40,
    );
  }

  Positioned startRound() {
    return Positioned(
      child: OutlinedButton(
        child: Text(
          "Start Round",
          style: TextStyle(color: Colors.white, fontSize: 13),
        ),
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            fixedSize: Size(135, 35),
            primary: Colors.green,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
      ),
      right: 40,
      bottom: 70,
    );
  }

  Positioned previewButton(context) {
    return Positioned(
      child: OutlinedButton(
        
        child: Text(
          "Preview",
          style: TextStyle(color: Colors.white, fontSize: 13),
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => InformPage(capital: capital[0].toString(),country: country ,population: population,),));
        },
        style: OutlinedButton.styleFrom(
            fixedSize: Size(135, 35),
            primary: Colors.white,
            side: BorderSide(color: Colors.white, width: 0.9),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
      ),
      left: 40,
      bottom: 70,
    );
  }

  Future<Weathers> _getData() async {
    var res = await http.get(
      Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=${capital[0].toLowerCase()}&appid=3374357cf708f1f74d2602653461fdfc"),
    );
    if (res.statusCode == 200) {
      return Weathers.fromJson(jsonDecode(res.body));
    } else {
      throw Exception("");
    }
  }
}
