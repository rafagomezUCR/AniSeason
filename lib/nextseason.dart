import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'AnimeBanner.dart';

class NextSeason extends StatefulWidget {
  @override
  _NextSeason createState() => _NextSeason();
}

class _NextSeason extends State<NextSeason> {
  bool _loading = true;
  final String _nextseasonurl = 'https://api.jikan.moe/v3/season/2020/fall';
  Map nextseasoninfo;
  List nextseasonanime;

  Future getnextseason() async {
    try {
      http.Response response = await http.get(_nextseasonurl);
      if (response.statusCode == 200) {
        nextseasoninfo = json.decode(response.body);
        setState(() {
          nextseasonanime = nextseasoninfo['anime'];
          nextseasonanime.removeWhere((element) => element['r18'] == true);
          _loading = false;
        });
      } else {
        nextseasonanime = List();
      }
    } catch (e) {
      nextseasonanime = List();
    }
  }

  @override
  void initState() {
    super.initState();
    getnextseason();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB4F0EE),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.teal,
        ),
        title: Text(
          'Next Season',
          style: TextStyle(
            color: Colors.teal,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.7,
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.02,
                  MediaQuery.of(context).size.height * 0.02,
                  MediaQuery.of(context).size.width * 0.02,
                  MediaQuery.of(context).size.height * 0.2),
              scrollDirection: Axis.vertical,
              itemCount: nextseasonanime == null ? 0 : nextseasonanime.length,
              itemBuilder: (BuildContext context, int index) {
                return AnimeBanner(
                    nextseasonanime[index]['image_url'],
                    nextseasonanime[index]['title'],
                    MediaQuery.of(context).size.height,
                    MediaQuery.of(context).size.width,
                    nextseasonanime[index]['mal_id']);
              },
            ),
    );
  }
}
