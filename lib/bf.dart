import 'dart:io';
import 'dart:typed_data';
import 'dart:convert' as convert;

class BFI {
  final bool shouldWaitInput;
  bool paused = false;

  var program = "";
  var memory = Uint8List(30000);
  // ignore: non_constant_identifier_names
  var mem_idx = 0;
  // ignore: non_constant_identifier_names
  var prog_idx = 0;

  // ignore: non_constant_identifier_names
  var out_s = "";
  var out = <int>[];
  var err_s = "";

  // ignore: non_constant_identifier_names
  var input_s = "";
  var input = <int>[];

  var loopStack = <int>[];
  var loopIdx = 0;

  BFI({this.shouldWaitInput});
  void run() {
    while (prog_idx < program.length) {
      var cmd = String.fromCharCode(program.codeUnitAt(prog_idx));
      //print('cmd: $cmd prog_idx $prog_idx');
      switch ('$cmd') {
        case '<':
          mem_idx--;
          if (mem_idx < 0) print("ERROR: There is no cell -1");
          break;
        case '>':
          mem_idx++;
          break;
        case '+':
          if (memory[mem_idx] > 254)
            memory[mem_idx] = 0;
          else
            memory[mem_idx]++;
          break;
        case '-':
          memory[mem_idx]--;
          if (memory[mem_idx] < 0) memory[mem_idx] = 255;
          break;
        case ',':
          if (input.length > 0) {
            memory[mem_idx] = input.removeAt(0);
          } else {
            if (shouldWaitInput == true) {
              return; //the idea is to keep going after input, by calling run again;
            } else {
              memory[mem_idx] = 0;
            }
          }
          break;
        case '.':
          out.add(memory[mem_idx]);
          out_s += String.fromCharCode(memory[mem_idx]);
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
  }

  String charAtIndex(String str, int index) {
    var cmd = String.fromCharCode(program.codeUnitAt(prog_idx));
    return cmd;
  }

  void skipWhile() {
    prog_idx++;
    var internalLoopCount = 0;
    var cmd = String.fromCharCode(program.codeUnitAt(prog_idx));
    // while not match stop requirements
    while (!(cmd == ']' && internalLoopCount == 0)) {
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
