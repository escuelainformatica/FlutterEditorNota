import 'package:flutter/material.dart';
import 'package:untitled12/servicios/nota_rest.dart';

import '../modelo/nota.dart';

class PaginaActualizar extends StatefulWidget {

  int numNota;

  PaginaActualizar(this.numNota, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
   return _PaginaActualizar();
  }
}
class _PaginaActualizar extends State<PaginaActualizar> {

  TextEditingController c2=TextEditingController();
  TextEditingController c3=TextEditingController();
  int numNota=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cargarNota();

  }
  void cargarNota() async {
    Nota nota=await NotaRest.obtenerFuture(widget.numNota);
    numNota=nota.idNote??0;
    c2.text=nota.title??"sin titulo";
    c3.text=nota.description??"sin descripcion";
  }

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
                Nota nota=Nota(idNote: numNota,title:  c2.text,description:  c3.text);
                await NotaRest.actualizar(nota);
                Navigator.pop(context);
              }, child: Text("Actualizar"))
            ],
          ),
        )
    );
  }

}