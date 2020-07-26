import 'dart:typed_data';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';

class BFI {
  var program = "";
  var memory = Int8List(30000);
  var mem_idx = 0;
  var prog_idx = 0;
  var out_s = "";
  var out = List<int>();
  var loopStack = List<int>();
  var loopIdx = 0;
  void run() {
    var cmds =
        ['>', '<', '+', '-', '.', ',', '[', ']'].map((e) => e.codeUnitAt(0));
    // print(program);
    // program =
    //   "-[-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.";
    while (prog_idx < program.length) {
      var cmd = String.fromCharCode(program.codeUnitAt(prog_idx));
      print('cmd: $cmd prog_idx $prog_idx');
      switch ('$cmd') {
        case '<':
          mem_idx--;
          if (mem_idx < 0) print("ERROR: There is no cell -1");
          break;
        case '>':
          mem_idx++;
          break;
        case '+':
          memory[mem_idx]++;
          if (memory[mem_idx] > 255) memory[mem_idx] = 0;
          break;
        case '-':
          memory[mem_idx]--;
          if (memory[mem_idx] < 0) memory[mem_idx] = 255;
          break;
        case '.':
          print(memory[mem_idx]);
          out.add(memory[mem_idx]);
          out_s += String.fromCharCode(memory[mem_idx]);
          //print(String.fromCharCode(memory[mem_idx]));
          break;
        case '[':
          if (memory[mem_idx] == 0) {
            skipWhile();
          } else {
            loopStack.add(prog_idx);
          }
          break;
        case ']':
          if (memory[mem_idx] == 0) {
            loopStack.removeLast();
          } else {
            loopIdx = loopStack[loopStack.length - 1];
            prog_idx = loopIdx;
          }
          break;
      }
      prog_idx++;
    }
    out.add(0);
    print(out);

    var str = convert.utf8.decode(out, allowMalformed: true);

    print("str: $str");
    print("out_s $out_s");
    var encoded =
        convert.utf8.encode('Lorem ipsum dolor sit amet, consetetur...');
    var decoded = convert.utf8.decode(encoded);
    print(decoded);
  }

  String charAtIndex(String str, int index) {
    var cmd = String.fromCharCode(program.codeUnitAt(prog_idx));
    return cmd;
  }

  void skipWhile() {
    print("skip while");
    prog_idx++;
    var internalLoopCount = 0;
    // while not match stop requirements
    var cmd = String.fromCharCode(program.codeUnitAt(prog_idx));
    while (!(cmd == ']' && internalLoopCount == 0)) {
      print(prog_idx);
      if (cmd == '[') {
        internalLoopCount++;
      } else if (cmd == ']') {
        internalLoopCount--;
      }
      prog_idx++;
      cmd = String.fromCharCode(program.codeUnitAt(prog_idx));
    }
  }
}
