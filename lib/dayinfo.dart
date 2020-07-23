import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myanimelistapp/AnimeBanner.dart';
import 'dart:convert';
import 'dart:async';

class DayInfo extends StatefulWidget {
  String _day;

  DayInfo(this._day)
      : super();

  @override
  _DayInfoState createState() => _DayInfoState();
}

class _DayInfoState extends State<DayInfo> {

  bool _loading = true;
  final String _dayurl = 'https://api.jikan.moe/v3/schedule/';
  Map dayinfo;
  List dayanime;

  Future getdayinfo() async {
    try {
      http.Response response = await http.get(_dayurl + widget._day);
      if (response.statusCode == 200) {
        dayinfo = json.decode(response.body);
        setState(() {
          dayanime = dayinfo[widget._day];
          dayanime.removeWhere((element) => element['r18'] == true);
          _loading = false;
        });
      } else {
        dayanime = List();
      }
    } catch (e) {
      dayanime = List();
    }
  }

  @override
  void initState() {
    super.initState();
    getdayinfo();
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
          widget._day.toUpperCase(),
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
        dayanime == null ? 0 : dayanime.length,
        itemBuilder: (BuildContext context, int index) {
          return AnimeBanner(
              dayanime[index]['image_url'],
              dayanime[index]['title'],
              MediaQuery.of(context).size.height,
              MediaQuery.of(context).size.width,
              dayanime[index]['mal_id']);
        },
      ),
    );
  }
}
