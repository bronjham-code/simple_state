import 'package:flutter/foundation.dart';

/// Creates a observable simple value that wraps this value.
class Observable<T> extends ValueNotifier<T> {
  /// Creates a observable that wraps this value.
  Observable(T value) : super(value);
}
