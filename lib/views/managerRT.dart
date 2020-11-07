import 'package:flutter/material.dart';
import 'package:Regist/tabs/contacto_tabs.dart';
import 'package:Regist/tabs/managerRT_new.dart';
import 'package:Regist/tabs/managerRT_list.dart';

class Manager_Rt extends StatefulWidget {
  @override
  _Manager_RtState createState() => _Manager_RtState();
}

class _Manager_RtState extends State<Manager_Rt> {
  @override
  Widget build(BuildContext context) {
    final TabController = new DefaultTabController(
      length: 2, // número de iconos o tabs de la barra
      child: new Scaffold(
        appBar: new PreferredSize(
          child: new Container(
            padding:
                new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Column(
              children: [
                new Padding(
                  padding: const EdgeInsets.only(
                      left: 30.0, top: 20.0, bottom: 20.0),
                  child: new Text(
                    'Manager RT',
                    style: new TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
                new TabBar(
                  indicatorColor: Colors.red,
                  tabs: <Widget>[
                    new Tab(
                      child: Text("Lista RT",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          )),
                    ),
                    new Tab(
                      child: Text("Nuevo",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700)),
                    ),
                  ],
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
          preferredSize: new Size(MediaQuery.of(context).size.width, 112.0),
        ),
        body: new TabBarView(children: <Widget>[
          new ManagerRT_list(),
          new ManagerRT_new(),
        ]),
      ),
    );
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TabController,
    );
  }
}
