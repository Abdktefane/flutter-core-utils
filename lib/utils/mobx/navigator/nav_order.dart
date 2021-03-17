import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class NavOrder<T> {
  const NavOrder(this.data);

  final T data;
}

class Pop<T> extends NavOrder<T> {
  const Pop(T data) : super(data);
}

class PushPage<T> extends NavOrder<T> {
  const PushPage(T data, {@required this.child}) : super(data);

  final Widget child;
}
