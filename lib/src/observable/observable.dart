import 'package:flutter/foundation.dart';

class Observable<T> extends ValueNotifier<T> {
  Observable(T value) : super(value);
}
