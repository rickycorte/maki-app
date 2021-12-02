
import 'package:flutter/material.dart';

class SimpleEvent {

  List<VoidCallback> listeners = [];

  void add(VoidCallback callback) {
    if(!listeners.contains(callback)) {
      listeners.add(callback);
    }
  }

  void remove(VoidCallback callback) {
    listeners.remove(callback);
  }

  void call() {
    for(var c in listeners) {
      c();
    }
  }

  void clear() {
    listeners.clear();
  }

}