import 'package:flutter/material.dart';
import 'package:untitled12/servicios/nota_rest.dart';

import '../modelo/nota.dart';

class PaginaInsertar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
   return _PaginaInsertar();
  }
}
class _PaginaInsertar extends State<PaginaInsertar> {

  TextEditingController c2=TextEditingController();
  TextEditingController c3=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(title: Text("listado")),
        body: Form(
          child:
          Column(
            children: [

              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Id',
                  labelText: 'Id',
                ),
                controller: c2,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Id',
                  labelText: 'Id',
                ),
                controller: c3,
              ),
              ElevatedButton(onPressed: () async {
                Nota nota=Nota(idNote: 0,title:  c2.text,description:  c3.text);
                await NotaRest.insertar(nota);
                Navigator.pop(context);
              }, child: Text("insertar"))
            ],
          ),
        )
    );
  }

}