import 'package:core_sdk/utils/app_localizations.dart';
import 'package:core_sdk/utils/colors.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/widgets/submit_button.dart';
import 'package:flutter/material.dart';

class ResultView extends StatelessWidget {
  final String icon;
  final String title;
  final String resultTitle;
  final String resultDescription;
  final String primaryButtonTitle;
  final String secondaryButtonTitle;
  final VoidCallback onPrimaryButtonPressed;
  final VoidCallback onSecondaryButtonPressed;
  final bool showBackButton;

  ResultView({
    @required this.icon,
    this.title,
    this.resultTitle,
    this.resultDescription,
    this.primaryButtonTitle,
    this.secondaryButtonTitle,
    this.onPrimaryButtonPressed,
    this.onSecondaryButtonPressed,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final containerSize = MediaQuery.of(context).orientation == Orientation.portrait
        ? MediaQuery.of(context).size.width * 0.33
        : MediaQuery.of(context).size.height * 0.40;
    final textStyle = TextStyle(
      color: TEXT_COLOR,
      fontFamily: Theme.of(context).textTheme.headline1.fontFamily,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Visibility(
            visible: showBackButton,
            child: AppBar(
              leading: BackButton(
                color: PURPLE,
                onPressed: () => context.pop(),
              ),
              title: Text(
                localizations.translate(title) ?? '',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              backgroundColor: WHITE,
              elevation: 0.0,
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(24.0),
                    decoration: BoxDecoration(color: WHITE, borderRadius: BorderRadius.circular(12.0)),
                    child: Image.asset(
                      icon,
                      color: PURPLE,
                      width: containerSize - 48,
                      height: containerSize - 48,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Visibility(
                    visible: resultTitle != null,
                    child: Text(
                      localizations.translate(resultTitle).toString(),
                      style: textStyle.copyWith(fontSize: 22),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Visibility(
                    visible: resultDescription != null,
                    child: Container(
                      //padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        localizations.translate(resultDescription).toString(),
                        style: textStyle.copyWith(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: primaryButtonTitle != null,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: SubmitButton(
                title: localizations.translate(primaryButtonTitle).toString(),
                onSubmit: onPrimaryButtonPressed,
                borderRadius: 4.0,
                width: 0.9,
              ),
            ),
          ),
          Visibility(
            visible: secondaryButtonTitle != null,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: SubmitButton(
                title: localizations.translate(secondaryButtonTitle).toString(),
                onSubmit: onSecondaryButtonPressed,
                borderRadius: 4.0,
                width: 0.9,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
