import 'package:flutter/material.dart';
import 'package:myanimelistapp/animeschedule.dart';

import 'currentseason.dart';
import 'nextseason.dart';
import 'previousseasons.dart';

class AnimeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Center(
              child: Container(
                padding: EdgeInsets.only(bottom: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFF4ea792),
                        offset: Offset(6, 6),
                        blurRadius: 12),
                    BoxShadow(
                        color: Color(0xFFcffff7),
                        offset: Offset(-6, -6),
                        blurRadius: 12),
                  ],
                ),
                child: Image(
                  image: Image.asset('assets/logo.png').image,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Color(0xFFB4F0EE),
            ),
          ),
          ListTile(
            title: Text('Current Season', style: TextStyle(color: Colors.teal),),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => CurrentSeason(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Next Season', style: TextStyle(color: Colors.teal),),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => NextSeason(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Previous Seasons', style: TextStyle(color: Colors.teal),),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => PreviousSeasons(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Anime Schedule', style: TextStyle(color: Colors.teal),),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => AnimeSchedule(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
