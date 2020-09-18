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
              child: Container(
                height: 300,
                child: TextField(
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
                ),
              ),
            ),
            Text('$_output', style: Theme.of(context).textTheme.headline5)
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
