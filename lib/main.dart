import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stopwatch Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'stopwatch'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Stream _myStremSec =
      Stream<int>.periodic(const Duration(seconds: 1), (count) {
    print("sono partito Secondi");

    return (count % 60) + 1;
  }); // crea un oggetto che genera un evento ogni 1 secondo
  // l'evento è ritornare count che parte da zero

  final Stream _myStremMin =
      Stream<int>.periodic(const Duration(seconds: 60), (count) {
    print("sono partito Minuti");
    return (count % 60) + 1;
  }); // crea un oggetto che genera un evento ogni 60 secondi
  // l'evento è ritornare count che parte da zero

  final Stream _myStremOre =
      Stream<int>.periodic(const Duration(seconds: 3600), (count) {
    print("sono partito Ore");
    return (count + 1);
  }); // crea un oggetto che genera un evento ogni 3600 secondi
  // l'evento è ritornare count che parte da zero

  late StreamSubscription _subSec;
  late StreamSubscription _subMin;
  late StreamSubscription _subOre;
  String _computationCountSec = ":00";
  String _computationCountMin = ":00";
  String _computationCountOre = "00";

  @override
  void initState() {
    _subSec = _myStremSec.listen((event) {
      setState(() {
        if (event != 60) {
          if (event < 10) {
            _computationCountSec = ":0$event";
          } else {
            _computationCountSec = ":$event";
          }
        } else {
          _computationCountSec = ":00";
        }
        // copio l'evento creato dallo stream in una variabile
      });
    });

    _subMin = _myStremMin.listen((event) {
      setState(() {
        if (event != 60) {
          if (event < 10) {
            _computationCountMin = ":0$event";
          } else {
            _computationCountMin = ":$event";
          }
        } else {
          _computationCountMin = ":00";
        }

        // copio l'evento creato dallo stream in una variabile
      });
    });
    _subOre = _myStremOre.listen((event) {
      setState(() {
        if (event < 10) {
          _computationCountOre = "0$event";
        } else {
          _computationCountOre = event.toString();
        }

        // copio l'evento creato dallo stream in una variabile
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color.fromARGB(204, 242, 236, 236),
        centerTitle: true,
      ),


      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            _computationCountOre.toString(),
            style: const TextStyle(
              fontSize: 70,
              color: Colors.black,
            ),
          ),
          Text(
            _computationCountMin.toString(),
            style: const TextStyle(
              fontSize: 70,
              color: Colors.black,
            ),
          ),
          Text(
            _computationCountSec.toString(),
            style: const TextStyle(
              fontSize: 70,
              color: Colors.black,
            ),
          ),
        ]),

        
      ),

      


      floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.stop,
            size: 30,
            color: Colors.black,
          ),
          onPressed: () => {
                _subSec.pause(),
                _subSec.pause(),
                _subSec.pause(),
              }),
    );
  }
}
