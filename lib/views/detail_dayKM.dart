import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Detail_dayKM extends StatefulWidget {
  @override
  _Detail_dayKMState createState() => _Detail_dayKMState();
}

class _Detail_dayKMState extends State<Detail_dayKM> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final format = DateFormat("yyyy-MM-dd");
  DateTime _dateTime = DateTime.now();
  var time;

  var cardTextStyle = TextStyle(
      fontFamily: "Montserrat Regular",
      fontWeight: FontWeight.w800,
      fontSize: 14,
      color: Color.fromRGBO(63, 63, 63, 1));

  Widget _buildCard(String numberDay) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
                    child: Text(
                      '27/10/2020',
                      // '${usersData[index]['date']}',
                      style: TextStyle(
                          fontSize: 14,
                          // color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Montserrat Regular"),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
                    child: Text(
                      'KM: ',
                      style: TextStyle(
                          fontSize: 16,
                          // color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Montserrat Regular"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 12.0),
                    child: Text(
                      '10035',
                      // '${usersData[index]['id']}',
                      style: TextStyle(
                          fontSize: 16,
                          // color: Colors.white,
                          // fontWeight: FontWeight.w700,
                          fontFamily: "Montserrat Regular"),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
                    child: Text(
                      'Creado: ',
                      style: TextStyle(
                          fontSize: 16,
                          // color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Montserrat Regular"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 12.0),
                    child: Text(
                      '27/10/2020',
                      // '${usersData[index]['ot']}',
                      style: TextStyle(
                          fontSize: 16,
                          // color: Colors.white,
                          // fontWeight: FontWeight.w700,
                          fontFamily: "Montserrat Regular"),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
                    child: Text(
                      'Modificado: ',
                      style: TextStyle(
                          fontSize: 16,
                          // color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Montserrat Regular"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 12.0),
                    child: Text(
                      '27/10/2020',
                      // '${usersData[index]['ot']}',
                      style: TextStyle(
                          fontSize: 16,
                          // color: Colors.white,
                          // fontWeight: FontWeight.w700,
                          fontFamily: "Montserrat Regular"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormKm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        decoration: InputDecoration(labelText: 'KM'),
        maxLength: 20,
        validator: (String value) {
          if (value.isEmpty) {
            return 'KM es Requerido';
          }

          return null;
        },
        onSaved: (String value) {
          // rt.setId(value);
        },
      ),
    );
  }

  Widget _messageToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Widget _buildButton(String textName, String action) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
        color: Colors.deepOrange,
        child: Text(
          textName,
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              fontFamily: "Montserrat Regular"),
        ),
        onPressed: () {
          switch (action) {
            case 'new':
              if (!_formKey.currentState.validate()) {
                return;
              }
              _messageToast('Guardado exitosamente');
              break;
            case 'update':
              if (!_formKey.currentState.validate()) {
                return;
              }
              _messageToast('Modificado exitosamente');
              break;
          }

          _formKey.currentState.save();
          //Send to API

          _formKey.currentState?.reset();
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => Detail_dayKM()));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          child: new Container(
            padding:
                new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Column(
              children: [
                new Padding(
                  padding: const EdgeInsets.only(
                      left: 30.0, top: 20.0, bottom: 20.0),
                  child: new Text(
                    'Octubre Dia 1',
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
        body: Stack(
          children: <Widget>[
            Wrap(children: [
              _buildCard('1'),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildFormKm(),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                              child: Text('Creado:'),
                            ),
                            Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    16.0, 0.0, 0.0, 0.0),
                                child: Text(_dateTime.day.toString() +
                                    '-' +
                                    _dateTime.month.toString() +
                                    '-' +
                                    _dateTime.year.toString())),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                              child: Text('Modificado:'),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  16.0, 0.0, 0.0, 0.0),
                              child: Text(_dateTime.day.toString() +
                                  '-' +
                                  _dateTime.month.toString() +
                                  '-' +
                                  _dateTime.year.toString()),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _buildButton('Crear', 'new'),
                          _buildButton('Modificar', 'update')
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ])
          ],
        ));
  }
}
