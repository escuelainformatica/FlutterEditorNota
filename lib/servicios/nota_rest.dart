import 'dart:convert' as convert;
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:untitled12/configuracion.dart';

import '../modelo/nota.dart';

class NotaRest {

  static Future<File> get _localFile async {
    Directory ruta=await getApplicationDocumentsDirectory();
    String path = ruta.path;
    return File('$path/notas.json');
  }

  static Stream<List<Nota>> listarStream() async* {




    List<Nota> notas = [];
    // http://158.101.30.194/testcli/examples/oraclevm2/Note/listall
    var url = Uri.http('158.101.30.194', '/testcli/examples/oraclevm2/Note/listall', {});

    Map<String,String> encabezado={'token':Configuracion.token??''};
    //await new Future.delayed(const Duration(seconds : 3));
    late http.Response response;
    bool falla=false;
    try {
      response = await http.get(url, headers: encabezado);
      if (response.statusCode == 200) {
        // guardar los datos
        File archivo=await _localFile;
        archivo.writeAsString(response.body);
        var listado = convert.jsonDecode(response.body) as List<dynamic>;
        notas = listado.map((p) => Nota.fromJson(p)).toList();
        yield notas;
      } else {
        falla=true;

      }
    } catch(ex) {
      falla=true;
    }
    if(falla) {
      // leer los datos guardados antes
      File archivo=await _localFile;
      String contenido=await archivo.readAsString();
      var listado = convert.jsonDecode(contenido) as List<dynamic>;
      notas = listado.map((p) => Nota.fromJson(p)).toList();
    }

  }

  static Future<void> actualizar(Nota nota) async {
    List<Nota> notas = [];
    // http://158.101.30.194/testcli/examples/oraclevm2/Note/listall
    var url = Uri.http('158.101.30.194', '/testcli/examples/oraclevm2/Note/update', {});

    var mapa=nota.toJson();
    Map<String,String> encabezado={'token':Configuracion.token??''};
    await new Future.delayed(const Duration(seconds : 3));
    var response = await http.post(url,body:convert.jsonEncode(mapa),headers: encabezado );
    if (response.statusCode == 200) {
      var listado = convert.jsonDecode(response.body) as int;
      print("el resultado es $listado");
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
  static Future<void> insertar(Nota nota) async {
    List<Nota> notas = [];
    // http://158.101.30.194/testcli/examples/oraclevm2/Note/listall
    var url = Uri.http('158.101.30.194', '/testcli/examples/oraclevm2/Note/insert', {});

    var mapa=nota.toJson();
    Map<String,String> encabezado={'token':Configuracion.token??''};

    await new Future.delayed(const Duration(seconds : 5));
    var response = await http.post(url,body:convert.jsonEncode(mapa),headers: encabezado );
    if (response.statusCode == 200) {
      var listado = convert.jsonDecode(response.body) as int;
      print("el resultado es $listado");
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  static Stream<Nota> obtenerStream(int id) async* {
    Nota nota = Nota();
    // http://158.101.30.194/testcli/examples/oraclevm2/Note/get/1
    var url = Uri.http('158.101.30.194', '/testcli/examples/oraclevm2/Note/get/$id', {});
    Map<String,String> encabezado={'token':Configuracion.token??''};
    //await new Future.delayed(const Duration(seconds : 3));
    var response = await http.get(url,headers: encabezado);
    if (response.statusCode == 200) {
      var mapaRespuesta = convert.jsonDecode(response.body) as Map<String, dynamic>;
      nota = Nota.fromJson(mapaRespuesta);
      yield nota;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
  static Future<Nota> obtenerFuture(int id) async {
    Nota nota = Nota();
    // http://158.101.30.194/testcli/examples/oraclevm2/Note/get/1
    var url = Uri.http('158.101.30.194', '/testcli/examples/oraclevm2/Note/get/$id', {});
    Map<String,String> encabezado={'token':Configuracion.token??''};
    //await new Future.delayed(const Duration(seconds : 3));
    var response = await http.get(url,headers: encabezado);
    if (response.statusCode == 200) {
      var mapaRespuesta = convert.jsonDecode(response.body) as Map<String, dynamic>;
      nota = Nota.fromJson(mapaRespuesta);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return nota;
  }
  static Future<int> borrarFuture(int id) async {
    int nota = 0;
    // http://158.101.30.194/testcli/examples/oraclevm2/Note/delete/1
    var url = Uri.http('158.101.30.194', '/testcli/examples/oraclevm2/Note/delete/$id', {});
    Map<String,String> encabezado={'token':Configuracion.token??''};
    //await new Future.delayed(const Duration(seconds : 3));
    var response = await http.get(url,headers: encabezado);
    if (response.statusCode == 200) {
      nota = int.parse(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return nota;
  }
}