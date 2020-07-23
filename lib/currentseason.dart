import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myanimelistapp/AnimeBanner.dart';
import 'dart:convert';
import 'dart:async';

class CurrentSeason extends StatefulWidget {
  @override
  _CurrentSeason createState() => _CurrentSeason();
}

class _CurrentSeason extends State<CurrentSeason> {

  bool _loading = true;
  final String _currentseasonurl =
      'https://api.jikan.moe/v3/season/2020/summer';
  Map currentseasoninfo;
  List currentseasonanime;

  Future getcurrentseason() async {
    try {
      http.Response response = await http.get(_currentseasonurl);
      if (response.statusCode == 200) {
        currentseasoninfo = json.decode(response.body);
        setState(() {
          currentseasonanime = currentseasoninfo['anime'];
          currentseasonanime.removeWhere((element) => element['r18'] == true);
          _loading = false;
        });
      } else {
        currentseasonanime = List();
      }
    } catch (e) {
      currentseasonanime = List();
    }
  }

  @override
  void initState() {
    super.initState();
    getcurrentseason();
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
          'Current Season',
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
              itemCount:
                  currentseasonanime == null ? 0 : currentseasonanime.length,
              itemBuilder: (BuildContext context, int index) {
                return AnimeBanner(
                    currentseasonanime[index]['image_url'],
                    currentseasonanime[index]['title'],
                    MediaQuery.of(context).size.height,
                    MediaQuery.of(context).size.width,
                    currentseasonanime[index]['mal_id']);
              },
            ),
    );
  }
}
