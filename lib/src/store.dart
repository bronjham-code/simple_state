import 'package:flutter/foundation.dart';
import 'package:simple_state/src/observable/observable.dart';

// Store allows you to subscribe without explicitly specifying
class Store {
  Store._();

  static late final Store _instance = Store._();

  static Store get instance => _instance;

  final _mounting = <MountCallback>[];

  /// Start building
  void beginBuild(MountCallback callback) => _mounting.add(callback);

  /// End building
  void endBuild(MountCallback callback) => _mounting.remove(callback);

  void reportRead(ObservableBase observable) {
    final mount = _mounting.lastOrNull;

    if (mount == null) {
      return;
    }

    mount.call(observable);
  }
}

/// Signature of the mount
typedef MountCallback = void Function(Listenable listenable);
