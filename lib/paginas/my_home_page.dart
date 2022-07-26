import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  StreamController<String> sc=StreamController<String>.broadcast();

  bool ejecutar=true;

  Stream<String> actualizarHora() async* {
    String string = "";
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    string = dateFormat.format(DateTime.now());
    await Future.delayed(Duration(seconds: 1));
    if(ejecutar) {
      yield string;
    }
  }

  @override
  void initState() {
    super.initState();
    sc.addStream(actualizarHora());
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          StreamBuilder<String>(
            stream: sc.stream,
            builder: (context, snap) {
              if(snap.connectionState==ConnectionState.done || snap.connectionState==ConnectionState.active) {
                return Text("${snap.requireData} estado: ${snap.connectionState}");
              }
              return Text("todavia no hay datos");
            },
          ),
          ElevatedButton(onPressed: () {
            sc.sink.addStream(actualizarHora()); // yield
            //sc.sink.add("se hizo click"); // yield
          }, child: Text("sink llamar funcion asincronica otra vez")),
          ElevatedButton(onPressed: () {
            sc.sink.add("se hizo click"); // yield
          }, child: Text("sink enviar dato fijo"))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
