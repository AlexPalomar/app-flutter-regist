import 'package:flutter/material.dart';
import 'package:Regist/views/managerRT.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:Regist/models/rt.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ManagerRT_new extends StatefulWidget {
  @override
  _ManagerRT_newState createState() => _ManagerRT_newState();
}

class _ManagerRT_newState extends State<ManagerRT_new> {
  Map data;
  List usersData;

  DateTime _dateTime = DateTime.now();
  final format = DateFormat("yyyy-MM-dd");
  // final format = DateFormat("yyyy-MM-dd kk:mm:a");

  dynamic rt = new Rt();
  String _id;
  String _ot;
  String _description;
  // String _password;
  // String _url;
  String _date;
  String _state;
  // String _calories;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildId() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'ID'),
      maxLength: 20,
      validator: (String value) {
        if (value.isEmpty) {
          return 'ID es Requerido';
        }

        return null;
      },
      onSaved: (String value) {
        rt.setId(value);
      },
    );
  }

  Widget _buildOt() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'OT'),
      maxLength: 20,
      validator: (String value) {
        if (value.isEmpty) {
          return 'OT es Requerido';
        }

        return null;
      },
      onSaved: (String value) {
        rt.setOt(value);
      },
    );
  }

  // Widget _buildEmail() {
  //   return TextFormField(
  //     decoration: InputDecoration(labelText: 'Email'),
  //     validator: (String value) {
  //       if (value.isEmpty) {
  //         return 'Email is Required';
  //       }

  //       if (!RegExp(
  //               r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
  //           .hasMatch(value)) {
  //         return 'Please enter a valid email Address';
  //       }

  //       return null;
  //     },
  //     onSaved: (String value) {
  //       _email = value;
  //     },
  //   );
  // }
  Widget _buildDescription() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Descripción'),
      maxLines: 3,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Descripción es Requerida';
        }

        return null;
      },
      onSaved: (String value) {
        rt.setDescription(value);
      },
    );
  }

  Widget _buildState() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: DropdownSearch<String>(
          mode: Mode.MENU,
          showSelectedItem: true,
          items: ['-sin valor-', "generado", "ejecución", "resuelto"],
          label: "Estado",
          hint: "Estado RT",
          popupItemDisabled: (String s) => s.startsWith('I'),
          selectedItem: "-sin valor-",
          validator: (String value) {
            if (value == '-sin valor-') {
              return 'Estado es Requerido';
            }

            return null;
          },
          onSaved: (String value) {
            rt.setStateRt(value);
          }),
    );
  }

  // Widget _buildPassword() {
  //   return TextFormField(
  //     decoration: InputDecoration(labelText: 'Password'),
  //     keyboardType: TextInputType.visiblePassword,
  //     validator: (String value) {
  //       if (value.isEmpty) {
  //         return 'Password is Required';
  //       }

  //       return null;
  //     },
  //     onSaved: (String value) {
  //       _password = value;
  //     },
  //   );
  // }

  // Widget _builURL() {
  //   return TextFormField(
  //     decoration: InputDecoration(labelText: 'Url'),
  //     keyboardType: TextInputType.url,
  //     validator: (String value) {
  //       if (value.isEmpty) {
  //         return 'URL is Required';
  //       }

  //       return null;
  //     },
  //     onSaved: (String value) {
  //       _url = value;
  //     },
  //   );
  // }

  Widget _buildDate() {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DateTimeField(
              format: format,
              decoration: InputDecoration(labelText: 'Fecha'),
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));
              },
              validator: (value) {
                if (value.toString() == "") {
                  return 'Fecha es Requerida';
                } else {
                  rt.setDate(value.toString());
                }

                return null;
              },
            ),
          ]),
    );
  }

  // Widget _buildCalories() {
  //   return TextFormField(
  //     decoration: InputDecoration(labelText: 'Calories'),
  //     keyboardType: TextInputType.number,
  //     validator: (String value) {
  //       int calories = int.tryParse(value);

  //       if (calories == null || calories <= 0) {
  //         return 'Calories must be greater than 0';
  //       }

  //       return null;
  //     },
  //     onSaved: (String value) {
  //       _calories = value;
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(24),
        child: ListView(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildId(),
                  _buildOt(),
                  _buildDescription(),
                  // _buildPassword(),
                  // _builURL(),
                  _buildDate(),
                  _buildState(),
                  // _buildCalories(),
                  SizedBox(height: 100),
                  RaisedButton(
                    color: Colors.deepOrange,
                    child: Text(
                      'Crear',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Montserrat Regular"),
                    ),
                    onPressed: () {
                      if (!_formKey.currentState.validate()) {
                        return;
                      }

                      _formKey.currentState.save();
                      //Send to API
                      sendModel();
                      sendData();
                      _formKey.currentState?.reset();
                      Fluttertoast.showToast(
                          msg: 'Guardado exitosamente',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black54,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => Manager_Rt()));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  sendModel() {
    data = {
      'id': '${rt.getId()}',
      'ot': '${rt.getOt()}',
      'description': '${rt.getDescription()}',
      'date': '${rt.getDate()}',
      'state': '${rt.getStateRt()}'
    };
  }

  sendData() {
    http.post('http://192.168.137.35:4000/api/rts',
        headers: {"Content-Type": "application/json"}, body: jsonEncode(data));
  }
}
