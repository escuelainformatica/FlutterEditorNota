import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:untitled12/modelo/user.dart';


class UsuarioRest {

  static Future<void> actualizar(User user) async {

    // http://158.101.30.194/testcli/examples/oraclevm2/api/User/createauth
    var url = Uri.http('158.101.30.194', '/testcli/examples/oraclevm2/api/User/createauth', {});

    var mapa=user.toJson();
    //await new Future.delayed(const Duration(seconds : 3));
    var response = await http.post(url,body:convert.jsonEncode(mapa) );
    if (response.statusCode == 200) {
      var listado = convert.jsonDecode(response.body) as int;
      print("el resultado es $listado");
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

}