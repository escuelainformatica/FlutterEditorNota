import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled12/configuracion.dart';
import 'package:untitled12/modelo/user.dart';
import 'package:untitled12/paginas/pagina_listado.dart';
import 'package:untitled12/servicios/usuario_rest.dart';
import 'dart:convert' as convert;

class PaginaLogin extends StatefulWidget {
  const PaginaLogin({Key? key}) : super(key: key);

  @override
  _PaginaLoginState createState() => _PaginaLoginState();
}

class _PaginaLoginState extends State<PaginaLogin> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController cUser=TextEditingController();
  TextEditingController cClave=TextEditingController();
  String mensaje="";

  @override
  void initState() {
    super.initState();
    cargarUsuario();
  }
  cargarUsuario() async {
    final SharedPreferences prefs = await _prefs;
    var mapa=convert.jsonDecode( prefs.getString("usuario")??"null");
    if(mapa!=null) {
      Configuracion.user= User.fromJson(mapa);
      Configuracion.token=await UsuarioRest.obtenerToken(Configuracion.user!);
      if(Configuracion.token!="") {
        if(mounted) {
          await Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => PaginaListado()),);
        }
      } else {
        setState(() {
          mensaje="Usuario o clave incorrecto";
        });
      }

    } else {
      Configuracion.user= null;
    }
  }
  guardarUsuario() async {
    final SharedPreferences prefs = await _prefs;
    if(Configuracion.user==null) {
      return;
    }
    String json=convert.jsonEncode(Configuracion.user!.toJson());
    prefs.setString("usuario", json);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(controller: cUser),
          TextFormField(controller: cClave),
          ElevatedButton(onPressed: () async {
            // 1) guardar el token OK
            // 2) utilizar el token
            // 3)

            // 1) crear un objeto del tipo usuario
            Configuracion.user=User(cUser.text,cClave.text,"");
            // 2) validarlo.
            Configuracion.token=await UsuarioRest.obtenerToken(Configuracion.user!);
            // 3) si la validacion es correcta (si hay un token no vacio), entonces navegar a la pagina de listado
            // 4) en caso contrario mostrar un mensaje
            if(Configuracion.token!="") {
              await guardarUsuario();
              if(mounted) {
                await Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => PaginaListado()),);
              }
            } else {
              setState(() {
                mensaje="Usuario o clave incorrecto";
              });
            }

          }, child: Text("login")),
          Text(mensaje,style: TextStyle(color: Colors.red),)
        ],
      ),
    );
  }
}
