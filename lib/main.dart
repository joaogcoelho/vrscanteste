import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VRScanTest',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> lista = [];
  String scannerInput = "";

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));

    void resetarLista() {
      setState(() {
        lista = [];
      });
    }

    void onKeyRawKeyboardListener(RawKeyEvent keyEvent) {
      if (keyEvent.character != null) {
        setState(() {
          scannerInput += "$keyEvent\n\n";
        });
        if (keyEvent.isKeyPressed(LogicalKeyboardKey.enter)) {
          setState(() {
            lista.add(scannerInput);
            scannerInput = '';
          });
        }
      }
    }

    return RawKeyboardListener(
      autofocus: true,
      focusNode: FocusNode(),
      onKey: onKeyRawKeyboardListener,
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: IconButton(
          color: Colors.orange,
          onPressed: resetarLista,
          icon: const Icon(
            Icons.restore,
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 56,
              ),
              const Text(
                'ESCANEANDO',
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 24,
              ),
              Flexible(
                child: SizedBox(
                  child: ListView.builder(
                    itemCount: lista.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: index == lista.length - 1 ? 80 : 12.0,
                          left: 10,
                          right: 10,
                        ),
                        child: Text(
                          lista[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.orange[400],
                            fontSize: 14,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
