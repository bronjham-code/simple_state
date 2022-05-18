import 'package:flutter/material.dart';
import 'package:simple_state/simple_state.dart';

extension ObservableExtensions<T> on Observable<T> {
  Reaction when(
    bool Function(Observable<T> observable) condition,
    VoidCallback reaction,
  ) =>
      Reaction.when(
        listenables: [this],
        condition: () => condition(this),
        reaction: reaction,
      );
}

extension ObservableListExtensions<T> on ObservableList<T> {
  Reaction when(
    bool Function(ObservableList<T> observable) condition,
    VoidCallback reaction,
  ) =>
      Reaction.when(
        listenables: [this],
        condition: () => condition(this),
        reaction: reaction,
      );
}

extension ObservableSetExtensions<T> on ObservableSet<T> {
  Reaction when(
    bool Function(ObservableSet<T> observable) condition,
    VoidCallback reaction,
  ) =>
      Reaction.when(
        listenables: [this],
        condition: () => condition(this),
        reaction: reaction,
      );
}

extension ObservableMapExtensions<K, V> on ObservableMap<K, V> {
  Reaction when(
    bool Function(ObservableMap<K, V> observable) condition,
    VoidCallback reaction,
  ) =>
      Reaction.when(
        listenables: [this],
        condition: () => condition(this),
        reaction: reaction,
      );
}
