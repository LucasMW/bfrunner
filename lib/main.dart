import 'package:flutter/material.dart';
import 'bf.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:highlight/languages/brainfuck.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BF IDE 2 | Full Fledged BF IDE',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Brainfuck IDE 2'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _output = "";
  String _program =
      "++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.";
  BFI bfi = BFI(shouldWaitInput: true);

  void _run() {
    bfi = BFI(shouldWaitInput: true);
    bfi.program = _program;
    bfi.run();
    setState(() {
      _output = bfi.out_s;
    });
  }

  @override
  Widget build(BuildContext context) {
    final codeController = CodeController(
        language: brainfuck,
        text: _program,
        theme: monokaiSublimeTheme,
        onChange: (value) {
          _program = value;
        });
    var codeField = CodeField(controller: codeController, wrap: true);
    final inputController = TextEditingController();
    final inputField = TextField(
      controller: inputController,
      inputFormatters: [],
      obscureText: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Input",
        helperMaxLines: 2,
      ),
      maxLines: 2,
      minLines: 1,
      onChanged: (value) {
        if (value.contains("\n")) {
          final chars = value.split("\n").first + "\n";
          print("submitted $chars");
          bfi.receiveInput(chars);
          inputController.clear();
          setState(() {});
          bfi.run();
          setState(() {
            _output = bfi.out_s;
          });
          return;
        }
      },
      maxLength: 10000,
      onSubmitted: (String value) {
        print("submitted");
        bfi.receiveInput(value);
        bfi.run();
        setState(() {
          _output = bfi.out_s;
        });
      },
    );
    final textField = TextField(
      controller: TextEditingController(),
      inputFormatters: [],
      obscureText: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Brainfuck Code",
        helperMaxLines: 10,
      ),
      maxLines: 1000,
      minLines: 1,
      onChanged: (value) {
        _program = value;
      },
      maxLength: 1000000,
      onSubmitted: (String value) {
        _program = value;
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 1,
                  child: SingleChildScrollView(
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height * 5,
                        child: codeField),
                  ),
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                controller:
                    ScrollController(), //https://stackoverflow.com/questions/69883594/flutter-linuix-the-provided-scrollcontroller-is-currently-attached-to-more-than
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.white,
                        child: Text('$_output',
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.headline5),
                      ),
                    ),
                    bfi.waitingInput
                        ? Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: inputField,
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _run,
        tooltip: 'Play!',
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
