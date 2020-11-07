import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'package:Regist/models/rt.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ManagerRT_list extends StatefulWidget {
  @override
  _ManagerRT_listState createState() => _ManagerRT_listState();
}

class _ManagerRT_listState extends State<ManagerRT_list> {
  TextEditingController _controller;

  Map data;
  List usersData;
  // List _rtForDisplay = List();
  bool flag = false;
  String textFilter;
  String textQuery;

  _checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      _showDialog('No internet', "No tiene conexión a internet");
    } else if (result == ConnectivityResult.mobile) {
      // getRts();
      // _showDialog('Internet access', "You're connected over mobile data");
      _showDialog('No internet', "No está conectado a una red wifi");
    } else if (result == ConnectivityResult.wifi) {
      getRts();
      // _showDialog('Internet access', "You're connected over wifi");
    }
  }

  _showDialog(title, text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  getRts() async {
    http.Response response = await http.get('http://192.168.56.1:4000/api/rts');
    // await http.get('http://10.2.2.2:4000/api/tasks');
    data = json.decode(response.body);

    setState(() {
      usersData = data['rts'];
    });
    // debugPrint(usersData[1]['id'].toString());
  }

  getRtsFilter(option, text) async {
    debugPrint(text);
    switch (option) {
      case 'RT':
        if (text != null) {
          http.Response response =
              await http.get('http://192.168.56.1:4000/api/rts/id/$text');
          data = json.decode(response.body);

          if (data['rts'].toString() == 'no registra') {
            _showDialog('Busqueda', 'no hay registros');
          } else {
            setState(() {
              usersData = data['rts'];
            });
          }
        }
        break;

      case 'OT':
        if (text != null) {
          http.Response response =
              await http.get('http://192.168.56.1:4000/api/rts/ot/$text');
          data = json.decode(response.body);

          if (data['rts'].toString() == 'no registra') {
            _showDialog('Busqueda', 'no hay registros');
          } else {
            setState(() {
              usersData = data['rts'];
            });
          }
        }
        break;

      case 'Descripción':
        if (text != null) {
          http.Response response = await http
              .get('http://192.168.56.1:4000/api/rts/description/$text');
          data = json.decode(response.body);

          if (data['rts'].toString() == 'no registra') {
            _showDialog('Busqueda', 'no hay registros');
          } else {
            setState(() {
              usersData = data['rts'];
            });
          }
        } else {}

        break;

      case 'Estado':
        if (text != null) {
          http.Response response =
              await http.get('http://192.168.56.1:4000/api/rts/state/$text');
          data = json.decode(response.body);

          if (data['rts'].toString() == 'no registra') {
            _showDialog('Busqueda', 'no hay registros');
          } else {
            setState(() {
              usersData = data['rts'];
            });
          }
        } else {
          debugPrint('err');
        }

        break;

      case 'Fecha':
        if (text != null) {
          http.Response response =
              await http.get('http://192.168.56.1:4000/api/rts/date/$text');
          data = json.decode(response.body);
          if (data['rts'].toString() == 'no registra') {
            _showDialog('Busqueda', 'no hay registros');
          } else {
            setState(() {
              usersData = data['rts'];
            });
          }
        } else {
          debugPrint('error');
        }
        break;
    }
  }

  _dropdownFilter() {
    var dropdownSearch = DropdownSearch<String>(
      mode: Mode.MENU,
      // label: "filtrar",
      showSelectedItem: true,
      items: ["filtrar", "RT", "OT", "Descripción", "Estado", "Fecha"],
      popupItemDisabled: (String s) => s.startsWith('I'),
      selectedItem: "filtrar",
      onChanged: (String value) {
        if (value == 'filtrar') {
          return 'Estado es Requerido';
        } else {
          setState(() {
            textFilter = value;
          });
        }
        return value;
      },
    );
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 8.0),
      child: dropdownSearch,
    );
  }

  _searchBar() {
    var textField = TextField(
      controller: _controller,
      decoration: InputDecoration(hintText: 'Buscar...'),
      onSubmitted: (String value) async {
        if (value != '') {
          // return;
          value = value.toLowerCase();
          getRtsFilter(textFilter, value);
        } else {
          getRts();
        }
      },
    );
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 8.0, 4.0, 8.0),
      child: textField,
    );
  }

  _messageToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController();
    _checkInternetConnectivity();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 185.0,
                  child: _searchBar(),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 165.0,
                  height: 65.0,
                  child: _dropdownFilter(),
                )
              ],
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 58, 0, 12),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
                itemCount: usersData == null ? 0 : usersData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      12.0, 12.0, 12.0, 0.0),
                                  child: Text(
                                    '${usersData[index]['date']}',
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
                                  padding: const EdgeInsets.fromLTRB(
                                      12.0, 0.0, 12.0, 12.0),
                                  child: Text(
                                    'ID: ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        // color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Montserrat Regular"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 0.0, 12.0, 12.0),
                                  child: Text(
                                    '${usersData[index]['id']}',
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
                                  padding: const EdgeInsets.fromLTRB(
                                      12.0, 0.0, 12.0, 12.0),
                                  child: Text(
                                    'OT: ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        // color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Montserrat Regular"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 0.0, 12.0, 12.0),
                                  child: Text(
                                    '${usersData[index]['ot']}',
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
                                  padding: const EdgeInsets.fromLTRB(
                                      12.0, 0.0, 0.0, 12.0),
                                  child: Text(
                                    'Descripción:',
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
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 0.0, 0.0, 12.0),
                                    child: Text(
                                      '${usersData[index]['description']}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          // color: Colors.white,
                                          // fontWeight: FontWeight.w700,
                                          fontFamily: "Montserrat Medium"),
                                    ),
                                  ),
                                ),
                                // ),
                              ],
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 0.0, 12.0, 0.0),
                                    child: Text(
                                      'Estado:',
                                      style: TextStyle(
                                          fontSize: 14,
                                          // color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Montserrat Regular"),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0.0, 0.0, 12.0, 0.0),
                                    child: Text(
                                      '${usersData[index]['state']}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          // color: Colors.white,
                                          // fontWeight: FontWeight.w700,
                                          fontFamily: "Montserrat Medium"),
                                    ),
                                  ),
                                ]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                FlatButton(
                                    child: Icon(Icons.content_copy),
                                    onPressed: () {
                                      FlutterClipboard.copy('Fecha: ${usersData[index]['date']}\n' +
                                              'ID: ${usersData[index]['id']}\n' +
                                              'OT: ${usersData[index]['ot']}\n' +
                                              'Descripción: ${usersData[index]['description']}\n' +
                                              'Estado: ${usersData[index]['state']}\n')
                                          .then((value) => print('copied'));
                                      _messageToast('Copiado');
                                    }),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}
