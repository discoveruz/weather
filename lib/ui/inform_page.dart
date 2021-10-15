import 'package:ex/ui/image_slider.dart';
import 'package:flutter/material.dart';

class InformPage extends StatefulWidget {
  String capital, country, population;
  InformPage(
      {required this.capital, required this.country, required this.population});
  @override
  State<InformPage> createState() => _InformPageState();
}

class _InformPageState extends State<InformPage> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: _body(_width, _height),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  _body(width, height) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _imageSlider(),
          _callFollow(),
          Divider(height: 40),
          _information(),
          SizedBox(height: 35.0),
          _textInform(),
          SizedBox(height: 30.0),
          ListTile(
            onTap: () {},
            selectedTileColor: Colors.grey,
            title: Text("Show scored"),
            trailing: Icon(Icons.navigate_next_outlined),
          )
        ],
      ),
    );
  }

  Padding _textInform() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
        style: TextStyle(
          color: Colors.grey,
        ),
        maxLines: 10,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Padding _information() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Information",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              Spacer(),
              Icon(Icons.star),
              Text("4.6"),
              Spacer(),
              Text('${int.parse(widget.population)~/1000000}M'),
              Spacer(),
              Icon(Icons.golf_course),
              Spacer()
            ],
          ),
          Row(
            children: [
              Spacer(),
              Text(
                "431 reviews",
                style: TextStyle(color: Colors.grey),
              ),
              Spacer(),
              Text(
                "population",
                style: TextStyle(color: Colors.grey),
              ),
              Spacer(),
              Text(
                "18 holes",
                style: TextStyle(color: Colors.grey),
              ),
              Spacer()
            ],
          )
        ],
      ),
    );
  }

  Padding _callFollow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${widget.capital} is capital of ${widget.country}",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(
                  Icons.call,
                  color: Colors.grey,
                  size: 20,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.navigation_rounded,
                  color: Colors.grey,
                  size: 20,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.map,
                  color: Colors.grey,
                  size: 20,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.calendar_today_rounded,
                  color: Colors.grey,
                  size: 20,
                ),
                onPressed: () {},
              ),
              Spacer(),
              preViewButton("Follow"),
            ],
          )
        ],
      ),
    );
  }

  SizedBox _imageSlider() {
    return SizedBox(
      child: ComplicatedImageDemo(),
      width: double.infinity,
      height: 250,
    );
  }

  Padding bottomNavigationBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          preViewButton("Preview"),
          startRoundButton(),
        ],
      ),
    );
  }

  OutlinedButton startRoundButton() {
    return OutlinedButton(
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
    );
  }

  OutlinedButton preViewButton(name) {
    return OutlinedButton(
      child: Text(
        "$name",
        style: TextStyle(color: Colors.green, fontSize: 13),
      ),
      onPressed: () {},
      style: OutlinedButton.styleFrom(
          fixedSize: Size(135, 35),
          primary: Colors.white,
          side: BorderSide(color: Colors.green, width: 0.9),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
    );
  }
}
