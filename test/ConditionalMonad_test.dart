import 'dart:math';
import 'package:test/test.dart';
import '../lib/src/ConditionalMonad.dart';

main() {
  group('pattern false', () {
    test('false and true', () {
      var monad = ConditionalMonad('foo');
      expect(
        monad.fand((s) => s.length == 0)
             .fand((s) => s.length == 3).run(), false);
    });
    test('always false', () {
      var monad = ConditionalMonad(42);
      expect(
        monad.fand((_) => false).run(), false);
    });
  });

  group('pattern true', () {
    test('true and true', () {
      var monad = ConditionalMonad(42);
      expect(
        monad.fand((i) => i % 2 == 0)
             .fand((i) => i % 3 == 0).run(), true);
    });
    test('always true', () {
      var monad = ConditionalMonad('foo');
      expect(
        monad.fand((_) => true).run(), true);
    });
  });

  group('short circuit', () => shortCircuitTest(seed: null));
}

shortCircuitTest({int seed, int length = 10}) {
  var rand = Random(seed);

  var count = 0;
  var retTrue  = (_) { ++count; return true;  };
  var retFalse = (_) { ++count; return false; };


  var funcs = List.filled(length-1, retTrue, growable: true)
    ..add(retFalse)
    ..shuffle(rand);
    
  var monad = ConditionalMonad(42);
  for(var func in funcs) {
    monad = monad.fand(func);
  }

  
  test('return value', () => expect(monad.run(), false));
  test('side effects', () => expect(count, funcs.indexOf(retFalse)+1));
}