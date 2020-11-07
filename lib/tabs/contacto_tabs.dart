import 'package:flutter/material.dart';

class ContactosTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        children: <Widget>[
          // agregamos una imagen
          new Container(
            margin: const EdgeInsets.all(10.0), //margenes por todos los lados
            width: 350.0, //ancho de la imagen
            height: 350.0, //largo de la imagen
            decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: new AssetImage("assets/images/i.jpg"),
                  fit: BoxFit.cover),
            ),
          ),
          // agregamos un boton con alguna acción
          new Container(
            margin: const EdgeInsets.only(top: 390.0, left: 25.0),
            child: new RaisedButton(
              padding: const EdgeInsets.only(
                  top: 20.0, left: 100, right: 100, bottom: 20),
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () {
                // click del boton cuando se presiona
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text('Hola Contactos')));
              },
              child: new Text("Presiona aquí"),
            ),
          )
        ],
      ),
    );
  }
}
