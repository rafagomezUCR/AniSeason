import 'package:flutter/material.dart';

import 'animeinfo.dart';

class AnimeBanner extends StatelessWidget {

  AnimeBanner(this.image, this.name, this.screenh, this.screenw, this.id);

  String image;
  String name;
  double screenh;
  double screenw;
  int id;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) =>
                  AnimeInfo(id),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xFFcffff7),
                offset: Offset(-6, -6),
                blurRadius: 5,
              ),
              BoxShadow(
                color: Color(0xFF4ea792),
                offset: Offset(4, 4),
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: screenh * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                    ),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(5),
                  child: Text(
                    name,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
