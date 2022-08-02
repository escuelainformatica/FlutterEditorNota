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

  bool botonHabilitado=true;
  TextEditingController c2 = TextEditingController();
  TextEditingController c3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("listado")),
        body: Form(
          child: Column(
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
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: botonHabilitado?  MaterialStateProperty.all(Colors.blue) :  MaterialStateProperty.all(Colors.black12),
                ),
                  onPressed: () async {
                    if(botonHabilitado) {
                      setState(() {
                        botonHabilitado = false;
                      });
                      Nota nota = Nota(idNote: 0, title: c2.text, description: c3.text);
                      await NotaRest.insertar(nota);
                      if(mounted) {
                        // cuando la pagina esta montada
                        Navigator.pop(context);
                      }

                    }
                  },
                  child:botonHabilitado ? Text("insertar") :  Image.asset("assets/loading-gif.gif",width: 32,height: 32,) )
            ],
          ),
        ));
  }
}
