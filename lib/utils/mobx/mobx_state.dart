import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';
import 'package:core_sdk/utils/colors.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/mobx/side_effect_mixin.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

abstract class MobxState<T extends StatefulWidget, V extends BaseViewmodel> extends State<T> with SideEffectMinxin {
  V? viewmodel;
  ThemeData? theme;
  TextTheme? textTheme;
  @override
  void initState() {
    super.initState();
    viewmodel = GetIt.I<V>();
    addContextHandlerDisposer(viewmodel!);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // TODO(abd): check if this not make error or we should try to put it in initState()
    addConnectionErroHandlerDisposer(viewmodel!, handler: connectionErroHandler);
    theme = context.theme;
    textTheme = theme?.textTheme;
  }

  @override
  void dispose() {
    disposeSideEffects();
    viewmodel?.dispose();
    super.dispose();
  }

  void connectionErroHandler(String errorMessage) {
    Fluttertoast.showToast(
      msg: context.translate(errorMessage),
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: DARK_GREY,
      textColor: WHITE,
      fontSize: 16.0,
    );
  }
}

abstract class ProviderMobxState<T extends StatefulWidget, V extends BaseViewmodel> extends State<T>
    with SideEffectMinxin {
  V? viewmodel;
  ThemeData? theme;
  TextTheme? textTheme;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    viewmodel = Provider.of<V>(context, listen: false);
    addContextHandlerDisposer(viewmodel!);
    addConnectionErroHandlerDisposer(viewmodel!, handler: connectionErroHandler);
    theme = context.theme;
    textTheme = theme?.textTheme;
  }

  @override
  void dispose() {
    disposeSideEffects();
    viewmodel?.dispose();
    super.dispose();
  }

  void connectionErroHandler(String errorMessage) {
    Fluttertoast.showToast(
      msg: context.translate(errorMessage),
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: DARK_GREY,
      textColor: WHITE,
      fontSize: 16.0,
    );
  }
}
