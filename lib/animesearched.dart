import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myanimelistapp/AnimeBanner.dart';
import 'dart:convert';
import 'dart:async';

import 'animeinfo.dart';

class AnimeSearched extends StatefulWidget {
  final double _screenheight;
  final double _screenwidth;
  final String _searchedanime;

  AnimeSearched(this._screenheight, this._screenwidth, this._searchedanime)
      : super();

  @override
  _AnimeSearched createState() => _AnimeSearched();
}

class _AnimeSearched extends State<AnimeSearched> {
  bool _loading = true;
  final String _urlbegin = 'http://api.jikan.moe/v3/search/anime?q=';
  Map animeinfo;
  List anime;

  Future getanimeinfo(String str) async {
    try {
      http.Response response = await http.get(_urlbegin + str.toLowerCase());
      if (response.statusCode == 200) {
        animeinfo = json.decode(response.body);
        setState(() {
          anime = animeinfo['results'];
          anime.removeWhere((element) =>
              element['rated'] == 'RX' || element['rated'] == 'Rx');
          _loading = false;
        });
      } else {
        anime = List();
      }
    } catch (e) {
      anime = List();
    }
  }

  @override
  void initState() {
    super.initState();
    getanimeinfo(widget._searchedanime);
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
          widget._searchedanime.toUpperCase(),
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
                  widget._screenwidth * 0.02,
                  widget._screenheight * 0.02,
                  widget._screenwidth * 0.02,
                  widget._screenheight * 0.2),
              scrollDirection: Axis.vertical,
              itemCount: anime == null ? 0 : anime.length,
              itemBuilder: (BuildContext context, int index) {
                return AnimeBanner(
                    anime[index]['image_url'],
                    anime[index]['title'],
                    widget._screenheight,
                    widget._screenwidth,
                    anime[index]['mal_id']);
              },
            ),
    );
  }
}
