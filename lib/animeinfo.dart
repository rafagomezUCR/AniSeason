import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class AnimeInfo extends StatefulWidget {
  int _id;

  AnimeInfo(this._id);

  @override
  _AnimeInfo createState() => _AnimeInfo();
}

class _AnimeInfo extends State<AnimeInfo> {
  bool _loading = true;
  final String _urlbegin = 'https://api.jikan.moe/v3/anime/';
  Map animeinfo;

  String type;
  String episodes;
  String airing;
  String duration;
  String rating;
  String synopsis;
  String imageurl;
  String animename;
  String score;
  List op;
  List ending;
  List genres;
  String genrelist = '';

  Future getinfo(int id) async {
    try {
      http.Response response = await http.get(_urlbegin + id.toString());
      if (response.statusCode == 200) {
        setState(() {
          animeinfo = json.decode(response.body);
          animename = animeinfo['title_english'] == null
              ? animeinfo['title']
              : animeinfo['title_english'];
          type = animeinfo['type'] == null ? 'No type' : animeinfo['type'];
          episodes = animeinfo['episodes'] == null
              ? 'Ongoing'
              : animeinfo['episodes'].toString();
          airing = animeinfo['airing'] == null
              ? 'false'
              : animeinfo['airing'].toString();
          duration = animeinfo['duration'] == null
              ? 'No Duration'
              : animeinfo['duration'];
          rating =
              animeinfo['rating'] == null ? 'No Rating' : animeinfo['rating'];
          synopsis = animeinfo['synopsis'] == null
              ? 'No Synopsis'
              : animeinfo['synopsis'];
          imageurl =
              animeinfo['image_url'] == null ? null : animeinfo['image_url'];
          score = animeinfo['score'] == null
              ? 'None'
              : animeinfo['score'].toString();
          op = animeinfo['opening_themes'] == null
              ? "Couldn't get Opening Themes"
              : animeinfo['opening_themes'];
          ending = animeinfo['ending_themes'] == null
              ? "Couldn't get Ending Themes"
              : animeinfo['ending_themes'];
          genres =
              animeinfo['genres'] == null ? 'No Genres' : animeinfo['genres'];
          for (int i = 0; i < genres.length; i++) {
            genrelist += genres[i]['name'] + ' ';
          }
          _loading = false;
        });
      } else {
        animeinfo = Map();
      }
    } catch (e) {
      animeinfo = Map();
    }
  }

  @override
  void initState() {
    super.initState();
    getinfo(widget._id);
  }

  BoxDecoration boxdecoration(double rad) {
    return BoxDecoration(
      color: Color(0xFFF1F2F6),
      borderRadius: BorderRadius.circular(rad),
      boxShadow: [
        BoxShadow(
            color: Color(0xFF4ea792), offset: Offset(6, 6), blurRadius: 12),
        BoxShadow(
            color: Color(0xFFcffff7), offset: Offset(-8, -6), blurRadius: 12),
      ],
    );
  }

  Container backbutton() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Container(
              width: 64, // this can make the button bigger
              height: 64, // makes button bigger
              decoration: boxdecoration(32),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.02,
              top: MediaQuery.of(context).size.width * 0.02,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container scorebutton() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Container(
              width: 64, // this can make the button bigger
              height: 64, // makes button bigger
              decoration: boxdecoration(32),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.04,
              top: MediaQuery.of(context).size.width * 0.04,
              child: Text(
                'Score\n ${score}',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container imagebackground() {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      height: MediaQuery.of(context).size.width - 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width),
        gradient: LinearGradient(
          colors: [Color(0xFFcffff7), Color(0xFF4ea792)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
              color: Color(0xFF4ea792), offset: Offset(6, 6), blurRadius: 12),
          BoxShadow(
              color: Color(0xFFcffff7), offset: Offset(-8, -6), blurRadius: 12),
        ],
      ),
    );
  }

  Positioned image() {
    return Positioned(
      top: 10,
      left: 10,
      right: 10,
      bottom: 10,
      child: CircleAvatar(
        backgroundImage: imageurl != null
            ? Image.network(imageurl).image
            : Image.asset('assets/noinfo.png').image,
      ),
    );
  }

  Padding animetitle() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        '${animename}',
        style: TextStyle(
          fontSize: 20,
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Padding animeinfobox() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: double.infinity,
        decoration: boxdecoration(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'Type: ${type}',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  wordSpacing: 2,
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                'Episodes: ${episodes}',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  wordSpacing: 2,
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                'Airing: ${airing}',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  wordSpacing: 2,
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                'Duration: ${duration}',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  wordSpacing: 2,
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                'Rating: ${rating}',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  wordSpacing: 2,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding animethemes() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: double.infinity,
        decoration: boxdecoration(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'Opening Themes',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  wordSpacing: 2,
                  letterSpacing: 0.5,
                ),
              ),
              for (var item in op)
                Text(
                  '${item}',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    wordSpacing: 2,
                    letterSpacing: 0.5,
                  ),
                ),
              Text(
                'Ending Themes',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  wordSpacing: 2,
                  letterSpacing: 0.5,
                ),
              ),
              for (var item in ending)
                Text(
                  '${item}',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    wordSpacing: 2,
                    letterSpacing: 0.5,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Padding animesynopsis() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: double.infinity,
        decoration: boxdecoration(10.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'Synopsis',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  wordSpacing: 2,
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                '${synopsis}',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  wordSpacing: 2,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding animegenres() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: double.infinity,
        decoration: boxdecoration(10.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'Genres',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  wordSpacing: 2,
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                genrelist,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  wordSpacing: 10,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB4F0EE) /*Color(0xFF7ff2d9)*/,
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: SafeArea(
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          backbutton(),
                          scorebutton(),
                        ],
                      ),
                      Stack(
                        children: [
                          imagebackground(),
                          image(),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      animetitle(),
                      animeinfobox(),
                      animegenres(),
                      animesynopsis(),
                      animethemes(),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
