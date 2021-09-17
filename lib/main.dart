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
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _output = "";
  String _program =
      "++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.";

  void _run() {
    var bfi = BFI();
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
    var textField = TextField(
      inputFormatters: [],
      obscureText: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Brainfuck Code",
        helperMaxLines: 10,
      ),
      maxLines: 10,
      minLines: 1,
      onChanged: (value) {
        _program = value;
      },
      maxLength: 10000,
      onSubmitted: (String value) {
        print(value);
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
                child: codeField,
              ),
              Expanded(
                  child: Container(
                color: Colors.white,
                child: Text('$_output',
                    style: Theme.of(context).textTheme.headline5),
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
