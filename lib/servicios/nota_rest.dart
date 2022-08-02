import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

import '../modelo/nota.dart';

class NotaRest {
  static Stream<List<Nota>> listarStream() async* {
    List<Nota> notas = [];
    // http://158.101.30.194/testcli/examples/oraclevm2/Note/listall
    var url = Uri.http('158.101.30.194', '/testcli/examples/oraclevm2/Note/listall', {});

    //await new Future.delayed(const Duration(seconds : 3));
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var listado = convert.jsonDecode(response.body) as List<dynamic>;
      notas = listado.map((p) => Nota.fromJson(p)).toList();
      yield notas;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  static Future<void> actualizar(Nota nota) async {
    List<Nota> notas = [];
    // http://158.101.30.194/testcli/examples/oraclevm2/Note/listall
    var url = Uri.http('158.101.30.194', '/testcli/examples/oraclevm2/Note/update', {});

    var mapa=nota.toJson();

    await new Future.delayed(const Duration(seconds : 3));
    var response = await http.post(url,body:convert.jsonEncode(mapa) );
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

    await new Future.delayed(const Duration(seconds : 5));
    var response = await http.post(url,body:convert.jsonEncode(mapa) );
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

    //await new Future.delayed(const Duration(seconds : 3));
    var response = await http.get(url);
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

    //await new Future.delayed(const Duration(seconds : 3));
    var response = await http.get(url);
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

    //await new Future.delayed(const Duration(seconds : 3));
    var response = await http.get(url);
    if (response.statusCode == 200) {
      nota = int.parse(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return nota;
  }
}