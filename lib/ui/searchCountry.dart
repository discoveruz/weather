import 'dart:convert';
import 'package:ex/ui/weatherInfoPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchCountry extends StatefulWidget {
  @override
  State<SearchCountry> createState() => _SearchCountryState();
}

class _SearchCountryState extends State<SearchCountry> {
  TextEditingController _controller = TextEditingController();

  int _currentIndex = 3;

  String _searchedCountry = 'japan';

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: _body(_width, _height),
      bottomNavigationBar: _bottomNavigatorBar(),
    );
  }

  _body(width, height) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 20, top: 30, bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _searchWithItems(),
          _sized(25),
          _view(name: "Nearby Courses"),
          _constText(),
          _sized(20),
          _nearbyCountries(width, height),
          _sized(35),
          _view(name: "Top Rated"),
          _sized(20),
          _foundCountry(width),
        ],
      ),
    );
  }

  BottomNavigationBar _bottomNavigatorBar() {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: _currentIndex,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey[600],
      onTap: (v) {
        _currentIndex = v;
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.stacked_bar_chart_outlined), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.golf_course), label: '')
      ],
    );
  }

  SingleChildScrollView _foundCountry(width) {
    return SingleChildScrollView(
      child: FutureBuilder(
        // initialData: ,
        builder: (
          context,
          AsyncSnapshot<Map> snap,
        ) {
          Map data = snap.data!;
          if (snap.connectionState == ConnectionState.done) {
            return Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WeatherPage(
                          country:data["country"] ,
                          capital: data["capital"],
                          population: data["population"].toString(),
                        ),
                      ));
                },
                child: Container(
                  alignment: Alignment.center,
                  width: width * 0.5,
                  height: 220,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      image: DecorationImage(
                        image: NetworkImage(data["flag"].toString()),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(16)),
                  child: Text(
                    "${data["region"]} ${data["capital"][0]}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            );
          } else if (snap.connectionState == ConnectionState.waiting) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          } else {
            return Center();
          }
        },
        future: _getData(),
      ),
    );
  }

  Text _constText() {
    return const Text(
      "Near from Allison Park, PA 15101",
      style: TextStyle(fontSize: 15.85, color: Colors.grey, height: 0.3),
    );
  }

  SizedBox _sized(double x) {
    return SizedBox(
      height: x,
    );
  }

  SizedBox _nearbyCountries(width, height) {
    return SizedBox(
      width: width,
      height: height * 0.265,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 1.5,
            crossAxisSpacing: 5,
            mainAxisSpacing: 9),
        itemBuilder: (context, index) {
          return Stack(children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:
                      NetworkImage('https://source.unsplash.com/random/$index'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              width: 135,
              child: Column(
                children: [
                  Text(
                    "$index sdcl sdf jbfjk gbfh Bk jfb SbfS JjDVS jhfjgfc jhgjhv ",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      Text(
                        "${(4.2 * 10 - index) / 10} * ${index / 10} mil",
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  )
                ],
              ),
            )
          ]);
        },
        itemCount: 10,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Row _view({name}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$name",
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const TextButton(
          onPressed: null,
          child: Text(
            "View All",
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
              color: Colors.green,
            ),
          ),
        )
      ],
    );
  }

  Column _searchWithItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 25.0,
        ),
        const Text(
          "Countries",
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        const Text(
          "Find a place to traveling",
          style: TextStyle(
            fontSize: 14.75,
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: "Type to saerch...",
            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                _searchedCountry = _controller.text;
                setState(() {});
              },
            ),
          ),
        ),
      ],
    );
  }

  Future<Map> _getData() async {
    var res = await http.get(
        Uri.parse("https://restcountries.com/v3.1/name/$_searchedCountry"));
    Future.delayed(Duration(microseconds: 200), () {});
    Map<String, dynamic> x = {
      "country":jsonDecode(res.body)[0]["name"]["common"]
      ,"capital": jsonDecode(res.body)[0]["capital"] as List,
      "region": jsonDecode(res.body)[0]["region"] as String,
      "population": jsonDecode(res.body)[0]["population"] as int,
      "flag": jsonDecode(res.body)[0]["flags"]["png"]
    };
    return x;
  }

  
}
