import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'animesearched.dart';
import 'AnimeBanner.dart';
import 'AppDrawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.teal,
        accentColorBrightness: Brightness.dark,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  //Home() : super();

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  bool _loading = true;
  final String airingurl = 'https://api.jikan.moe/v3/top/anime/1/airing';
  final String currentseasonurl = 'https://api.jikan.moe/v3/season/2020/spring';
  Map airinginfo;
  List airinganime;
  String infotext = 'Simple anime app that is used to search anime and the catalog'
      ' of anime seasons. This app was possible thanks to Jikan, an unofficial '
      'MyAnimeList API, please visit https://jikan.moe/ for more info about Jikan';

  Future getairinginfo() async {
    try {
      http.Response response = await http.get(airingurl);
      if (response.statusCode == 200) {
        airinginfo = json.decode(response.body);
        setState(() {
          airinganime = airinginfo['top'];
          _loading = false;
        });
      } else {
        airinganime = List();
      }
    } catch (e) {
      airinganime = List();
    }
  }

  @override
  void initState() {
    super.initState();
    getairinginfo();
  }

  Container searchbar(double screenwidth, double screenheight) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          screenwidth * 0.05, 0.0, screenwidth * 0.05, screenheight * 0.01),
      child: TextField(
        cursorColor: Colors.teal,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.teal),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.teal),
          ),
          suffixIcon: Icon(
            Icons.search,
            color: Colors.teal,
          ),
          hintText: "Search Anime",
          hintStyle: TextStyle(
            color: Colors.teal,
          ),
        ),
        maxLength: 100,
        onSubmitted: (String str) {
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) =>
                  AnimeSearched(screenheight, screenheight, str),
            ),
          );
        },
      ),
    );
  }

  Container topairingtitle(double screenwidth, double screenheight) {
    return Container(
      padding: EdgeInsets.fromLTRB(screenwidth * 0.03, screenheight * 0.01,
          screenwidth * 0.03, screenheight * 0.01),
      alignment: Alignment.centerLeft,
      child: Text(
        'Top Airing',
        style: TextStyle(fontSize: 20, color: Colors.teal),
      ),
    );
  }

  Container gridviewbuilder(double screenheight, double screenwidth) {
    return Container(
      height: screenheight * 0.7,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.7,
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        padding: EdgeInsets.fromLTRB(screenwidth * 0.05, screenheight * 0.02,
            screenwidth * 0.05, screenheight * 0.2),
        scrollDirection: Axis.vertical,
        itemCount: airinganime == null ? 0 : airinganime.length,
        itemBuilder: (BuildContext context, int index) {
          return AnimeBanner(
              airinganime[index]['image_url'],
              airinganime[index]['title'],
              screenheight,
              screenwidth,
              airinganime[index]['mal_id']);
        },
      ),
    );
  }

  infobutton(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(infotext),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFB4F0EE),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.teal),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              infobutton(context);
            },
          )
        ],
        title: Text(
          'Anime Seasons',
          style: TextStyle(
            color: Colors.teal,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      drawer: AnimeDrawer(),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFFB4F0EE),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              searchbar(screenwidth, screenheight),
              topairingtitle(screenwidth, screenheight),
              _loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : gridviewbuilder(screenheight, screenwidth),
            ],
          ),
        ),
      ),
    );
  }
}
