class ConditionalMonad<T> {
  T    _wrapped;
  bool _tf = true;

  ConditionalMonad(this._wrapped);

  ConditionalMonad<T> fand(bool Function(T) cond) {
    this._tf = this._tf && cond(this._wrapped);
    return this;
  }
  bool run() {
    return this._tf;
  }

  @override
  String toString() {
    return 'ConditionalMonad<$T> {$_wrapped}';
  }
}
