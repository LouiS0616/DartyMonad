# DartyMonad

My ~~dirty~~ darty implementations of Monads.

# Monads

## ConditionalMonad\<T\>

You can write short-circuit evaluational snipet like below.

```dart
var tf = ConditionalMonad(42)
  .fand((i) => i % 2 == 0)    // true, it's evaluated.
  .fand((i) => i % 3 == 0)    // true, it's evaluated.
  .fand((i) => i % 4 == 0)    // false, it's evaluated.
  .fand((_) => true)          // Of course true, but it's NEVER evaluated.
  .run()
;
print(tf);    // => false
```

You may think it is too redundant.\
Right, we can write similar code just by using && operator.

```dart
var tf = ((int i) => 
     (i % 2 == 0)    // true, it's evaluated.
  && (i % 3 == 0)    // true, it's evaluated.
  && (i % 4 == 0)    // false, it's evaluated.
  && true            // Of course true, but it's NEVER evaluated.
)(42);
print(tf);    // => false
```

ConditionalMonad has advantage if it is used as argument.

```dart
doSomething(ConditionalMonad<int> Function(int) makeMonad) {
  var tf = makeMonad(42).run();     // short-circuit is guaranteed.
  print(tf);
}
```

# License

MIT

# Auther

Loui Sakaki