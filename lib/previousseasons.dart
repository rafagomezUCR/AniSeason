import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myanimelistapp/previousseasonsinfo.dart';

class PreviousSeasons extends StatefulWidget {
  @override
  _PreviousSeasons createState() => _PreviousSeasons();
}

List<String> year = [
  '1990',
  '1991',
  '1992',
  '1993',
  '1994',
  '1995',
  '1996',
  '1997',
  '1998',
  '1999',
  '2000',
  '2001',
  '2002',
  '2003',
  '2004',
  '2005',
  '2006',
  '2007',
  '2008',
  '2009',
  '2010',
  '2011',
  '2012',
  '2013',
  '2014',
  '2015',
  '2016',
  '2017',
  '2018',
  '2019',
  '2020'
];

class _PreviousSeasons extends State<PreviousSeasons> {
  String dropdownvalue = '2020';
  int selectedbutton = 0;

  Padding submitbutton() {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Container(
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
          height: MediaQuery.of(context).size.height * 0.1,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            elevation: 0.0,
            child: Text(
              'Submit',
              style: TextStyle(color: Colors.teal),
            ),
            color: Color(0xFFB4F0EE),
            onPressed: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) =>
                      PreviousSeasonsInfo('$dropdownvalue', selectedbutton),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget radiobutton(String str, int button) {
    return OutlineButton(
      onPressed: () => changebutton(button),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      borderSide: BorderSide(
          color: selectedbutton == button ? Colors.redAccent : Colors.teal),
      child: Text(
        str,
        style: TextStyle(color: selectedbutton == button ? Colors.redAccent : Colors.teal),
      ),
    );
  }

  void changebutton(int button){
    setState(() {
      selectedbutton = button;
    });
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
          'Search Season',
          style: TextStyle(
            color: Colors.teal,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                radiobutton('Spring', 0),
                radiobutton('Summer', 1),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                radiobutton('Fall', 2),
                radiobutton('Winter', 3),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: DropdownButton<String>(
                value: dropdownvalue,
                style: TextStyle(
                  color: Colors.teal,
                ),
                focusColor: Colors.teal,
                dropdownColor: Color(0xFFB4F0EE),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownvalue = newValue;
                  });
                },
                items: year.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            submitbutton(),
          ],
        ),
      ),
    );
  }
}
