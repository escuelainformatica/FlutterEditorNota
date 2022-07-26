import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';

import '../modelo/nota.dart';
import '../paginas/pagina_actualizar.dart';
import '../paginas/pagina_listado.dart';
import '../servicios/nota_rest.dart';

class FilaNota extends StatefulWidget {
  Nota nota;
  //PaginaListadoEstado paginaEstado;
  Function actualizar;

  FilaNota(this.nota,this.actualizar, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FilaNota();
  }

}
class _FilaNota extends State<FilaNota> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PaginaActualizar(widget.nota.idNote??0)),
          );
          widget.actualizar();
        },
        child: Card(
          child: ListTile(
              leading: Text("${widget.nota.idNote}"),
               title: Text("${widget.nota.title}"),
              subtitle: Text("${widget.nota.description}"),
            trailing: ElevatedButton(onPressed: () async {
              bool confirmacion= await confirm(
                context,
                title: const Text('Confirm'),
                content: const Text('Would you like to remove?'),
                textOK: const Text('Yes'),
                textCancel: const Text('No'),
              );
              if(confirmacion) {
                int idNote = widget.nota.idNote ?? 0;

                await NotaRest.borrarFuture(idNote);
                widget.actualizar();
              }
            }, child: Text("borrar")
            ),
          ),
        )
    );
  }

}