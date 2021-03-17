import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';
import 'package:core_sdk/data/viewmodels/mobx_provider.dart';
import 'package:core_sdk/utils/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  //* THEME STUFF *//
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;

  //* Locale stuff *//
  AppLocalizations get locale => AppLocalizations.of(this);
  String translate(String key) => locale.translate(key) ?? key;

  //* Media query stuff *//
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double get fullWidth => mediaQuery.size.width;
  double get fullHeight => mediaQuery.size.height;

  //* MOBX STUFF *//
  T mobx<T extends BaseViewmodel>() => InheritedMobxWidget.of<T>(this);

  //* Navigate stuff *//
  NavigatorState get navigator => Navigator.of(this);
  void pop<T extends Object>([T result]) => navigator.pop<T>(result);

  void popUntil({numberOfPages = 1}) {
    int count = 0;
    navigator.popUntil((_) => count++ == numberOfPages);
  }

  Future<T> pushNamed<T extends Object>(
    String routeName, {
    Object arguments,
  }) =>
      navigator.pushNamed<T>(routeName, arguments: arguments);

  Future<T> pushPage<T extends Object>(Widget widget) => navigator.push<T>(MaterialPageRoute(builder: (_) => widget));

  Future<T> cupertinoPushPage<T extends Object>(Widget widget) =>
      navigator.push<T>(CupertinoPageRoute(builder: (_) => widget));

  Future<R> pushPageWithMobx<T extends BaseViewmodel, R>(
    T mobx,
    Widget widget, {
    bool automaticDispose = false,
  }) =>
      navigator.push<R>(
        MaterialPageRoute(
          builder: (_) => MobxProvider<T>(
            viewmodel: mobx,
            child: widget,
            automaticDispose: automaticDispose,
          ),
        ),
      );

  Future<T> pushNamedAndRemoveUntil<T extends Object>(
    String newRouteName,
    RoutePredicate predicate, {
    Object arguments,
  }) =>
      navigator.pushNamedAndRemoveUntil<T>(
        newRouteName,
        predicate,
        arguments: arguments,
      );
}
