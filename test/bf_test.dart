import 'package:bf_runner/bf.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("hello ", () {
    final program =
        '++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>.';
    final bfi = BFI();
    bfi.program = program;
    bfi.run();
    expect(bfi.out_s, "Hello World!\n");
  });
  test("input", () {
    final program =
        ">,>+++++++++,>+++++++++++[<++++++<++++++<+>>>-]<<.>.<<-.>.>.<<.";
    final bfi = BFI();
    bfi.program = program;
    bfi.input = List.from("\n".codeUnits);
    bfi.run();
    final res = bfi.out_s == "LB\nLB\n" ||
        bfi.out_s == "LK\nLK\n" ||
        bfi.out_s == "LA\nLA\n";
    print(bfi.out_s);
    expect(res, true);
  });

  test("deep bracketts", () {
    final program =
        ",[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>++++++++++++++<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>>+++++[<----->-]<<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>++++++++++++++<-[>+<-[>+<-[>+<-[>+<-[>+<-[>++++++++++++++<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>>+++++[<----->-]<<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>+<-[>++++++++++++++<-[>+<-]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]>.[-]<,]";
    final bfi = BFI();
    bfi.program = program;
    bfi.input = List.from("~mlk zyx".codeUnits);
    bfi.run();
    expect(bfi.out_s, "~zyx mlk");
  });
  test("big enough", () {
    final program =
        "++++[>++++++<-]>[>+++++>+++++++<<-]>>++++<[[>[[>>+<<-]<]>>>-]>-[>+>+<<-]>]+++++[>+++++++<<++>-]>.<<.";
    final bfi = BFI();
    bfi.program = program;
    bfi.run();
    expect(bfi.out_s, "#\n");
  });
  test("Obscure", () {
    final program =
        '[]++++++++++[>>+>+>++++++[<<+<+++>>>-]<<<<-] "A*";?@![#>>+<<]>[>>]<<<<[>++<[-]]>.>.';
    //'[]++++++++++[>>+>+>++++++[<<+<+++>>>-]<<<<-] "A*$";?@![#>>+<<]>[>>]<<<<[>++<[-]]>.>.';
    final bfi = BFI();
    bfi.program = program;
    bfi.run();
    expect(bfi.out_s, "H\n");
  });

  String overflow() {
    var string = "";
    int x;
    x = 1;
    while (x < 256) {
      string += "$x\n";
      x++;
    }
    return string;
  }

  test("overflow", () {
    final program = """ 
Generated by HAC (Headache Awesome Compiler) 
CL
>>>>>>>[-]+KInt
>[-]>[-] <<[>+>+<<-] >>[<<+>>-]<<<[-]>[<+>-][-]>[<+>-]Assign
begin while
<<<<[-]>>>>[-] <<[<<+>>>>+<<-] >>[<<+>>-]CodeCond
<<<<[
CL
>>>>>>>>>>>>>>[-] <<<<<<<<<<<<[>>>>>>+>>>>>>+<<<<<<<<<<<<-] >>>>>>>>>>>>[<<<<<<<<<<<<+>>>>>>>>>>>>-]<<<<<<[<+<+>>-]<>>++++++++++<<[->+>-[>+>>]>[+[-<+>]>+>>]<<<<<<]>>[-]>>>++++++++++<[->-[>+>>]>[+[-<+>]>+>>]<<<<<]>[-]>>[>++++++[-<++++++++>]<.<<+>+>[-]]<[<[->-<]++++++[->++++++++<]>.[-]]<<++++++[-<++++++++>]<.[-]<<[-<+>]<<[>>+<<-]>>[-]<[-]<[-]print byte
<<<<<<<<<<[-]++++++++++.[-]>>>>>>>>>>Printing string
<<<<+Operator
<<[-]>>>>[-] <<[<<+>>>>+<<-] >>[<<+>>-]CodeCond
<<<<
]end while

    """;
    final bfi = BFI();
    bfi.program = program;
    bfi.run();
    expect(bfi.out_s, overflow());
  });
}
