import 'package:core_sdk/utils/colors.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//PS: to use this Dialog without exception the child should define width and height
class AnimatedDialog extends StatelessWidget {
  const AnimatedDialog({
    Key key,
    @required this.title,
    @required this.child,
    this.borderRadius = 15,
    this.elevation = 20,
  }) : super(key: key);

  final String title;
  final Widget child;
  final double borderRadius;
  final double elevation;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => context.pop(),
            icon: Icon(
              Icons.close,
              size: 30,
              color: PRIMARY,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: PRIMARY,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      elevation: elevation,
      content: child,
    );
  }

  static Future<R> show<R, T extends Cubit<Object>>(
    BuildContext context, {
    T bloc,
    Key key,
    @required String title,
    @required Widget child,
    double borderRadius = 15,
    double elevation = 20,
  }) async {
    return showGeneralDialog<R>(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, child) {
        final scaleTween = CurveTween(curve: Curves.fastOutSlowIn);
        final sclaeAnimation = scaleTween.animate(a1);
        return ScaleTransition(
          scale: sclaeAnimation,
          child: child,
        );
      },
      transitionDuration: Duration(milliseconds: 250),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (_, animation1, animation2) {
        return bloc == null
            ? AnimatedDialog(
                key: key,
                title: title,
                child: child,
                borderRadius: borderRadius,
                elevation: elevation,
              )
            : BlocProvider.value(
                value: context.read<T>(),
                child: AnimatedDialog(
                  key: key,
                  title: title,
                  child: child,
                  borderRadius: borderRadius,
                  elevation: elevation,
                ),
              );
      },
    );
  }
}
