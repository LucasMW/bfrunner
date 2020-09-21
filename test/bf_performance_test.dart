import 'package:bf_runner/bf.dart';
import 'package:flutter_test/flutter_test.dart';

import 'assets/bf_assets.dart';

void main() {
  String factor(int n) {
    var str = "$n:";
    var x = n;
    var i = 2;
    while (x > 1) {
      if (x % i == 0) {
        str += " $i";
        x = x ~/ i;
        i = 1;
      }
      i++;
    }
    str += "\n";
    return str;
  }

  test("factor ", () async {
    final program = BFAssets.factorBF();
    print(program);

    final bfi = BFI();
    final inputNumber = 10;
    final factors = factor(inputNumber);
    print(factors);
    bfi.input = List.from("$inputNumber\n".codeUnits);
    bfi.program = program;
    bfi.run();
    //expect(bfi.out_s, "$inputNumber: 2 5\n");
    expect(bfi.out_s, factors);
  });
  test("prime ", () {
    final program = BFAssets.primeBF();
    final bfi = BFI();
    bfi.program = program;
    bfi.input = List.from("10\n".codeUnits);
    bfi.run();
    expect(bfi.out_s, "Primes up to: 2 3 5 7 \n");
  });
}
