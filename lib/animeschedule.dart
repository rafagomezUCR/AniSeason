import 'package:flutter/material.dart';
import 'package:myanimelistapp/dayinfo.dart';

class AnimeSchedule extends StatelessWidget {

  Container button(double screenwidth, double screenheight, String day, BuildContext context){
    return Container(
      height: screenheight * 0.15,
      width: screenwidth * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFcffff7),
            offset: Offset(-2, -2),
            blurRadius: 5,
          ),
          BoxShadow(
            color: Color(0xFF4ea792),
            offset: Offset(2, 2),
            blurRadius: 5,
          ),
        ],
      ),
      child: ButtonTheme(
        height: screenheight * 0.1,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 0.0,
          child: Text(
            day,
            style: TextStyle(color: Colors.teal),
          ),
          color: Color(0xFFB4F0EE),
          onPressed: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) =>
                    DayInfo(day.toLowerCase()),
              ),
            );
          },
        ),
      ),
    );
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
          'Anime Schedule',
          style: TextStyle(
            color: Colors.teal,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              button(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height, 'Monday', context),
              button(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height, 'Tuesday', context),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              button(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height, 'Wednesday', context),
              button(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height, 'Thursday', context),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              button(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height, 'Friday', context),
              button(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height, 'Saturday', context),
            ],
          ),
          button(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height, 'Sunday', context),
        ],
      ),
    );
  }
}
