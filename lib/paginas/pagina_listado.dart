import 'dart:async';

import 'package:flutter/material.dart';
import 'package:untitled12/botones/botones_nota.dart';
import 'package:untitled12/filas/fila_nota.dart';
import 'package:untitled12/paginas/pagina_insertar.dart';
import 'package:untitled12/servicios/nota_rest.dart';

import '../modelo/nota.dart';

class PaginaListado extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PaginaListadoEstado();
  }
}

class PaginaListadoEstado extends State<PaginaListado> {
  StreamController<List<Nota>> sc = StreamController.broadcast();

  @override
  void initState() {
    super.initState();
    sc.addStream(NotaRest.listarStream());
  }

  void actualizar() {
    sc.sink.addStream(NotaRest.listarStream());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("listado")),
      body: StreamBuilder<List<Nota>>(
        stream: sc.stream,
        builder: (context, snap) {
          if (snap.hasData) {
            return GestureDetector(
              onDoubleTap: () {
                // actualizar.
                sc.sink.add([]);
                actualizar();
              },
              child: ListView.builder(
                itemCount: snap.requireData.length,
                itemBuilder: (context, fila) {
                  return FilaNota(snap.requireData[fila], actualizar);
                },
              ),
            );
          }
          return const Text("no hay datos");
        },
      ),
      bottomNavigationBar: BotonesNota(actualizar)
    );
  }
}
