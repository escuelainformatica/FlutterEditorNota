import 'package:flutter/material.dart';

import '../paginas/pagina_insertar.dart';

class BotonesNota extends StatefulWidget {
  Function actualizar;

  BotonesNota(this.actualizar, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BotonesNota();
  }
}
class _BotonesNota extends State<BotonesNota> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (numboton) async {
        if (numboton == 0) {
          //sc.sink.add([]);
          widget.actualizar();
        }
        if (numboton == 1) {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PaginaInsertar()),
          );
          widget.actualizar();
        }
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.refresh), label: "refrescar"),
        BottomNavigationBarItem(
            icon: Icon(Icons.add), label: "agregar"),
        BottomNavigationBarItem(
            icon: Icon(Icons.abc_sharp), label: "boton3"),
      ],
    );
  }

}