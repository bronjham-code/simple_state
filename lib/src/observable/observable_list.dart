import 'dart:math';

import 'package:easy_state/src/observable/observable.dart';

class ObservableList<T> extends Observable<List<T>> implements List<T> {
  ObservableList(List<T> value) : super(value);

  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  void _notify() => super.notifyListeners();

  @override
  T get first => super.value.first;

  @override
  T get last => super.value.last;

  @override
  int get length => super.value.length;

  @override
  List<T> operator +(List<T> other) {
    super.value = super.value + other;
    _notify();

    return super.value;
  }

  @override
  T operator [](int index) => super.value[index];

  @override
  void operator []=(int index, T value) {
    super.value[index] = value;
    _notify();
  }

  @override
  void add(T value) {
    super.value.add(value);
    _notify();
  }

  @override
  void addAll(Iterable<T> iterable) {
    super.value.addAll(iterable);
    _notify();
  }

  @override
  bool any(bool Function(T element) test) => super.value.any(test);

  @override
  Map<int, T> asMap() => super.value.asMap();

  @override
  List<R> cast<R>() => super.value.cast<R>();

  @override
  void clear() {
    super.value.clear();
    _notify();
  }

  @override
  bool contains(Object? element) => super.value.contains(element);

  @override
  T elementAt(int index) => super.value.elementAt(index);

  @override
  bool every(bool Function(T element) test) => super.value.every(test);

  @override
  Iterable<E> expand<E>(Iterable<E> Function(T element) toElements) => super.value.expand(toElements);

  @override
  void fillRange(int start, int end, [T? fillValue]) {
    super.value.fillRange(start, end, fillValue);
    _notify();
  }

  @override
  T firstWhere(bool Function(T element) test, {T Function()? orElse}) => super.value.firstWhere(test, orElse: orElse);

  @override
  E fold<E>(E initialValue, E Function(E previousValue, T element) combine) => super.value.fold(initialValue, combine);

  @override
  Iterable<T> followedBy(Iterable<T> other) => super.value.followedBy(other);

  @override
  void forEach(void Function(T element) action) => super.value.forEach(action);

  @override
  Iterable<T> getRange(int start, int end) => super.value.getRange(start, end);

  @override
  int indexOf(T element, [int start = 0]) => super.value.indexOf(element, start);

  @override
  int indexWhere(bool Function(T element) test, [int start = 0]) => super.value.indexWhere(test, start);

  @override
  void insert(int index, T element) {
    super.value.insert(index, element);
    _notify();
  }

  @override
  void insertAll(int index, Iterable<T> iterable) {
    super.value.insertAll(index, iterable);
    _notify();
  }

  @override
  bool get isEmpty => super.value.isEmpty;

  @override
  bool get isNotEmpty => super.value.isNotEmpty;

  @override
  Iterator<T> get iterator => super.value.iterator;

  @override
  String join([String separator = ""]) => super.value.join(separator);

  @override
  int lastIndexOf(T element, [int? start]) => super.value.lastIndexOf(element, start);

  @override
  int lastIndexWhere(bool Function(T element) test, [int? start]) => super.value.lastIndexWhere(test, start);

  @override
  T lastWhere(bool Function(T element) test, {T Function()? orElse}) => super.value.lastWhere(test, orElse: orElse);

  @override
  Iterable<E> map<E>(E Function(T e) toElement) => super.value.map(toElement);

  @override
  T reduce(T Function(T value, T element) combine) => super.value.reduce(combine);

  @override
  bool remove(Object? value) {
    final isRemoved = super.value.remove(value);
    if (isRemoved) {
      _notify();
    }

    return isRemoved;
  }

  @override
  T removeAt(int index) {
    final beforeLength = super.value.length;
    final removeAt = super.value.removeAt(index);
    final afterLength = super.value.length;

    if (beforeLength != afterLength) {
      _notify();
    }

    return removeAt;
  }

  @override
  T removeLast() {
    final beforeLength = super.value.length;
    final removeLast = super.value.removeLast();
    final afterLength = super.value.length;

    if (beforeLength != afterLength) {
      _notify();
    }

    return removeLast;
  }

  @override
  void removeRange(int start, int end) {
    super.value.removeRange(start, end);
    _notify();
  }

  @override
  void removeWhere(bool Function(T element) test) {
    super.value.removeWhere(test);
    _notify();
  }

  @override
  void replaceRange(int start, int end, Iterable<T> replacements) {
    super.value.replaceRange(start, end, replacements);
    _notify();
  }

  @override
  void retainWhere(bool Function(T element) test) {
    super.value.retainWhere(test);
    _notify();
  }

  @override
  Iterable<T> get reversed => super.value.reversed;

  @override
  void setAll(int index, Iterable<T> iterable) {
    super.value.setAll(index, iterable);
    _notify();
  }

  @override
  void setRange(int start, int end, Iterable<T> iterable, [int skipCount = 0]) {
    super.value.setRange(start, end, iterable, skipCount);
    _notify();
  }

  @override
  void shuffle([Random? random]) {
    super.value.shuffle(random);
    _notify();
  }

  @override
  T get single => super.value.single;

  @override
  T singleWhere(bool Function(T element) test, {T Function()? orElse}) => super.value.singleWhere(test, orElse: orElse);

  @override
  Iterable<T> skip(int count) => super.value.skip(count);

  @override
  Iterable<T> skipWhile(bool Function(T value) test) => super.value.skipWhile(test);

  @override
  void sort([int Function(T a, T b)? compare]) {
    super.value.sort();
    _notify();
  }

  @override
  List<T> sublist(int start, [int? end]) => super.value.sublist(start, end);

  @override
  Iterable<T> take(int count) => super.value.take(count);

  @override
  Iterable<T> takeWhile(bool Function(T value) test) => super.value.takeWhile(test);

  @override
  List<T> toList({bool growable = true}) => super.value.toList(growable: growable);

  @override
  Set<T> toSet() => super.value.toSet();

  @override
  Iterable<T> where(bool Function(T element) test) => super.value.where(test);

  @override
  Iterable<E> whereType<E>() => super.value.whereType<E>();

  @override
  set first(T value) => super.value.first;

  @override
  set last(T value) => super.value.last;

  @override
  set length(int newLength) => value.length;

  @override
  List<T> get value => this;
}
