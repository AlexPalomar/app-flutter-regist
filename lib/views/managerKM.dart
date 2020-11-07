import 'package:flutter/material.dart';
import 'package:Regist/views/detail_dayKM.dart';

class Manager_Km extends StatefulWidget {
  @override
  _Manager_KmState createState() => _Manager_KmState();
}

class _Manager_KmState extends State<Manager_Km> {
  @override
  Widget build(BuildContext context) {
    var cardTextStyle = TextStyle(
        fontFamily: "Montserrat Regular",
        fontWeight: FontWeight.w800,
        fontSize: 14,
        color: Color.fromRGBO(63, 63, 63, 1));

    getCurrentMonth() {
      var now = new DateTime.now();
      var currentMonth = now.month;
      var nameMonth;
      switch (currentMonth) {
        case 1:
          nameMonth = 'Enero';
          break;
        case 2:
          nameMonth = 'Febrero';
          break;
        case 3:
          nameMonth = 'Marzo';
          break;
        case 4:
          nameMonth = 'Abril';
          break;
        case 5:
          nameMonth = 'Mayo';
          break;
        case 6:
          nameMonth = 'Junio';
          break;
        case 7:
          nameMonth = 'Julio';
          break;
        case 8:
          nameMonth = 'Agosto';
          break;
        case 9:
          nameMonth = 'Septiembre';
          break;
        case 10:
          nameMonth = 'Octubre';
          break;
        case 11:
          nameMonth = 'Noviembre';
          break;
        case 12:
          nameMonth = 'Diciembre';
          break;
      }

      return nameMonth;
    }

    Widget _buildCard(String numberDay) {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 4,
        child: InkWell(
          onTap: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => Detail_dayKM())),
          splashColor: Colors.deepOrangeAccent[400],
          child: Column(
            children: <Widget>[
              Text('Día', style: cardTextStyle),
              Padding(
                padding: const EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 6.0),
                child: Text(
                  numberDay,
                  style: cardTextStyle,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        child: new Container(
          padding: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Column(
            children: [
              new Padding(
                padding:
                    const EdgeInsets.only(left: 30.0, top: 20.0, bottom: 20.0),
                child: new Text(
                  'Manager KM',
                  style: new TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ],
          ),
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [Colors.red, Colors.orange],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(4.0, 0.2),
                  stops: [0.0, 0.5]),
              boxShadow: [
                new BoxShadow(
                  color: Colors.grey[500],
                  blurRadius: 20.0,
                  spreadRadius: 1.0,
                )
              ]),
        ),
        preferredSize: new Size(MediaQuery.of(context).size.width, 65.0),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 24.0, 8.0, 8.0),
        child: Stack(
          children: <Widget>[
            SafeArea(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${getCurrentMonth()}',
                        style: TextStyle(
                            fontFamily: "Montserrat Regular",
                            fontWeight: FontWeight.w800,
                            fontSize: 22,
                            color: Color.fromRGBO(63, 63, 63, 1))),
                  ),
                  Expanded(
                    child: GridView.count(
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      primary: false,
                      children: <Widget>[
                        _buildCard('1'),
                        _buildCard('2'),
                        _buildCard('3'),
                        _buildCard('4'),
                        _buildCard('5'),
                        _buildCard('6'),
                        _buildCard('7'),
                        _buildCard('8'),
                        _buildCard('9'),
                        _buildCard('10'),
                        _buildCard('11'),
                        _buildCard('12'),
                        _buildCard('13'),
                        _buildCard('14'),
                        _buildCard('15'),
                        _buildCard('16'),
                        _buildCard('17'),
                        _buildCard('18'),
                        _buildCard('19'),
                        _buildCard('20'),
                        _buildCard('21'),
                        _buildCard('22'),
                        _buildCard('23'),
                        _buildCard('24'),
                        _buildCard('25'),
                        _buildCard('26'),
                        _buildCard('27'),
                        _buildCard('28'),
                        _buildCard('29'),
                        _buildCard('30'),
                        _buildCard('31'),
                      ],
                      crossAxisCount: 5,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
