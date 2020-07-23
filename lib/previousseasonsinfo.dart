import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myanimelistapp/AnimeBanner.dart';
import 'dart:convert';
import 'dart:async';

class PreviousSeasonsInfo extends StatefulWidget {

  final String _year;
  final int _season;

  PreviousSeasonsInfo(this._year, this._season)
      : super();

  @override
  _PreviousSeasonsInfo createState() => _PreviousSeasonsInfo();
}

class _PreviousSeasonsInfo extends State<PreviousSeasonsInfo> {

  bool _loading = true;
  final String _previousseaonsinfourl = 'https://api.jikan.moe/v3/season/';
  Map previousseaonsinfoinfo;
  List previousseaonsinfoanime;

  Future getpreviousseaonsinfo() async{
    try {
      String season;
      if(widget._season == 0){
        season = 'spring';
      }
      else if(widget._season == 1){
        season = 'summer';
      }
      else if(widget._season == 2){
        season = 'fall';
      }
      else{
        season = 'winter';
      }
      String temp = widget._year + '/' + season;
      http.Response response = await http.get(_previousseaonsinfourl + temp);
      if (response.statusCode == 200) {
        previousseaonsinfoinfo = json.decode(response.body);
        setState(() {
          previousseaonsinfoanime = previousseaonsinfoinfo['anime'];
          previousseaonsinfoanime.removeWhere((element) => element['r18'] == true);
          _loading = false;
        });
      } else {
        previousseaonsinfoanime = List();
      }
    } catch (e) {
      previousseaonsinfoanime = List();
    }
  }

  @override
  void initState() {
    super.initState();
    getpreviousseaonsinfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB4F0EE),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.teal,
        ),
        title: Text('Previous Season', style: TextStyle(color: Colors.teal),),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: _loading ? Center(child: CircularProgressIndicator(),) : GridView.builder(
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
        itemCount: previousseaonsinfoanime == null ? 0 : previousseaonsinfoanime.length,
        itemBuilder: (BuildContext context, int index) {
          return AnimeBanner(previousseaonsinfoanime[index]['image_url'], previousseaonsinfoanime[index]['title'],
              MediaQuery.of(context).size.height, MediaQuery.of(context).size.width, previousseaonsinfoanime[index]['mal_id']);
        },
      ),
    );
  }
}