import 'package:flutter/material.dart';
import 'bf.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Easy Brainfuck Runner'),
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
  int _counter = 0;
  String _output = "";
  String _program =
      "++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.";

  void _run() {
    setState(() {
      _counter++;
      var bfi = BFI();
      bfi.program = _program;
      bfi.run();
      _output = bfi.out_s;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SingleChildScrollView(
              child: TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Program',
                  helperMaxLines: 10,
                ),
                maxLines: 100,
                minLines: 1,
                onChanged: (value) {
                  _program = value;
                },
                maxLength: 1000,
                onSubmitted: (String value) {
                  print(value);
                  _program = value;
                },
              ),
            ),
            Text(
              'You have executed brainfuck code this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text('$_output', style: Theme.of(context).textTheme.headline3)
          ],
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
