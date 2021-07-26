import 'package:core_sdk/utils/app_localizations.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'colors.dart';

showSnackBarMessage(
  ScaffoldState _scaffoldState,
  String message, {
  Color backgroundColor = DARK_GREY,
  Duration duration = const Duration(milliseconds: 2000),
}) {
  _scaffoldState.showSnackBar(
    new SnackBar(
      duration: duration,
      content: Text(
        message,
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: backgroundColor,
    ),
  );
}

Future showMessageDialog(BuildContext context, String message, {Function? onTap, bool dismissible = true}) async {
  await showDialog(
    context: context,
    barrierDismissible: dismissible,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(message),
        actions: [
          FlatButton(
            child: Text(AppLocalizations.of(context)!.translate('lbl_ok')!),
            onPressed: () {
              Navigator.pop(context);
              if (onTap != null) onTap();
            },
          ),
        ],
      );
    },
  );
}

Future showStatusDialog(
  BuildContext context,
  String message, {
  Function? onTap,
  bool isSuccess = true,
  bool dismissible = true,
  Color successIconColor = PURPLE,
}) async {
  final containerSize = MediaQuery.of(context).orientation == Orientation.portrait
      ? MediaQuery.of(context).size.width * 0.33
      : MediaQuery.of(context).size.height * 0.40;
  await showDialog(
    context: context,
    barrierDismissible: dismissible,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: WHITE,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: WHITE,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Icon(
                  isSuccess ? Icons.check_circle_outline : Icons.error_outline,
                  color: successIconColor,
                  size: containerSize - 48,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                context.translate(message),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),
              ),
              SizedBox(height: 24.0),
              SubmitButton(
                width: 0.4,
                onSubmit: () {
                  if (onTap != null) onTap();
                  Navigator.pop(context);
                },
                title: context.translate('lbl_ok'),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<void> showConfirmDialog(
  BuildContext context,
  String message,
  Function onConfirm, {
  TextStyle? textStyle,
  TextStyle? cancelButtonStyle,
  TextStyle? confirmButtonStyle,
}) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(
          message,
          style: textStyle ??
              TextStyle(
                color: DARK_GREY,
                fontSize: 16,
              ),
        ),
        actions: [
          FlatButton(
            child: Text(
              AppLocalizations.of(context)!.translate('lbl_cancel')!,
              style: cancelButtonStyle ??
                  TextStyle(
                    color: GREY,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FlatButton(
            autofocus: true,
            child: Text(
              AppLocalizations.of(context)!.translate('lbl_ok')!,
              style: confirmButtonStyle ??
                  TextStyle(
                    color: PURPLE,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
            ),
            onPressed: () {
              onConfirm();
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
