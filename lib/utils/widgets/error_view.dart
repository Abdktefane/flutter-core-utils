import 'package:core_sdk/utils/colors.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ErrorView extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;

  ErrorView({
    required this.errorMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              context.translate(errorMessage),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: DARK_GREY,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                fontFamily: Theme.of(context).textTheme.headline1!.fontFamily,
              ),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: PURPLE,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
              ),
              onPressed: onRetry,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    context.translate('lbl_retry'),
                    style: TextStyle(
                      color: WHITE,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: Theme.of(context).textTheme.headline1!.fontFamily,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  const Icon(Icons.refresh, color: WHITE, size: 24.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
